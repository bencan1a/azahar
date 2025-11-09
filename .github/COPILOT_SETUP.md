# GitHub Copilot Configuration for Azahar

This repository is configured to maximize GitHub Copilot agent productivity with specialized instructions, profiles, and templates.

## 📋 What's Included

### 1. Copilot Instructions (`.github/copilot-instructions.md`)
Comprehensive project-specific guidance for GitHub Copilot including:
- Project structure and architecture
- Coding standards (C++20, naming conventions)
- Common patterns for emulation, graphics, audio
- Platform-specific considerations
- Testing and performance guidelines
- 3DS hardware documentation references

### 2. Custom Agent Profiles (`.github/copilot-profiles/`)
Specialized profiles for different development domains:

- **`emulation-core.md`**: CPU, kernel, system services
- **`graphics.md`**: GPU emulation, shaders, rendering backends
- **`audio.md`**: DSP, audio processing, synchronization
- **`frontend.md`**: Qt/SDL GUI, Android, input mapping
- **`build-infrastructure.md`**: CMake, CI/CD, cross-platform builds

#### Using Agent Profiles
In GitHub Copilot Chat, you can reference these profiles to get domain-specific assistance:

```
@workspace /profile emulation-core
How should I implement a new system service?
```

### 3. Pull Request Templates (`.github/PULL_REQUEST_TEMPLATE/`)
Structured templates for different PR types:

- **`PULL_REQUEST_TEMPLATE.md`**: Default general template
- **`bug_fix.md`**: Bug fix with reproduction steps
- **`feature.md`**: New feature implementation
- **`performance.md`**: Performance optimizations with benchmarks
- **`graphics.md`**: Graphics/rendering changes with screenshots

#### Using PR Templates
When creating a PR, add `?template=<name>` to the URL:
```
https://github.com/azahar-emu/azahar/compare/master...mybranch?template=bug_fix.md
```

Or select from the template dropdown in the GitHub UI.

### 4. Git Attributes (`.gitattributes`)
Configured for:
- Consistent line endings (LF for source, CRLF for Windows scripts)
- Binary file handling for ROMs, images, libraries
- Linguist configuration for accurate language statistics
- Proper handling of generated code

### 5. Dev Container (`.devcontainer/`)
Complete development environment with:
- Ubuntu 22.04 base
- C++20 compiler (GCC, Clang)
- All dependencies (Qt6, SDL2, Vulkan, Boost, etc.)
- Build tools (CMake, Ninja, ccache)
- VS Code extensions (Copilot, C++, CMake, Git)
- Debugging tools (GDB, Valgrind)

See [`.devcontainer/README.md`](.devcontainer/README.md) for details.

### 6. Project Organization (`docs/`, `agent-plans/`, `agent-tmp/`)

#### Documentation (`docs/`)
Persistent, version-controlled project documentation:
- Architecture and design documents
- 3DS hardware research and findings
- Implementation guides and patterns
- API specifications
- Developer workflows

Organized by topic (architecture/, emulation/, graphics/, audio/, guides/).

#### Agent Plans (`agent-plans/`)
Active agent work tracking for complex tasks:
- Multi-step feature implementation plans
- Refactoring roadmaps
- Investigation and research notes
- Progress tracking across sessions

Files named: `YYYY-MM-DD-feature-name.md`
Archive to `docs/` when complete and valuable, delete otherwise.

#### Agent Temporary (`agent-tmp/`)
Ephemeral workspace for debug and exploration:
- Debug scripts and test code
- Temporary analysis outputs
- Quick prototypes
- Log processing scripts

**NOT version controlled** - gitignored, clean up regularly.
Promote valuable code to proper locations (src/tests/, tools/, docs/).

See individual README files in each directory for details.

## 🚀 Getting Started with Copilot

### For New Contributors

1. **Open in Dev Container** (recommended)
   - Ensures consistent environment with all tools
   - VS Code → Reopen in Container
   - Everything is pre-configured

2. **Chat with Copilot**
   ```
   @workspace How is the project structured?
   @workspace How do I build the project?
   @workspace /profile graphics How are shaders compiled?
   ```

3. **Get Code Suggestions**
   - Copilot provides context-aware suggestions based on project patterns
   - Understands 3DS hardware and emulation concepts
   - Follows project coding standards

### For Experienced Developers

1. **Use Domain Profiles**
   - Reference specific profiles for focused assistance
   - Profiles contain domain-specific best practices

2. **Leverage PR Templates**
   - Use appropriate template for your change type
   - Ensures all necessary information is included

3. **Agent-Assisted Development**
   ```
   @workspace /profile emulation-core
   I need to implement the CFG:GetSystemModel service function.
   Can you help me understand the HLE pattern and create a stub?
   ```

## 💡 Copilot Best Practices

### Asking Effective Questions

**Good:**
```
@workspace /profile graphics
The GPU command 0x0227 sets the texture environment. 
How should I implement this in the PICA state manager?
```

