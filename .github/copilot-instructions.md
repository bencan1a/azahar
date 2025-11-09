# Copilot Instructions for Azahar Emulator

## Project Overview
Azahar is a Nintendo 3DS emulator forked from Citra. It's a complex C++ project focused on emulating 3DS hardware and software.

## Codebase Structure

### Core Directories
- **`src/core/`**: Core emulation logic including CPU, GPU, memory management, and system services
- **`src/video_core/`**: Video rendering, graphics API abstractions (OpenGL, Vulkan), shader compilation
- **`src/audio_core/`**: Audio processing and output
- **`src/citra_qt/`**: Qt-based desktop GUI application
- **`src/citra_sdl/`**: SDL-based frontend for command-line usage
- **`src/android/`**: Android-specific frontend
- **`src/common/`**: Shared utilities, logging, file system abstractions, threading
- **`src/input_common/`**: Input handling and controller mapping
- **`src/network/`**: Network and multiplayer functionality
- **`src/tests/`**: Unit and integration tests
- **`externals/`**: Third-party dependencies (boost, fmt, cryptopp, etc.)

### ⚠️ CRITICAL: Never Modify External Dependencies

**DO NOT modify any files in the `externals/` directory!**

- `externals/` contains third-party dependencies managed as git submodules
- These are **separate repositories** that you do not own
- Modifying files in `externals/` will attempt to commit/push to external repos you don't have access to
- Configuration files (e.g., `.vscode/settings.json`) may exist in submodules - **ignore them**

**If you need to configure build settings:**
- Modify files in the **main azahar repository only**
- Use CMake configuration in the root `CMakeLists.txt` or `CMakeModules/`
- Update `.vscode/settings.json` at the **root level only**, never in submodules

**Valid modification locations:**
- ✅ `src/` - Azahar source code
- ✅ `CMakeLists.txt` and `CMakeModules/` - Build configuration
- ✅ `.vscode/` at root - VSCode workspace settings
- ✅ `agent-plans/`, `agent-tmp/`, `docs/` - Documentation and planning
- ✅ `.github/`, `hooks/`, `tools/` - Project infrastructure
- ❌ **NEVER `externals/` or any subdirectories within it**

### Documentation & Agent Directories
- **`docs/`**: Persistent project documentation (architecture, guides, research notes)
  - Use for long-term, version-controlled documentation
  - Organize by topic: architecture/, emulation/, graphics/, audio/, guides/
  - Keep docs in sync with code changes
- **`agent-plans/`**: Active agent work plans and multi-step projects
  - Create detailed plans for complex features or refactorings
  - Track progress across multiple sessions
  - Name files: `YYYY-MM-DD-feature-name.md`
  - Archive to `docs/` when valuable, delete when obsolete
- **`agent-tmp/`**: Ephemeral debug scripts and temporary files (NOT version controlled)
  - Use for debug scripts, quick tests, log analysis
  - Clean up regularly - files here are temporary
  - Do not commit - directory is gitignored
  - Promote valuable code to proper locations (src/tests/, tools/, docs/)

### Build System
- **CMake-based**: Main `CMakeLists.txt` in root, subdirectories have their own
- **Multi-platform**: Windows (MSVC/MSYS2), macOS, Linux, Android
- **External dependencies**: Managed via git submodules in `externals/`

## Coding Standards

### Language & Style
- **C++20** is the standard (see CMakeLists.txt line 1)
- **Formatting**: Uses `.clang-format` (already in `src/.clang-format`)
- **Naming conventions**:
  - `snake_case` for functions and variables
  - `PascalCase` for classes and structs
  - `UPPER_CASE` for constants and macros
  - Namespace: typically `Core::`, `VideoCore::`, `AudioCore::`, etc.

### Code Organization
- Header files: `.h` extension
- Implementation files: `.cpp` extension
- Keep platform-specific code isolated with appropriate `#ifdef` guards
- Use forward declarations where possible to reduce compile times
- Template-heavy code should have inline implementations or separate `.inc` files

### Memory Management
- Prefer smart pointers (`std::unique_ptr`, `std::shared_ptr`) over raw pointers
- Use RAII principles consistently
- Be mindful of emulation performance - avoid unnecessary allocations in hot paths

### Error Handling
- Use `ASSERT` and `ASSERT_MSG` from common/assert.h for debug assertions
- Use `LOG_*` macros from common/logging for logging
- Return `Result` types or use exceptions appropriately for error propagation

## Common Patterns

### Service Implementation (HLE)
When implementing or modifying 3DS system services:
- Services inherit from `ServiceFramework`
- Use `MakeServiceCommandHandler` for command tables
- Functions receive `Kernel::HLERequestContext&` for IPC
- Always validate parameters from guest code

