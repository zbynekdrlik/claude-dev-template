# LLM Development Instructions

## Thread Initialization
1. **Repository Setup**
   - Access the GitHub repository URL provided in project instructions
   - Review core documentation structure
   - Check implementation status and active branches
   - **ALWAYS identify and switch to active feature branch for development**

2. **Documentation Review**
   - Identify documentation pattern (e.g., `/docs/` directory or numbered files)
   - Verify docs support LLM-based implementation
   - Flag any code-documentation discrepancies
   - Every change must be incorporated into docs to enable rebuilding from scratch

## Development Rules

### Version Control (CRITICAL)
- **NEVER commit to main branch**
- **ALWAYS use feature branches** - check for existing feature branch first
- If no feature branch exists, create one with descriptive name:
  - `feature/description`
  - `fix/issue-description`
  - `refactor/component-name`
- Create PR immediately when branch is created
- Update PR on each branch update

### Code Development
- **Version Management**: Increment version with EVERY code change
  - Show new version in LLM chat after each change
  - PATCH (x.x.Z): Bug fixes, minor changes, iterations
  - MINOR (x.Y.x): New features, completions
  - MAJOR (X.x.x): Breaking changes, major refactors
- Follow language-specific style guidelines (PEP-8 for Python)
- Implement comprehensive logging with timestamps

### Testing & Approval Workflow
1. Make changes in feature branch
2. User runs application/tests
3. User provides logs for LLM verification
4. Await explicit user approval before PR merge
5. Only merge after successful testing

### Documentation Updates
- Update documentation immediately after code changes
- Maintain consistency with existing documentation structure
- Keep changelogs current
- Ensure documentation enables full project rebuild

### Logging Requirements
Users should provide logs showing:
- Version loaded/startup message
- Feature-specific success indicators
- No critical errors
- Complete operation flow

## Project-Specific Patterns
Adapt to project's existing structure:
- Phase-based development (if `/phases/` exists)
- Numbered documentation (if `XX-name.md` pattern)
- Standard directories (if `/docs/` structure)
- Integration requirements (MCP, API, etc.)

## Quick Checklist
- [ ] Using feature branch (not main)
- [ ] Following project documentation structure
- [ ] Version incremented and shown in chat
- [ ] PR created/updated
- [ ] Tests passed with logs provided
- [ ] User approved changes
- [ ] Documentation updated
- [ ] Changelog/history maintained

## Key Principles
1. **Branch Protection**: Never work directly on main
2. **Immediate PR Creation**: Create PR when starting work
3. **Version Transparency**: Show version changes in chat
4. **Documentation First**: Keep docs in sync with code
5. **User Verification**: Always get logs and approval
6. **Project Consistency**: Follow existing patterns