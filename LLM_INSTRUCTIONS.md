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
  - **CRITICAL**: Version must be logged/printed on startup for verification
  - Show new version in LLM chat after each change
  - PATCH (x.x.Z): Bug fixes, minor changes, iterations within a phase
  - MINOR (x.Y.x): New features, completing a phase implementation
  - MAJOR (X.x.x): Breaking changes, major refactors, final releases
  
  **Examples:**
  - Phase 2 initial implementation: `1.0.0` → `1.1.0` (MINOR for new phase)
  - Bug fix during Phase 2 testing: `1.1.0` → `1.1.1` (PATCH for iteration)
  - Another iteration in Phase 2: `1.1.1` → `1.1.2` (PATCH for iteration)
  - Phase 3 implementation: `1.1.2` → `1.2.0` (MINOR for new phase)
  - Major refactoring: `1.9.0` → `2.0.0` (MAJOR for architecture change)

- **Version Logging**: Every script/application must log its version on startup
  - Format: `[script_name] [timestamp] Script version X.Y.Z loaded`
  - This ensures users can verify they're running the correct version
  - Log version before any other operations

- Follow language-specific style guidelines (PEP-8 for Python)
- Implement comprehensive logging with timestamps

### Testing & Approval Workflow
1. Make changes in feature branch
2. User runs application/tests
3. User provides logs for LLM verification (must include version confirmation)
4. Await explicit user approval before PR merge
5. Only merge after successful testing

### Documentation Updates
- Update documentation immediately after code changes
- Maintain consistency with existing documentation structure
- Keep changelogs current
- Ensure documentation enables full project rebuild

### Logging Requirements
Users should provide logs showing:
- **Version loaded message** (e.g., `Script version X.Y.Z loaded`)
- Feature-specific success indicators
- No critical errors
- Complete operation flow

**Example log output:**
```
[app.py] [2025-06-27 12:00:00] Script version 1.2.3 loaded
[app.py] [2025-06-27 12:00:01] Configuration loaded successfully
[app.py] [2025-06-27 12:00:02] Feature X initialized
[app.py] [2025-06-27 12:00:03] Operation completed successfully
```

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
- [ ] Version logging implemented on startup
- [ ] PR created/updated
- [ ] Tests passed with logs provided (including version verification)
- [ ] User approved changes
- [ ] Documentation updated
- [ ] Changelog/history maintained

## Key Principles
1. **Branch Protection**: Never work directly on main
2. **Immediate PR Creation**: Create PR when starting work
3. **Version Transparency**: Show version changes in chat AND log on startup
4. **Documentation First**: Keep docs in sync with code
5. **User Verification**: Always get logs and approval
6. **Project Consistency**: Follow existing patterns