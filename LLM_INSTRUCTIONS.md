# LLM Development Instructions

## Thread Initialization
1. **Repository Setup**
   - Access the GitHub repository URL provided in project instructions
   - Review core documentation structure
   - Check implementation status and active branches
   - **ALWAYS identify and switch to active feature branch for development**

2. **Thread Continuity Check** (CRITICAL)
   - **IMMEDIATELY check for `THREAD_PROGRESS.md` in the repository**
   - **Read the "CRITICAL CURRENT STATE" section FIRST**
   - **DO NOT assume tasks are complete without test logs proving it**
   - If exists, read it COMPLETELY to understand:
     - Current project state and active branch
     - Work completed in previous threads
     - Current tasks and blockers
     - Next steps identified by previous thread
   - If starting fresh thread on existing project without this file, create it
   - Update throughout the session and especially before thread limit

3. **Documentation Review**
   - Identify documentation pattern (e.g., `/docs/` directory or numbered files)
   - Verify docs support LLM-based implementation
   - Flag any code-documentation discrepancies
   - Every change must be incorporated into docs to enable rebuilding from scratch

4. **Rules Directory Check**
   - Check if repository contains a `/rules/` directory
   - If `/rules/` exists, read ALL documents from it using the **active feature branch**
   - **IMPORTANT**: Always read rules from the feature branch you're working on, not from main
   - Incorporate all rules into the development process
   - Rules override or supplement these general instructions

## Thread Continuity Protocol (CRITICAL)

### On Thread Start - MANDATORY CHECKS:
1. Read THREAD_PROGRESS.md COMPLETELY
2. Check "CRITICAL CURRENT STATE" section at the top
3. Look for "Waiting for:" and "Currently working on:" entries
4. DO NOT make assumptions about completion
5. If testing was in progress, ALWAYS assume it's incomplete unless logs prove otherwise

### Status Verification Questions:
- Was the last task IMPLEMENTED or TESTED?
- If implemented, were logs provided showing it works?
- If testing started, which specific tests passed/failed?
- What was the user's last action/response?

### Recovery Pattern:
```
IF no clear status:
   ASK: "I see we were working on [X]. Did you complete testing? 
         Can you provide the logs from the last session?"
ELSE:
   CONTINUE from exact stopping point
```

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

### Thread Progress Management

#### THREAD_PROGRESS.md Structure (MANDATORY)
```markdown
# Thread Progress Tracking

## CRITICAL CURRENT STATE
**⚠️ EXACTLY WHERE WE ARE RIGHT NOW:**
- [ ] Currently working on: [SPECIFIC TASK]
- [ ] Waiting for: [USER ACTION/LOGS/DECISION]
- [ ] Blocked by: [ANY BLOCKERS]

## Implementation Status
- Phase: [NUMBER] - [NAME]
- Step: [SPECIFIC STEP IN PHASE]
- Status: [PLANNING/IMPLEMENTING/TESTING/BLOCKED/COMPLETE]

## Testing Status Matrix
| Component | Implemented | Unit Tested | Integration Tested | Multi-Instance Tested | 
|-----------|------------|-------------|--------------------|-----------------------|
| Script A  | ✅ v1.2.3  | ❌          | ❌                 | ❌                    |
| Script B  | ✅ v2.3.4  | ✅          | ❌                 | ❌                    |

## Last User Action
- Date/Time: [TIMESTAMP]
- Action: [WHAT USER DID]
- Result: [OUTCOME/LOGS PROVIDED]
- Next Required: [WHAT'S NEEDED FROM USER]
```

#### Update Requirements
- **Update `THREAD_PROGRESS.md` regularly**:
  - After completing significant tasks
  - When encountering blockers or decisions
  - Before context switches
  - **MANDATORY before approaching thread limit**
- Include in updates:
  - Completed work with specific details
  - Current state of implementation
  - Any pending user decisions
  - Clear next steps for continuation
- Commit this file to the feature branch regularly

### Testing Progress Documentation

**Testing State Machine - Use these clear states:**
- `IMPLEMENTED_NOT_TESTED` - Code written, no tests run
- `TESTING_STARTED` - Some tests run, not complete  
- `TESTING_FAILED` - Tests run, issues found
- `TESTING_PARTIAL` - Some tests passed, others pending
- `TESTING_COMPLETE` - All tests passed with logs
- `PRODUCTION_READY` - Tested and user approved

