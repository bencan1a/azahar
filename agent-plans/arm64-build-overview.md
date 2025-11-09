# ARM64 Native Build Plan for Azahar 3DS Emulator

## Executive Summary

This plan outlines the steps to build and test a native ARM64 version of the Azahar 3DS emulator on Windows ARM64. The current x64 build runs under emulation, causing performance overhead and compatibility issues (D3D12 SDK version mismatch).

## Current Situation

**Environment:**
- Platform: Windows 11 ARM64 (Build 26100.7019)
- Hardware: Qualcomm Snapdragon with Adreno GPU
- Current Build: x64 (running under emulation)
- Qt Version: 6.10.0

**Issues with x64 Emulated Build:**
1. D3D12 SDK version mismatch (expects v7.14, gets v6.14 from D3DMappingLayers)
2. x64 emulation overhead (xtajit64.dll)
3. Graphics APIs running through compatibility layers (OpenGLOn12, Vulkan Dozen)
4. Multiple "data area too small" system call errors
5. Reduced performance due to x64→ARM64 translation

## Good News: ARM64 Support Already Exists

Research shows the Azahar codebase has **complete ARM64 support**:

- ✅ Qt 6.10.0 has ARM64 binaries (`c:/Qt/6.10.0/msvc2022_arm64/`)
- ✅ Architecture detection for ARM64 in CMake
- ✅ ARM64-specific shader JIT compiler (`shader_jit_a64_compiler.cpp`)
- ✅ Dynarmic CPU emulator with ARM64 host backend
- ✅ Oaknut ARM64 assembler library integrated
- ✅ All dependencies support ARM64

## Expected Benefits

After building ARM64 native version:

1. **Eliminate D3D12 SDK mismatch** - Use native ARM64 D3D12 from Windows
2. **Remove emulation overhead** - Native ARM64 execution
3. **Better GPU access** - Direct Qualcomm driver access (no translation layers)
4. **Improved performance** - ARM-to-ARM JIT compilation more efficient
5. **Cleaner runtime** - No x64 emulation artifacts

## Implementation Approach

The plan is broken into 5 discrete, executable tasks:

### Task 1: Configure VSCode for ARM64 Qt
Update VSCode settings to use Qt ARM64 binaries instead of x64.

**File:** `task-1-configure-vscode-arm64.md`

### Task 2: Select ARM64 Build Kit
Configure VSCode CMake Tools to use Visual Studio ARM64 compiler.

**File:** `task-2-select-arm64-kit.md`

### Task 3: Configure CMake for ARM64
Run CMake configuration with ARM64 platform flag.

**File:** `task-3-configure-cmake-arm64.md`

### Task 4: Build ARM64 Executable
Compile the native ARM64 version of Azahar.

**File:** `task-4-build-arm64.md`

### Task 5: Test and Validate ARM64 Build
Run the ARM64 build and verify improvements over x64 emulated version.

**File:** `task-5-test-validate-arm64.md`

## Success Criteria

The ARM64 build is successful when:

1. ✅ Build completes without errors
2. ✅ Application launches and shows UI
3. ✅ Debug log shows no x64 emulation (no `xtajit64.dll`)
4. ✅ Debug log shows no D3D12 SDK version mismatch
5. ✅ ARM64 native DLLs loaded (not x64 versions)
6. ✅ Direct GPU driver access (Qualcomm drivers, no D3DMappingLayers)
7. ✅ Basic emulator functionality works (can load and run a game)
8. ✅ Performance improvement over x64 emulated build

## Rollback Plan

If ARM64 build fails or has issues:
- Keep the x64 build intact in separate directory
- Can switch back to x64 by selecting x64 kit in VSCode
- Both builds can coexist in different build directories

## Timeline

Each task is estimated to take:
- Task 1: 5 minutes (configuration file updates)
- Task 2: 2 minutes (kit selection)
- Task 3: 5 minutes (CMake configuration)
- Task 4: 10-30 minutes (depending on build parallelism)
- Task 5: 10 minutes (testing and validation)

**Total estimated time:** 30-60 minutes

## Next Steps

Execute tasks in sequence:
1. Start with Task 1 (Configure VSCode for ARM64)
2. Proceed through Tasks 2-4 (Build ARM64)
3. Complete with Task 5 (Test and validate)

Each task document contains detailed commands and validation steps suitable for agent execution.
