# LLM Development Instructions

## Thread Initialization
1. **Repository Setup** - Access repo, check branches, switch to active feature branch
2. **Thread Continuity** - Read THREAD_PROGRESS.md if exists for context
3. **Task Management** - Check Todo.md for pending tasks
4. **Documentation** - Review docs structure and DESIGN_PHILOSOPHY.md if present
5. **Rules Check** - Read /rules/ directory if exists (from feature branch)

## Critical Behaviors
- **Be critical** - Don't trust partial success indicators
- **No unauthorized files** - Never create git files without user approval  
- **Design consistency** - Always check changes against DESIGN_PHILOSOPHY.md
- **Task tracking** - Use Todo.md for tasks (one line each), THREAD_PROGRESS.md for thread state

## Development Rules

### Version Control
- NEVER commit to main
- Use feature branches: `feature/`, `fix/`, `refactor/`
- Create PR immediately, update regularly

### Code Development  
- **Version**: Increment EVERY change (x.x.Z patch, x.Y.x minor, X.x.x major)
- **Log version** on startup: `[script] [timestamp] Version X.Y.Z loaded`
- Show new version in chat after changes
- Follow language style guides

### Thread Management
- Update THREAD_PROGRESS.md: after major tasks, before thread limit
- Update Todo.md: add new tasks, remove completed ones (one line per task)
- Keep both files in feature branch

### Testing & Approval
1. Changes in feature branch
2. User runs tests  
3. User provides logs (with version)
4. Await approval before merge

### Documentation
- Update docs immediately after code changes
- **README.md** must reflect current state with all standard sections
- Maintain changelogs

## Quick Checklist
- [ ] Feature branch active
- [ ] THREAD_PROGRESS.md checked/updated
- [ ] Todo.md updated
- [ ] Version incremented  
- [ ] PR created/updated
- [ ] Tests passed with logs
- [ ] Docs and README updated
- [ ] DESIGN_PHILOSOPHY.md compliance checked

## Key Principles
1. **Branch Protection** - Never touch main
2. **Immediate PR** - Create when starting
3. **Version Transparency** - Show & log changes
4. **Documentation First** - Keep in sync
5. **User Verification** - Always get approval
6. **Design Consistency** - Follow philosophy
7. **Critical Thinking** - Verify thoroughly
8. **Task Organization** - Todo.md for tasks, THREAD_PROGRESS.md for state