**NEVER mark a feature as complete without test logs showing:**
1. Version number logged on startup
2. Feature-specific success indicators  
3. No critical errors
4. Expected behavior confirmed

**Testing Phases:**
1. **Unit Testing**: Individual component works
2. **Integration Testing**: Component works with others
3. **System Testing**: Full workflow functions
4. **Multi-Instance Testing**: Works with multiple connections

**Update THREAD_PROGRESS.md after EACH test with:**
- Component tested
- Test type (unit/integration/system/multi)
- Pass/Fail status
- Log snippets proving status
- Issues found
- Next test required

### Phase Transition Rules

**NEVER move to next phase without:**
1. ✅ All implementation complete
2. ✅ All tests passed with logs
3. ✅ User explicitly confirms ready to proceed
4. ✅ THREAD_PROGRESS.md shows all checkboxes complete

**Phase Completion Checklist:**
- [ ] Implementation complete (version logged)
- [ ] Unit tests passed (logs provided)
- [ ] Integration tests passed (logs provided)
- [ ] Documentation updated
- [ ] User approved results
- [ ] Ready for next phase confirmed

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

#### README Maintenance (CRITICAL)
- **Review and update README.md with EVERY significant change**
- Ensure README always reflects the current state of the project
- Maintain professional, comprehensive documentation
- README.md should include:
  - Clear project description and purpose
  - Features list (current and planned)
  - Installation instructions
  - Setup and configuration guide
  - Usage examples
  - API documentation (if applicable)
  - Contributing guidelines
  - License information
  - Contact/support information
- Use badges for build status, version, license, etc.
- Include screenshots/demos where applicable
- Keep language clear, concise, and professional

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

## Context Loss Prevention

### Every significant action requires:
1. Update THREAD_PROGRESS.md IMMEDIATELY
2. Include specific details:
   - Exact file modified
   - Version number changed to
   - Specific function/feature affected
   - Test status for that change
   
### Before thread limit approaching:
1. Update "CRITICAL CURRENT STATE" with exact position
2. List any pending user actions needed
3. Document any decisions waiting
4. Create clear handoff notes

## Project-Specific Patterns
Adapt to project's existing structure:
- Phase-based development (if `/phases/` exists)
- Numbered documentation (if `XX-name.md` pattern)
- Standard directories (if `/docs/` structure)
- Integration requirements (MCP, API, etc.)
- Project-specific rules (if `/rules/` directory exists)

## Quick Checklist
- [ ] Checked and updated `THREAD_PROGRESS.md`
- [ ] Read "CRITICAL CURRENT STATE" section first
- [ ] Verified implementation vs testing status
- [ ] Using feature branch (not main)
- [ ] Following project documentation structure
- [ ] Checked and read all rules from `/rules/` directory (if exists)
- [ ] Version incremented and shown in chat
- [ ] Version logging implemented on startup
- [ ] PR created/updated
- [ ] Tests passed with logs provided (including version verification)
- [ ] User approved changes
- [ ] Documentation updated
- [ ] **README.md reviewed and updated**
- [ ] Changelog/history maintained
- [ ] Thread progress documented for next session

## Key Principles
1. **Branch Protection**: Never work directly on main
2. **Immediate PR Creation**: Create PR when starting work
3. **Version Transparency**: Show version changes in chat AND log on startup
4. **Documentation First**: Keep docs in sync with code
5. **User Verification**: Always get logs and approval
6. **Testing is Not Complete Until Logs Prove It**: Implementation ≠ Working
7. **Never Assume Completion Without Proof**: Always verify with test logs
8. **Always Pick Up EXACTLY Where Left Off**: Read thread progress carefully
9. **Project Consistency**: Follow existing patterns
10. **Rules Priority**: Project-specific rules in `/rules/` take precedence
11. **README Excellence**: Maintain professional, comprehensive README
12. **Thread Continuity**: Always maintain context across conversation threads
13. **When in Doubt, Ask for Status/Logs**: Don't assume, verify