**Better:**
```
@workspace /profile graphics
I'm implementing PICA200 texture environment configuration.
Looking at src/video_core/pica_state.h, where should I add
the state for texture combiner operations? Show me the pattern
used for similar GPU state in the codebase.
```

### Code Generation

**For new features:**
```
@workspace /profile emulation-core
Generate a skeleton for implementing the ACT:GetAccountInfo service.
Follow the pattern used in other service implementations in
src/core/hle/service/act/.
```

**For bug fixes:**
```
@workspace
Analyze src/video_core/renderer_opengl/gl_rasterizer.cpp
and help me debug why texture filtering is broken for mipmaps.
```

### Understanding Code

```
@workspace Explain how the CPU JIT works in src/core/arm/dynarmic/
@workspace What's the purpose of the PICA state cache?
@workspace /profile audio How does audio synchronization work?
```

## 🎯 Domain-Specific Workflows

### Graphics Development
```
1. @workspace /profile graphics
2. Ask about PICA200 behavior or existing implementations
3. Get help with shader translation or backend-specific code
4. Use graphics.md PR template with before/after screenshots
```

### Core Emulation
```
1. @workspace /profile emulation-core
2. Reference 3DS hardware documentation
3. Get help implementing HLE services or CPU features
4. Test with homebrew and commercial games
```

### Frontend/UI
```
1. @workspace /profile frontend
2. Ask about Qt patterns or Android JNI bridge
3. Get help with settings management or input mapping
4. Ensure cross-platform compatibility
```

## �️ Agent File Management Workflow

### Starting a Complex Task
```
1. Create plan: agent-plans/2025-11-09-implement-vulkan-compute.md
2. Document objectives, steps, and technical details
3. Reference in chat: @workspace see agent-plans/2025-11-09-*.md
```

### During Development
```
1. Create debug scripts in agent-tmp/ as needed
   Example: agent-tmp/test_shader_compiler.py
2. Update agent-plans/ with progress and decisions
3. Test and iterate using temporary files
```

### Completing Work
```
1. Move valuable insights to docs/
   Example: docs/graphics/vulkan-compute-implementation.md
2. Promote useful scripts to proper locations
   - Tests → src/tests/
   - Tools → tools/
3. Clean up agent-tmp/ (delete all temporary files)
4. Archive or delete agent-plans/ file
```

### Example Session
```
@workspace I need to implement Vulkan compute shader support.

Step 1: Create plan
Create agent-plans/2025-11-09-vulkan-compute-shaders.md with:
- Objective and scope
- Implementation steps
- Technical design decisions

Step 2: Debug and prototype
Create agent-tmp/test_compute_shader.cpp to test SPIR-V compilation

Step 3: Implement
Write actual code in src/video_core/renderer_vulkan/

Step 4: Document
Create docs/graphics/vulkan-compute-shaders.md with architecture

Step 5: Cleanup
- Delete agent-tmp/test_compute_shader.cpp
- Archive or delete agent-plans file
```

## �📝 Contributing with Copilot

### Creating a Pull Request

1. **Get Copilot's help with implementation**
   ```
   @workspace /profile <domain>
   I want to implement <feature>. Show me similar code in the codebase.
   ```

2. **Use appropriate PR template**
   - Select template matching your change type
   - Fill in all sections with Copilot assistance

3. **Generate PR description**
   ```
   @workspace Generate a PR description for the changes in these files:
   - src/core/hle/service/cfg/cfg.cpp
   - src/core/hle/service/cfg/cfg.h
   
   The changes implement the GetSystemModel service call.
   ```

### Code Review

Reviewers can use Copilot to:
```
@workspace Analyze the changes in this PR for:
- Emulation accuracy
- Performance impact
- Cross-platform compatibility
- Coding standards compliance
```

## 🛠️ Advanced Features

### Workspace-Wide Refactoring
```
@workspace Find all instances where we use raw pointers for
GPU command buffers and show me how to migrate to smart pointers
following the project's memory management patterns.
```

### Testing
```
@workspace /profile emulation-core
Generate unit tests for the CFG service implementation in
src/tests/core/hle/service/cfg/ following the Catch2 patterns
used in existing tests.
```

### Documentation
```
@workspace Generate Doxygen comments for the PICA state manager
class in src/video_core/pica_state.h
```

## 📚 Additional Resources

- [Copilot Instructions](.github/copilot-instructions.md)
- [Agent Profiles](.github/copilot-profiles/)
- [PR Templates](.github/PULL_REQUEST_TEMPLATE/)
- [Dev Container](.devcontainer/)
- [3DS Hardware Documentation](https://www.3dbrew.org/)

## 🤝 Feedback

If you have suggestions for improving the Copilot configuration:
1. Open an issue describing the improvement
2. Submit a PR updating the relevant configuration files
3. Share your experience with specific profiles or templates

---

**Happy coding with Copilot! 🚀**
