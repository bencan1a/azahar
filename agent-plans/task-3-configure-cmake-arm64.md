# Task 3: Configure CMake for ARM64

## Objective

Run CMake configuration to generate build files for ARM64 architecture.

## Prerequisites

- Task 1 completed (VSCode configured with ARM64 Qt paths)
- Task 2 completed (ARM64 kit selected)
- Git submodules initialized (`git submodule update --init --recursive`)
- ARM64 compiler available via Visual Studio 2022

## Current State

- Existing build directory may contain x64 configuration
- CMake cache needs to be cleared for architecture change

## Target State

- CMake configured for ARM64 architecture
- Build files generated for Visual Studio 2022 ARM64
- Dynarmic ARM64 backend enabled
- Oaknut ARM64 assembler enabled
- Qt ARM64 libraries detected

## Implementation Steps

### Step 1: Clean Existing Build Cache

**Action:** Delete existing CMake cache to avoid architecture conflicts

**Commands:**
```bash
cd c:/Users/benca/OneDrive/git_repos/azahar
rm -rf build/CMakeCache.txt build/CMakeFiles
```

**Alternative (full clean):**
```bash
cd c:/Users/benca/OneDrive/git_repos/azahar
rm -rf build
mkdir build
```

**Why:** CMake caches the target architecture. Switching from x64 to ARM64 requires clearing the cache.

### Step 2: Verify Submodules

**Command:**
```bash
cd c:/Users/benca/OneDrive/git_repos/azahar
git submodule update --init --recursive
```

**Expected:** Should confirm submodules are up to date (Dynarmic, Oaknut, etc.)

### Step 3: Configure CMake for ARM64 (MANUAL USER ACTION)

**Important:** This step is best done via VSCode CMake Tools extension.

**Instructions for user:**
1. Open VSCode Command Palette: **Ctrl+Shift+P**
2. Type and select: **"CMake: Delete Cache and Reconfigure"**
3. Wait for configuration to complete
4. Monitor the CMake output panel for progress

**Alternative (command line):**
```bash
cd c:/Users/benca/OneDrive/git_repos/azahar/build
cmake .. -G "Visual Studio 17 2022" -A ARM64 \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH=c:/Qt/6.10.0/msvc2022_arm64 \
    -DENABLE_QT=ON \
    -DENABLE_VULKAN=ON \
    -DENABLE_OPENGL=ON
```

### Step 4: Monitor CMake Configuration Output

**Watch for these key messages:**

1. **Architecture Detection:**
```
-- Target architecture: arm64
```
or
```
-- Performing Test CHECK_CPU_ARCHITECTURE_ARM64
-- Performing Test CHECK_CPU_ARCHITECTURE_ARM64 - Success
```

2. **Qt Detection:**
```
-- Found Qt6 (version 6.10.0)
-- Using target Qt at c:/Qt/6.10.0/msvc2022_arm64
-- Using host Qt at c:/Qt/6.10.0/msvc2022_arm64
```

3. **Dynarmic ARM64 Backend:**
```
-- Enabling Dynarmic for ARM64
```
or similar message indicating ARM64 JIT backend

4. **Oaknut Assembler:**
```
-- Enabling Oaknut ARM64 assembler
```

5. **Configuration Complete:**
```
-- Configuring done
-- Generating done
```

## Validation

### Check 1: Architecture Detected Correctly

**Search CMake output for:**
```bash
grep -i "arm64" build/CMakeCache.txt
```

**Expected entries:**
```
CMAKE_SYSTEM_PROCESSOR:STRING=ARM64
CMAKE_VS_PLATFORM_NAME:STRING=ARM64
```

### Check 2: Qt ARM64 Found

**Check CMake output or cache:**
```bash
grep "Qt6_DIR" build/CMakeCache.txt
```

**Expected:**
```
Qt6_DIR:PATH=c:/Qt/6.10.0/msvc2022_arm64/lib/cmake/Qt6
```

### Check 3: Build Files Generated

**Command:**
```bash
ls build/*.sln
```

**Expected:**
Should show `azahar.sln` (Visual Studio solution file)

**Check project platform:**
```bash
grep -i "arm64" build/azahar.sln
```

Should show ARM64 platform configurations.

### Check 4: Dynarmic and Oaknut Enabled

