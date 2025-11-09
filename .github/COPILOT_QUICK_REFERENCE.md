# Quick Reference: GitHub Copilot Agent Profiles

## Available Profiles

| Profile | Use For | Key Locations |
|---------|---------|---------------|
| `emulation-core` | CPU, kernel, system services, HLE | `src/core/` |
| `graphics` | GPU, shaders, rendering, OpenGL/Vulkan | `src/video_core/` |
| `audio` | DSP, audio sync, AAC decoding | `src/audio_core/` |
| `frontend` | Qt GUI, Android, SDL, input | `src/citra_qt/`, `src/android/` |
| `build-infrastructure` | CMake, CI/CD, dependencies | `CMakeLists.txt`, `.github/workflows/` |

## Quick Commands

### Start a Conversation
```
@workspace /profile <profile-name>
<your question>
```

### Common Patterns

#### Implementing a New Service
```
@workspace /profile emulation-core
I need to implement service function <name> in <module>.
Show me the HLE pattern used in similar services.
```

#### Fixing Graphics Issues
```
@workspace /profile graphics
Game <name> has rendering issue with <feature>.
Help me debug the PICA200 implementation.
```

#### Adding UI Features
```
@workspace /profile frontend
I want to add a new settings option for <feature>.
Show me how settings are implemented in the Qt frontend.
```

#### Build Configuration
```
@workspace /profile build-infrastructure
How do I add a new dependency to the CMake build system?
```

#### Performance Optimization
```
@workspace /profile <domain>
This code path is slow. Help me profile and optimize it
while maintaining emulation accuracy.
```

## Profile Selection Guide

### Choose `emulation-core` if:
- Working on ARM CPU emulation
- Implementing system calls/services
- Modifying kernel behavior
- Working on memory management
- Dealing with save states

### Choose `graphics` if:
- Fixing rendering issues
- Working on shaders
- Modifying GPU command processing
- Adding/fixing rendering backends
- Dealing with texture/framebuffer issues

### Choose `audio` if:
- Working on DSP emulation
- Fixing audio sync issues
- Modifying audio output
- Working on AAC decoding

### Choose `frontend` if:
- Adding UI features
- Modifying settings
- Working on input mapping
- Android development
- Game list management

### Choose `build-infrastructure` if:
- Modifying build system
- Updating dependencies
- Working on CI/CD
- Cross-platform build issues
- Packaging/installers

## Tips for Best Results

1. **Be Specific**: Reference specific files, functions, or features
2. **Provide Context**: Mention what you've already tried
3. **Use Code Examples**: Show relevant code snippets
4. **Reference Hardware**: Mention 3DS hardware behavior when relevant
5. **Test Cases**: Mention which games are affected

## Example Workflows

### Bug Fix
```
1. @workspace /profile <domain>
2. Describe the bug with reproduction steps
3. Ask for debugging strategy
4. Request code fix with explanation
5. Ask for test suggestions
```

### New Feature
```
1. @workspace /profile <domain>
2. Describe desired feature
3. Ask about similar implementations
4. Request implementation plan
5. Get help with code generation
6. Ask about testing approach
```

### Code Review
```
1. @workspace
2. Ask Copilot to review changed files
3. Request specific checks (accuracy, performance, style)
4. Get suggestions for improvements
```

## Integration with PR Templates

Match your profile to PR template:
- `emulation-core` → `bug_fix.md` or `feature.md`
- `graphics` → `graphics.md`
- Performance work → `performance.md`
- Any domain → `PULL_REQUEST_TEMPLATE.md` (default)

---

💡 **Pro Tip**: You can combine profiles by asking follow-up questions!
Start with the most relevant profile, then ask about related areas.
