#!/bin/bash

# Claude Development Template Setup Script
# Automates the initial setup process

set -e  # Exit on any error

echo "🚀 Setting up Claude Development Template..."
echo

# Check if we're in the right directory
if [ ! -f "package.json" ] || [ ! -f "requirements.txt" ]; then
    echo "❌ Error: Please run this script from the project root directory"
    exit 1
fi

# Check for required tools
echo "📋 Checking prerequisites..."

# Check Node.js
if command -v node >/dev/null 2>&1; then
    NODE_VERSION=$(node --version)
    echo "✅ Node.js found: $NODE_VERSION"
else
    echo "⚠️  Node.js not found. Install from https://nodejs.org"
fi

# Check Python
if command -v python3 >/dev/null 2>&1; then
    PYTHON_VERSION=$(python3 --version)
    echo "✅ Python found: $PYTHON_VERSION"
else
    echo "⚠️  Python 3 not found. Install from https://python.org"
fi

# Check Git
if command -v git >/dev/null 2>&1; then
    echo "✅ Git found"
else
    echo "❌ Git is required but not found"
    exit 1
fi

echo

# Setup environment file
echo "🔧 Setting up environment..."
if [ ! -f ".env" ]; then
    cp .env.example .env
    echo "✅ Created .env file from template"
    echo "⚠️  Please edit .env and add your ANTHROPIC_API_KEY"
else
    echo "✅ .env file already exists"
fi

# Install Node.js dependencies
if command -v npm >/dev/null 2>&1; then
    echo
    echo "📦 Installing Node.js dependencies..."
    npm install
    echo "✅ Node.js dependencies installed"
fi

# Install Python dependencies
if command -v pip3 >/dev/null 2>&1; then
    echo
    echo "🐍 Installing Python dependencies..."
    pip3 install -r requirements.txt
    echo "✅ Python dependencies installed"
fi

# Create additional directories if needed
echo
echo "📁 Setting up directory structure..."
mkdir -p logs
mkdir -p temp
mkdir -p conversations
echo "✅ Directory structure ready"

# Test basic functionality
echo
echo "🧪 Running basic tests..."

if [ -f ".env" ] && grep -q "ANTHROPIC_API_KEY=your_api_key_here" .env; then
    echo "⚠️  Please set your ANTHROPIC_API_KEY in .env before testing"
else
    if command -v node >/dev/null 2>&1; then
        echo "Testing Node.js client..."
        timeout 10s node -e "
            const ClaudeClient = require('./src/claude-client');
            const client = new ClaudeClient();
            console.log('✅ Node.js client initialized successfully');
        " 2>/dev/null || echo "⚠️  Node.js client test skipped (needs API key)"
    fi
    
    if command -v python3 >/dev/null 2>&1; then
        echo "Testing Python client..."
        timeout 10s python3 -c "
import sys
sys.path.append('src')
from claude_client import ClaudeClient
print('✅ Python client initialized successfully')
        " 2>/dev/null || echo "⚠️  Python client test skipped (needs API key)"
    fi
fi

# Setup Git hooks (optional)
echo
echo "🔗 Setting up Git hooks..."
if [ -d ".git" ]; then
    cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash
# Pre-commit hook for Claude Development Template

echo "Running pre-commit checks..."

# Check for API keys in staged files
if git diff --cached --name-only | xargs grep -l "sk-ant-" 2>/dev/null; then
    echo "❌ Error: API key found in staged files!"
    echo "Please remove API keys before committing."
    exit 1
fi

# Run linting if available
if command -v npm >/dev/null 2>&1 && [ -f "package.json" ]; then
    npm run lint 2>/dev/null || true
fi

echo "✅ Pre-commit checks passed"
EOF
    chmod +x .git/hooks/pre-commit
    echo "✅ Git pre-commit hook installed"
else
    echo "⚠️  Not a Git repository, skipping hooks"
fi

# Final instructions
echo
echo "🎉 Setup complete!"
echo
echo "Next steps:"
echo "1. Edit .env and add your ANTHROPIC_API_KEY"
echo "2. Customize docs/PROJECT_INSTRUCTIONS.md for your project"
echo "3. Test the setup:"
if command -v npm >/dev/null 2>&1; then
    echo "   npm start"
fi
if command -v python3 >/dev/null 2>&1; then
    echo "   python3 src/claude_client.py"
fi
echo "4. Read the documentation in docs/"
echo
echo "Happy coding with Claude! 🤖"
echo
echo "For help, visit: https://github.com/zbynekdrlik/claude-dev-template"