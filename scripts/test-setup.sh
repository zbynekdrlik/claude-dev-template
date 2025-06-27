#!/bin/bash

# Test Setup Script
# Validates that the Claude Development Template is properly configured

set -e

echo "🧪 Testing Claude Development Template Setup..."
echo

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test results
PASSED=0
FAILED=0
WARNING=0

# Helper functions
pass() {
    echo -e "${GREEN}✅ PASS${NC}: $1"
    ((PASSED++))
}

fail() {
    echo -e "${RED}❌ FAIL${NC}: $1"
    ((FAILED++))
}

warn() {
    echo -e "${YELLOW}⚠️  WARN${NC}: $1"
    ((WARNING++))
}

# Test 1: Directory structure
echo "Testing directory structure..."
for dir in "docs" "config" "src" "tests" "config/prompts"; do
    if [ -d "$dir" ]; then
        pass "Directory $dir exists"
    else
        fail "Directory $dir missing"
    fi
done

# Test 2: Required files
echo
echo "Testing required files..."
for file in "README.md" "package.json" "requirements.txt" ".env.example" ".gitignore" "LICENSE"; do
    if [ -f "$file" ]; then
        pass "File $file exists"
    else
        fail "File $file missing"
    fi
done

# Test 3: Configuration files
echo
echo "Testing configuration files..."
for file in "config/claude-config.json" "docs/PROJECT_INSTRUCTIONS.md" "docs/API_GUIDELINES.md"; do
    if [ -f "$file" ]; then
        pass "Config file $file exists"
    else
        fail "Config file $file missing"
    fi
done

# Test 4: Prompt templates
echo
echo "Testing prompt templates..."
for template in "code-review" "documentation" "debugging"; do
    if [ -f "config/prompts/$template.md" ]; then
        pass "Prompt template $template.md exists"
    else
        fail "Prompt template $template.md missing"
    fi
done

# Test 5: Source code files
echo
echo "Testing source code files..."
for file in "src/claude-client.js" "src/claude_client.py" "src/examples/basic-usage.js"; do
    if [ -f "$file" ]; then
        pass "Source file $file exists"
    else
        fail "Source file $file missing"
    fi
done

# Test 6: Environment setup
echo
echo "Testing environment setup..."
if [ -f ".env" ]; then
    if grep -q "ANTHROPIC_API_KEY=your_api_key_here" .env; then
        warn "API key not configured in .env"
    elif grep -q "ANTHROPIC_API_KEY=" .env; then
        pass "API key configured in .env"
    else
        fail "Invalid .env format"
    fi
else
    warn ".env file not created (copy from .env.example)"
fi

# Test 7: Dependencies
echo
echo "Testing dependencies..."

# Node.js dependencies
if [ -f "package.json" ]; then
    if [ -d "node_modules" ]; then
        pass "Node.js dependencies installed"
        # Test specific packages
        if [ -d "node_modules/@anthropic-ai" ]; then
            pass "Anthropic SDK installed"
        else
            fail "Anthropic SDK missing"
        fi
    else
        warn "Node.js dependencies not installed (run: npm install)"
    fi
fi

# Python dependencies
if command -v python3 >/dev/null 2>&1; then
    if python3 -c "import anthropic" 2>/dev/null; then
        pass "Python Anthropic SDK available"
    else
        warn "Python Anthropic SDK not installed (run: pip install -r requirements.txt)"
    fi
else
    warn "Python 3 not available"
fi

# Test 8: File permissions
echo
echo "Testing file permissions..."
for script in "scripts/setup.sh" "scripts/test-setup.sh"; do
    if [ -f "$script" ]; then
        if [ -x "$script" ]; then
            pass "Script $script is executable"
        else
            warn "Script $script is not executable (run: chmod +x $script)"
        fi
    fi
done

# Test 9: JSON syntax
echo
echo "Testing JSON syntax..."
for json_file in "package.json" "config/claude-config.json"; do
    if [ -f "$json_file" ]; then
        if python3 -c "import json; json.load(open('$json_file'))" 2>/dev/null; then
            pass "$json_file has valid JSON syntax"
        else
            fail "$json_file has invalid JSON syntax"
        fi
    fi
done

# Test 10: API connectivity (if configured)
echo
echo "Testing API connectivity..."
if [ -f ".env" ] && ! grep -q "your_api_key_here" .env; then
    echo "API key found, testing connection..."
    
    # Test Node.js client
    if command -v node >/dev/null 2>&1 && [ -d "node_modules" ]; then
        if timeout 10s node -e "
            require('dotenv').config();
            const ClaudeClient = require('./src/claude-client');
            const client = new ClaudeClient();
            client.complete({
                prompt: 'Say hello',
                max_tokens: 10
            }).then(() => {
                console.log('API connection successful');
                process.exit(0);
            }).catch(err => {
                console.error('API connection failed:', err.message);
                process.exit(1);
            });
        " 2>/dev/null; then
            pass "Node.js API connection successful"
        else
            fail "Node.js API connection failed"
        fi
    fi
    
    # Test Python client
    if command -v python3 >/dev/null 2>&1; then
        if timeout 10s python3 -c "
import asyncio
import sys
sys.path.append('src')
from dotenv import load_dotenv
load_dotenv()
from claude_client import ClaudeClient

async def test():
    try:
        client = ClaudeClient()
        response = await client.complete('Say hello', max_tokens=10)
        print('API connection successful')
        return True
    except Exception as e:
        print(f'API connection failed: {e}')
        return False

if asyncio.run(test()):
    exit(0)
else:
    exit(1)
        " 2>/dev/null; then
            pass "Python API connection successful"
        else
            fail "Python API connection failed"
        fi
    fi
else
    warn "API key not configured, skipping connectivity test"
fi

# Summary
echo
echo "==========================================="
echo "TEST SUMMARY"
echo "==========================================="
echo -e "${GREEN}Passed: $PASSED${NC}"
echo -e "${YELLOW}Warnings: $WARNING${NC}"
echo -e "${RED}Failed: $FAILED${NC}"
echo

if [ $FAILED -eq 0 ]; then
    if [ $WARNING -eq 0 ]; then
        echo -e "${GREEN}🎉 All tests passed! Your setup is perfect.${NC}"
        exit 0
    else
        echo -e "${YELLOW}✅ Setup is functional but has warnings.${NC}"
        echo "Consider addressing the warnings for optimal experience."
        exit 0
    fi
else
    echo -e "${RED}❌ Setup has issues that need to be fixed.${NC}"
    echo "Please address the failed tests before proceeding."
    exit 1
fi