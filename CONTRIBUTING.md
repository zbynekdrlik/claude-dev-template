# Contributing to Claude Development Template

Thank you for your interest in contributing! This guide will help you get started.

## Getting Started

### Prerequisites
- Node.js 16+ or Python 3.8+
- Git
- Anthropic API key

### Setup
1. Fork the repository
2. Clone your fork:
   ```bash
   git clone https://github.com/yourusername/claude-dev-template.git
   cd claude-dev-template
   ```
3. Install dependencies:
   ```bash
   # For Node.js
   npm install
   
   # For Python
   pip install -r requirements.txt
   ```
4. Set up environment:
   ```bash
   cp .env.example .env
   # Add your API key to .env
   ```

## Types of Contributions

### 1. Prompt Templates
- Add new prompt templates in `config/prompts/`
- Follow the existing format and structure
- Include clear instructions and examples
- Test prompts before submitting

### 2. Code Examples
- Add practical examples in `src/examples/`
- Include both JavaScript and Python versions when possible
- Document expected outputs
- Cover different use cases and scenarios

### 3. Documentation
- Improve README and guide clarity
- Add missing API documentation
- Create tutorials and how-to guides
- Fix typos and formatting issues

### 4. Bug Fixes
- Fix issues in client code
- Improve error handling
- Address performance problems
- Update dependencies

### 5. New Features
- Extend client functionality
- Add new helper methods
- Improve configuration options
- Add testing utilities

## Development Guidelines

### Code Style

**JavaScript:**
- Use ES6+ features
- 2-space indentation
- Semicolons required
- Clear variable names
- JSDoc comments for functions

**Python:**
- Follow PEP 8
- 4-space indentation
- Type hints required
- Docstrings for all functions
- Use async/await for API calls

### Testing
- Test all new functionality
- Update existing tests when needed
- Run the test suite before submitting:
  ```bash
  npm test  # or python -m pytest
  ```
- Include test cases for edge cases

### Documentation
- Update README for new features
- Add inline code comments
- Include usage examples
- Update API documentation

## Submission Process

### 1. Create a Branch
```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/bug-description
```

### 2. Make Changes
- Follow the coding guidelines
- Write tests for new functionality
- Update documentation
- Test your changes thoroughly

### 3. Commit Changes
```bash
git add .
git commit -m "feat: add new prompt template for API design"
```

**Commit Message Format:**
- `feat:` for new features
- `fix:` for bug fixes
- `docs:` for documentation changes
- `test:` for test additions/changes
- `refactor:` for code refactoring
- `style:` for formatting changes

### 4. Test Everything
```bash
# Run tests
npm test

# Test examples
npm start

# Lint code
npm run lint
```

### 5. Push and Create PR
```bash
git push origin feature/your-feature-name
```

Then create a Pull Request on GitHub with:
- Clear title and description
- Reference any related issues
- Screenshots/examples if applicable
- List of changes made

## Pull Request Guidelines

### PR Title Format
- `feat(scope): description` for features
- `fix(scope): description` for fixes
- `docs(scope): description` for docs

### PR Description Template
```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Code refactoring

## Testing
- [ ] Tests pass
- [ ] Examples work
- [ ] Documentation updated

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Comments added to complex code
- [ ] Tests added/updated
- [ ] Documentation updated
```

## Prompt Template Guidelines

### Structure
```markdown
# Template Title

Brief description of what this template does.

## Instructions
Clear instructions for Claude including:
- Context and role
- Specific requirements
- Output format
- Constraints

## Variables
List any placeholders:
- [VARIABLE_NAME]: Description

## Example Usage
Show how to use the template

---

**Template for:**
[INSERT CONTENT HERE]
```

### Best Practices
- Be specific and clear
- Include examples
- Test with real scenarios
- Consider edge cases
- Make templates reusable

## Code Review Process

### What We Look For
- **Correctness**: Does the code work as intended?
- **Quality**: Is it readable and maintainable?
- **Testing**: Are there adequate tests?
- **Documentation**: Is it properly documented?
- **Performance**: Are there any performance issues?
- **Security**: Are there security considerations?

### Review Checklist
- [ ] Code is well-structured
- [ ] Error handling is appropriate
- [ ] Tests cover new functionality
- [ ] Documentation is updated
- [ ] No breaking changes (or properly documented)
- [ ] Follows project conventions

## Getting Help

### Questions?
- Check existing issues and discussions
- Create a new issue for bugs
- Start a discussion for questions
- Review the documentation

### Communication
- Be respectful and constructive
- Provide context and examples
- Ask for clarification when needed
- Share your use cases

## Recognition

Contributors will be:
- Listed in the README
- Credited in release notes
- Recognized in the community

Thank you for contributing to making Claude development better for everyone!

---

**Questions?** Open an issue or start a discussion!