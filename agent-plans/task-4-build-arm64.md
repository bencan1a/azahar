# Task 4: Build ARM64 Executable

## Objective

Compile the Azahar 3DS emulator as a native ARM64 Windows application.

## Prerequisites

- Task 1 completed (VSCode configured with ARM64 Qt)
- Task 2 completed (ARM64 kit selected)
- Task 3 completed (CMake configured for ARM64)
- CMake configuration successful (no errors)

## Current State

- CMake build files generated for ARM64
- Source code ready to compile
- Build directory: `c:/Users/benca/OneDrive/git_repos/azahar/build`

## Target State

- ARM64 native executable built: `build/bin/Release/azahar.exe`
- All ARM64 DLLs deployed alongside executable
- Build completes without errors

## Build Configuration

**Recommended:** Release build for performance testing

**Alternative:** Debug build for development/debugging (slower, larger)

## Implementation Steps

### Step 1: Choose Build Method

**Option A - VSCode CMake Tools (Recommended):**
- Easy to use
- Integrated with VSCode
- Shows build progress in UI

**Option B - Command Line:**
- More control
- Can specify parallelism
- Useful for automation

### Step 2: Build via VSCode (Option A)

**Instructions for user:**

1. **Select build type:**
   - Press **Ctrl+Shift+P**
   - Type: **"CMake: Set Build Type"**
   - Choose: **"Release"** (or "Debug" if needed)

2. **Start build:**
   - Press **F7** (build shortcut)
   - Or: Press **Ctrl+Shift+P** → **"CMake: Build"**

3. **Monitor progress:**
   - Watch the Output panel (CMake/Build section)
   - Build status shown in status bar
   - Compilation progress: `[12/345]` format

4. **Wait for completion:**
   - Release build: ~10-30 minutes (depending on CPU)
   - Status bar will show "Build finished" when done

### Step 2 Alternative: Build via Command Line (Option B)

**Commands:**

**For Release build:**
```bash
cd c:/Users/benca/OneDrive/git_repos/azahar/build
cmake --build . --config Release -- -j8
```

**For Debug build:**
```bash
cd c:/Users/benca/OneDrive/git_repos/azahar/build
cmake --build . --config Debug -- -j8
```

**Parallelism note:**
- `-j8` = use 8 parallel build processes
- Adjust based on CPU cores (your system has many cores, can use `-j16` or more)
- Higher parallelism = faster build but more memory usage

**Alternative using MSBuild directly:**
```bash
cd c:/Users/benca/OneDrive/git_repos/azahar/build
msbuild azahar.sln -p:Configuration=Release -p:Platform=ARM64 -m:8
```

### Step 3: Monitor Build Progress

**Watch for:**

1. **Compilation progress:**
```
[  1%] Building CXX object src/common/...
[  5%] Building CXX object src/core/...
[ 25%] Building CXX object src/video_core/...
[ 50%] Building CXX object src/audio_core/...
[ 75%] Building CXX object src/citra_qt/...
[ 90%] Linking CXX executable azahar.exe
[ 95%] Running windeployqt for azahar.exe
[100%] Built target azahar
```

2. **ARM64-specific compilation:**
Look for:
- `shader_jit_a64_compiler.cpp` being compiled (ARM64 shader JIT)
- `aarch64/cpu_detect.cpp` being compiled
- Dynarmic ARM64 backend files

3. **Qt deployment step:**
```
-- Executing windeployqt for executable c:/Users/benca/.../azahar.exe
```

This deploys ARM64 Qt DLLs alongside the executable.

### Step 4: Verify Build Success

**Check build completion:**

**Success indicators:**
- Build log ends with: `Build finished` or `Built target azahar`
- No errors (red lines in output)
- Exit code: 0

**Check executable exists:**
```bash
ls build/bin/Release/azahar.exe
```

**Expected output:**
```
build/bin/Release/azahar.exe
```

**Check executable architecture:**
```bash
file build/bin/Release/azahar.exe
```

**Expected output (if `file` command available):**
```
azahar.exe: PE32+ executable (GUI) Aarch64, for MS Windows
```

**Note:** The `file` command may not be available on Windows. Alternative check:

```powershell
dumpbin /headers build/bin/Release/azahar.exe | findstr "machine"
```

**Expected:**
```
AA64 machine (ARM64)
```

### Step 5: Verify Qt ARM64 DLLs Deployed

**Check for ARM64 Qt libraries:**
```bash
ls build/bin/Release/*.dll | head -10
```

**Expected DLLs (ARM64 versions):**
- `Qt6Core.dll`
- `Qt6Widgets.dll`
- `Qt6Gui.dll`
- `Qt6Concurrent.dll`
- `Qt6Multimedia.dll`
- `Qt6Network.dll`
- Plus plugins in subdirectories

**Verify DLL architecture:**
```powershell
dumpbin /headers build/bin/Release/Qt6Core.dll | findstr "machine"
```

**Expected:**
```
AA64 machine (ARM64)
```

## Build Time Estimates

**Release Build:**
- First-time build: 15-30 minutes
- Incremental rebuild: 2-10 minutes (only changed files)

**Debug Build:**
- First-time build: 20-40 minutes (more symbols, less optimization)
- Incremental rebuild: 3-15 minutes

