# Quick Start Guide

Get up and running with Claude Development Template in 5 minutes.

## 1. Setup

### Clone the Repository
```bash
git clone https://github.com/zbynekdrlik/claude-dev-template.git
cd claude-dev-template
```

### Install Dependencies

**For JavaScript:**
```bash
npm install
```

**For Python:**
```bash
pip install -r requirements.txt
```

### Configure Environment
```bash
cp .env.example .env
```

Edit `.env` and add your Anthropic API key:
```
ANTHROPIC_API_KEY=your_api_key_here
```

## 2. First Test

### JavaScript
```bash
node src/examples/basic-usage.js
```

### Python
```bash
python src/claude_client.py
```

You should see Claude generate a simple function with explanation.

## 3. Basic Usage

### JavaScript Example
```javascript
const ClaudeClient = require('./src/claude-client');
require('dotenv').config();

const claude = new ClaudeClient();

async function example() {
  const response = await claude.complete({
    prompt: 'Create a REST API endpoint for user authentication',
    temperature: 0.3
  });
  
  console.log(response.content);
}

example();
```

### Python Example
```python
import asyncio
from src.claude_client import ClaudeClient
from dotenv import load_dotenv

load_dotenv()

async def example():
    client = ClaudeClient()
    
    response = await client.complete(
        prompt='Create a REST API endpoint for user authentication',
        temperature=0.3
    )
    
    print(response['content'])

asyncio.run(example())
```

## 4. Common Tasks

### Code Review
```javascript
const result = await claude.reviewCode(`
  function getUserData(id) {
    return "SELECT * FROM users WHERE id = " + id;
  }
`);
console.log(result.content);
```

### Generate Documentation
```javascript
const docs = await claude.generateDocs(`
  class UserService {
    async createUser(userData) {
      // Implementation here
    }
  }
`);
console.log(docs.content);
```

### Debug Code
```javascript
const fix = await claude.debugCode(
  'async function getData() { return fetch("/api").json(); }',
  'Function returns Promise instead of data',
  'TypeError: Cannot read property json of undefined'
);
console.log(fix.content);
```

## 5. Custom Prompts

### Load Template
```javascript
const template = await claude.loadPrompt('code-review');
const customPrompt = template.replace('[INSERT CODE HERE]', yourCode);
const result = await claude.complete({ prompt: customPrompt });
```

### Project Context
```javascript
const context = `
  This is a Node.js Express API with MongoDB.
  We use JWT for authentication and follow REST conventions.
`;

const response = await claude.complete({
  prompt: 'Create a middleware for request logging',
  context: context
});
```

## 6. Configuration

### Custom Model Settings
```javascript
const claude = new ClaudeClient({
  configPath: './my-config.json'
});

// Or override per request
const response = await claude.complete({
  prompt: 'Your prompt',
  model: 'claude-opus-4',
  temperature: 0.1,
  max_tokens: 2000
});
```

### Config File (`config/claude-config.json`)
```json
{
  "model": "claude-sonnet-4-20250514",
  "max_tokens": 4000,
  "temperature": 0.7,
  "system_prompt": "You are an expert developer...",
  "retry_attempts": 3
}
```

## 7. Testing

### Run Tests
```bash
npm test  # or python -m pytest
```

### Custom Test
```javascript
const { PromptTester } = require('./tests/prompt-tests');

const tester = new PromptTester();
const result = await tester.runTest({
  name: 'My Test',
  prompt: 'Create a validation function',
  expectedKeywords: ['function', 'validation', 'return']
});
```

## 8. Best Practices

### Prompt Engineering
- Be specific and clear
- Provide context and examples
- Set appropriate temperature (0.1-0.3 for code, 0.7 for creative)
- Use system prompts for role definition

### Error Handling
```javascript
try {
  const response = await claude.complete({ prompt: 'Your prompt' });
  console.log(response.content);
} catch (error) {
  if (error.message.includes('Rate limit')) {
    // Handle rate limiting
    await delay(1000);
    // Retry logic
  }
  console.error('Error:', error.message);
}
```

### Token Management
```javascript
const response = await claude.complete({
  prompt: 'Your prompt',
  max_tokens: 1000  // Adjust based on needs
});

console.log(`Tokens used: ${response.usage.output_tokens}`);
```

## 9. Next Steps

1. **Customize PROJECT_INSTRUCTIONS.md** for your specific project
2. **Create custom prompt templates** in `config/prompts/`
3. **Add your own examples** in `src/examples/`
4. **Set up CI/CD** for automated testing
5. **Integrate with your development workflow**

## 10. Troubleshooting

### Common Issues

**API Key Error:**
```
Error: Anthropic API key is required
```
- Check `.env` file exists and has correct key
- Verify key is valid and has sufficient credits

**Rate Limiting:**
```
Error: Rate limit exceeded
```
- Reduce request frequency
- Implement exponential backoff
- Check your API plan limits

**Module Not Found:**
```
Error: Cannot find module '@anthropic-ai/sdk'
```
- Run `npm install` or `pip install -r requirements.txt`
- Check Node.js/Python version compatibility

### Getting Help
- Check the [full documentation](./README.md)
- Review [examples](../src/examples/)
- Open an issue on GitHub
- Check Anthropic's [API documentation](https://docs.anthropic.com)

---

**Ready to start building with Claude!** 🚀

For more advanced usage, see the complete [documentation](./README.md) and [examples](../src/examples/).