**Check that ARM64-specific files will be compiled:**
```bash
grep -i "shader_jit_a64" build/src/video_core/CMakeFiles/video_core.dir/flags.make
```

or

```bash
grep -r "shader_jit_a64_compiler.cpp" build/
```

Should show ARM64 shader compiler is included in build.

## Success Criteria

- ✅ CMake configuration completes without errors
- ✅ Architecture detected as ARM64
- ✅ Qt ARM64 libraries found and configured
- ✅ Visual Studio solution files generated for ARM64
- ✅ Dynarmic ARM64 backend enabled
- ✅ Oaknut ARM64 assembler enabled
- ✅ No warnings about missing ARM64 components

## Expected Configuration Output

**Key sections to see:**

```
-- Selecting Windows SDK version 10.0.22621.0 to target Windows 6.2.9200.
-- Target architecture: arm64
-- Using Precompiled Headers.
-- LTO disabled
-- Found Qt6 (version 6.10.0) at c:/Qt/6.10.0/msvc2022_arm64/lib/cmake/Qt6
-- Using target Qt at c:/Qt/6.10.0/msvc2022_arm64
-- Using host Qt at c:/Qt/6.10.0/msvc2022_arm64
-- Performing Test HAVE_ARM64_JIT
-- Performing Test HAVE_ARM64_JIT - Success
-- Configuring done
-- Generating done
-- Build files written to: c:/Users/benca/OneDrive/git_repos/azahar/build
```

## Troubleshooting

**Issue:** CMake can't find Qt6

**Symptoms:**
```
CMake Error: Could not find a package configuration file provided by "Qt6"
```

**Solution:**
Check that `.vscode/settings.json` has correct ARM64 Qt path:
```json
"CMAKE_PREFIX_PATH": "c:/Qt/6.10.0/msvc2022_arm64"
```

**Issue:** Architecture still detected as x64

**Symptoms:**
```
-- Target architecture: x86_64
```

**Solutions:**
1. Verify ARM64 kit is selected (status bar shows ARM64)
2. Delete entire build directory and reconfigure:
   ```bash
   rm -rf build && mkdir build
   ```
3. Try command-line CMake with explicit `-A ARM64` flag

**Issue:** Dynarmic ARM64 backend not enabled

**Check:** Look for x64-specific code being compiled instead of ARM64

**Solution:**
Verify CMake is detecting ARM64 correctly. Check:
```bash
grep CMAKE_SYSTEM_PROCESSOR build/CMakeCache.txt
```

Should show `ARM64`, not `x86_64` or `AMD64`.

**Issue:** Boost or other dependencies not found

**Symptoms:**
```
CMake Error: Could not find Boost
```

**Cause:** Some external dependencies download/build at configure time

**Solution:**
Ensure internet connection is available and retry. CMake will download missing externals.

## Next Task

After successful CMake configuration, proceed to **Task 4: Build ARM64 Executable** to compile the native ARM64 binaries.

## Rollback

To revert to x64 configuration:
1. Select x64 kit: "Visual Studio Community 2022 Release - amd64"
2. Update `.vscode/settings.json` to use `msvc2022_64` Qt path
3. Run "CMake: Delete Cache and Reconfigure"

## Notes for Agent Execution

**Agent approach:**
1. Use `Bash` tool to clean build cache
2. Use `Bash` tool to verify submodules
3. **User action required:** Ask user to run "CMake: Delete Cache and Reconfigure" in VSCode
4. Use `Read` or `Grep` tools to validate CMake output and cache files
5. Verify architecture detection and Qt paths

**User actions required:**
- Run CMake configuration via VSCode (or agent can provide command-line alternative)
- Monitor CMake output panel for errors

**Validation tools:**
- `Grep` to search CMakeCache.txt for ARM64 architecture
- `Grep` to verify Qt path points to msvc2022_arm64
- `Bash` `ls` to verify solution files generated

**Expected execution time:** ~5 minutes (CMake configuration time)

## Important Notes

- CMake configuration downloads and builds some external dependencies
- First-time configuration may take longer (3-5 minutes)
- Subsequent reconfigurations are faster (1-2 minutes)
- Internet connection required for external dependency downloads
- Watch for any red ERROR messages in output - these must be resolved before building
- Yellow WARNING messages about clang-format, PkgConfig, etc. are normal and can be ignored
