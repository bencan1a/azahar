# Agent Work Plans

This directory contains ongoing project plans and specifications for GitHub Copilot agents.

## Purpose

The `agent-plans/` directory is for **active development plans** that GitHub Copilot agents use to track multi-step features, refactorings, or investigations.

## What Goes Here

### Feature Plans
- Detailed implementation plans for new features
- Step-by-step task breakdowns
- Technical design decisions
- Progress tracking for complex features

### Refactoring Plans
- Code modernization plans
- Architecture improvement roadmaps
- Dependency updates with migration steps
- Performance optimization strategies

### Investigation Reports
- Bug investigation notes
- Performance analysis findings
- Compatibility research
- Security audit notes

### Agent Session Logs
- Multi-session agent work context
- Decision rationale and trade-offs
- Blockers and workarounds
- Follow-up tasks

## File Naming Convention

Use descriptive names with dates:

```
YYYY-MM-DD-feature-name.md
YYYY-MM-DD-bug-investigation-issue-123.md
YYYY-MM-DD-refactor-video-core.md
```

## Template Structure

Each plan should include:

```markdown
# [Feature/Task Name]

**Created:** YYYY-MM-DD
**Status:** In Progress | Blocked | Completed
**Agent:** @workspace /profile [profile-name]
**Related Issues:** #123, #456

## Objective
[Clear statement of goal]

## Context
[Background and motivation]

## Implementation Plan
- [ ] Step 1
- [ ] Step 2
- [ ] Step 3

## Technical Details
[Design decisions, APIs, etc.]

## Testing Strategy
[How to verify]

## Progress Log
### YYYY-MM-DD
- Completed X
- Blocked on Y
- Next: Z
```

## Workflow

1. **Agent Creates Plan** - At start of complex task
2. **Updates During Work** - Track progress and decisions
3. **Final Summary** - Completion notes and learnings
4. **Archive or Delete** - Move to `docs/` if valuable, or delete when obsolete

## Examples

- `2025-11-09-implement-vulkan-compute-shaders.md`
- `2025-11-08-refactor-audio-synchronization.md`
- `2025-11-07-investigate-texture-caching-bug.md`

## Collaboration

- Agents can reference plans: `@workspace see agent-plans/2025-11-09-*.md`
- Human developers can review and provide feedback
- Plans can span multiple agent sessions
- Include decision rationale for future reference

## Cleanup

- Review plans monthly
- Archive completed plans to `docs/` if they contain valuable insights
- Delete obsolete or abandoned plans
- Keep active plans up-to-date