### Video Core
- Renderers abstract OpenGL/Vulkan backends
- Shaders are compiled from PICA200 assembly to GLSL/SPIR-V
- Use `VideoCore::RasterizerInterface` for rendering operations

### Threading
- Emulation runs on separate threads
- Use `std::mutex`, `std::condition_variable` for synchronization
- Be aware of timing-sensitive code in the core emulation loop

## Testing
- Unit tests use Catch2 framework (in `externals/catch2/`)
- Place tests in `src/tests/`
- Test emulation accuracy, not just functionality
- Performance-critical paths should have benchmarks

## Performance Considerations
- This is an emulator - performance is critical
- Profile before optimizing
- Hot paths: CPU interpreter/JIT, GPU command processing, audio generation
- Minimize allocations in per-frame code
- Consider cache locality for frequently accessed data structures

## Platform-Specific Notes

### Android
- Uses JNI bridge in `src/android/`
- Frontend is Kotlin/Java in Android-specific directories
- Must consider mobile GPU limitations

### macOS/iOS
- Objective-C/C++ interop for system features
- Metal backend may be used instead of Vulkan
- Consider ARM vs x86_64 differences

### Windows
- MSVC and MinGW (MSYS2) builds both supported
- DirectX may be considered in future

## Dependencies
- **Qt**: Desktop GUI framework
- **SDL2**: Input, windowing for SDL frontend
- **Boost**: Various utilities
- **cryptopp**: Cryptographic operations for 3DS encryption
- **glad**: OpenGL loading
- **Vulkan**: Modern graphics API support
- **fmt**: String formatting
- **Catch2**: Testing framework

## When Making Changes

### Adding Features
1. Understand the 3DS hardware/software being emulated
2. Check if similar functionality exists elsewhere in codebase
3. Consider performance impact on emulation
4. Add tests for new functionality
5. Update relevant documentation

### Fixing Bugs
1. Identify if it's an emulation accuracy issue or implementation bug
2. Check hardware behavior documentation
3. Test with real 3DS titles when possible
4. Verify fix doesn't break other games

### Refactoring
1. Maintain emulation accuracy above all else
2. Benchmark performance-critical changes
3. Update tests to match new structure
4. Ensure cross-platform compatibility

## Emulation-Specific Guidance
- **Accuracy vs Performance**: Balance needed, but accuracy is priority for compatibility
- **Hardware quirks**: 3DS has many hardware-specific behaviors that must be emulated
- **Timing**: Critical for audio/video sync and game compatibility
- **Savegames**: Must maintain compatibility across versions
- **Cheats/Mods**: Support user modifications while maintaining stability

## Resources
- 3DS Hardware Documentation: Check 3dbrew.org
- Original Citra documentation: May still be relevant
- Test ROMs: Use homebrew and licensed games you own

## Common Commands
```bash
# Configure build
cmake -B build -G Ninja

# Build
cmake --build build --config Release

# Run tests
ctest --test-dir build

# Format code (if clang-format available)
find src -name "*.cpp" -o -name "*.h" | xargs clang-format -i
```

## Agent-Specific Tips
- When modifying emulation logic, always consider hardware documentation
- Graphics code changes often need testing across multiple backends
- Audio changes should be tested with multiple games for timing accuracy
- UI changes require consideration of Qt model-view patterns
- Android changes need both Java/Kotlin and C++ modifications
- Always check if changes maintain save state compatibility

## Agent Workflow & File Management

### For Complex Multi-Step Tasks
1. **Create a plan** in `agent-plans/YYYY-MM-DD-task-name.md`
2. **Track progress** by updating the plan file during work
3. **Archive or delete** when complete (move valuable insights to `docs/`)

### For Debug Scripts & Temporary Code
1. **Use `agent-tmp/`** for all ephemeral files
2. **Clean up** when task is complete
3. **Never commit** agent-tmp/ files (gitignored)
4. **Promote** valuable code to proper locations (src/tests/, tools/)

### For Documentation
1. **Use `docs/`** for permanent technical documentation
2. **Organize by topic** (architecture/, emulation/, graphics/, etc.)
3. **Keep current** - update docs when code changes
4. **Reference code** - link to source files and line numbers when relevant

### Example Agent Session
```
1. Create agent-plans/2025-11-09-implement-feature-x.md
2. Write debug script to agent-tmp/test_feature_x.py
3. Implement feature in src/
4. Test with agent-tmp/verify_feature_x.sh
5. Update docs/features/feature-x.md if significant
6. Clean up agent-tmp/
7. Mark agent-plans/ file as complete or delete
```