**Factors affecting speed:**
- CPU cores (more = faster with parallelism)
- Disk I/O (SSD much faster than HDD)
- RAM (32GB+ recommended for parallel builds)
- Precompiled headers (enabled by default, speeds up builds)

## Validation

### Check 1: Build Completed Successfully

**Criteria:**
- ✅ No compilation errors
- ✅ Exit code 0
- ✅ "Build finished" message

### Check 2: Executable Exists and is ARM64

**Commands:**
```bash
ls -lh build/bin/Release/azahar.exe
```

Should show file size ~50-100 MB (varies by build type).

### Check 3: Dependencies Deployed

**Check plugins directory:**
```bash
ls build/bin/Release/plugins/
```

**Expected subdirectories:**
- `platforms/` (qwindows.dll)
- `imageformats/` (image format plugins)
- `styles/` (Qt styles)
- `multimedia/` (media plugins)
- etc.

### Check 4: No x64 Binaries

**Verify no x64 contamination:**
```bash
dumpbin /headers build/bin/Release/azahar.exe | findstr "machine"
```

Should show **ARM64**, NOT x64 or x86.

## Success Criteria

- ✅ Build completes with exit code 0
- ✅ Executable created: `build/bin/Release/azahar.exe`
- ✅ Executable is ARM64 architecture
- ✅ Qt ARM64 DLLs deployed correctly
- ✅ Plugins directory populated
- ✅ No x64 libraries mixed in
- ✅ windeployqt step succeeded

## Troubleshooting

**Issue:** Compilation errors in ARM64-specific code

**Examples:**
```
shader_jit_a64_compiler.cpp: error C2xxx
```

**Solutions:**
1. Check that Oaknut submodule is initialized:
   ```bash
   git submodule update --init --recursive
   ```
2. Verify CMake configured ARM64 correctly (re-run Task 3)
3. Check Visual Studio ARM64 compiler is installed

**Issue:** Qt6 DLLs not found during build

**Symptoms:**
```
error: cannot find Qt6Core.dll
```

**Solution:**
Verify `.vscode/settings.json` PATH includes ARM64 Qt bin:
```json
"PATH": "c:/Qt/6.10.0/msvc2022_arm64/bin;${env:PATH}"
```

**Issue:** windeployqt fails

**Symptoms:**
```
windeployqt failed: no such file or directory
```

**Solutions:**
1. Check `c:/Qt/6.10.0/msvc2022_arm64/bin/windeployqt6.exe` exists
2. Verify PATH includes Qt ARM64 bin directory
3. Try running windeployqt manually after build completes

**Issue:** Out of memory during build

**Symptoms:**
```
LINK : fatal error LNK1000: Internal error
```

**Solutions:**
1. Reduce parallelism: use `-j4` instead of `-j8`
2. Close other applications to free RAM
3. Use Release build instead of Debug (uses less memory)
4. Disable precompiled headers if desperate:
   ```bash
   cmake .. -DCITRA_USE_PRECOMPILED_HEADERS=OFF
   ```

**Issue:** Build is very slow

**Solutions:**
1. Increase parallelism if you have RAM: `-j16` or `-j32`
2. Ensure you're building Release, not Debug
3. Use SSD if available
4. Verify precompiled headers are enabled (default)

## Expected Build Output Structure

**After successful build:**

```
build/
├── bin/
│   └── Release/
│       ├── azahar.exe          (ARM64 main executable)
│       ├── Qt6Core.dll         (ARM64)
│       ├── Qt6Widgets.dll      (ARM64)
│       ├── Qt6Gui.dll          (ARM64)
│       ├── [other Qt DLLs]
│       └── plugins/
│           ├── platforms/
│           │   └── qwindows.dll
│           ├── imageformats/
│           ├── styles/
│           └── multimedia/
└── [build artifacts]
```

## Next Task

After successful build, proceed to **Task 5: Test and Validate ARM64 Build** to verify the application runs correctly and improvements over x64 emulated version.

## Rollback

If build fails and you need to revert to x64:
1. Select x64 kit
2. Update settings to use `msvc2022_64` Qt
3. Reconfigure CMake for x64
4. Build x64 version

The ARM64 build remains in the `build/` directory and doesn't affect x64 capability.

## Notes for Agent Execution

**Agent approach:**
1. **Cannot directly trigger build** - Must ask user to build via VSCode or provide command-line instructions
2. Can monitor build log if accessible
3. Can verify build outputs after completion using `Bash` tool
4. Can check file existence and validate architecture

**User actions required:**
- Start the build (press F7 or run CMake build command)
- Monitor build progress
- Report any errors to agent

**Validation after build:**
- Agent can use `Bash` tool to check executable exists
- Agent can use `Bash` tool to list DLLs
- Agent can verify directory structure
- Agent should verify architecture (if tools available)

**Expected execution time:**
- User action to start: ~30 seconds
- Build time: 10-30 minutes
- Validation: ~2 minutes

## Important Notes

- **First build is always slowest** - Subsequent incremental builds are much faster
- **Parallel builds use significant RAM** - 8-16 GB for high parallelism
- **Release builds are faster to compile** than Debug builds (less debug info generated)
- **Watch for any linker errors** - These often indicate missing dependencies
- **windeployqt is critical** - Without it, the exe won't run (missing Qt DLLs)
- **Build artifacts are large** - build/ directory can be 5-10 GB, ensure disk space available
