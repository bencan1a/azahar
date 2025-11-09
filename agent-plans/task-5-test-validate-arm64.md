# Task 5: Test and Validate ARM64 Build

## Objective

Verify that the ARM64 native build works correctly and provides expected improvements over the x64 emulated version.

## Prerequisites

- Task 4 completed (ARM64 executable built successfully)
- ARM64 executable exists: `build/bin/Release/azahar.exe`
- Previous x64 debug log available for comparison: `debug_log.txt`

## Testing Strategy

1. **Functional Testing** - Verify the application launches and basic features work
2. **Architecture Validation** - Confirm ARM64 native execution (not x64 emulation)
3. **Performance Comparison** - Compare with x64 emulated build
4. **Regression Testing** - Ensure no new issues introduced

## Implementation Steps

### Step 1: Run ARM64 Build

**Command:**
```bash
cd c:/Users/benca/OneDrive/git_repos/azahar/build/bin/Release
./azahar.exe
```

**Or run from VSCode:**
- Press **Ctrl+F5** (Run without debugging)
- Or Press **F5** (Run with debugging)

**Expected behavior:**
- Application window opens
- Main UI appears (game list, menu bar, etc.)
- No immediate crashes

### Step 2: Capture ARM64 Debug Output

**If running from debugger (F5 in VSCode):**
- Debug output appears in Debug Console panel
- Save output to file: `debug_log_arm64.txt`

**If running from command line:**
- Output may appear in console
- Redirect to file:
  ```bash
  ./azahar.exe > debug_log_arm64.txt 2>&1
  ```

**Alternative - Use Visual Studio debugger:**
1. Open `build/azahar.sln` in Visual Studio
2. Set `citra_meta` as startup project
3. Press F5 to debug
4. Debug output appears in Output window
5. Copy output to `debug_log_arm64.txt`

### Step 3: Validate ARM64 Native Execution

**Analyze `debug_log_arm64.txt` for these indicators:**

**✅ SUCCESS Indicators (should be present):**

1. **NO x64 emulation layer:**
```
SHOULD NOT SEE: xtajit64.dll
```

2. **ARM64 DLLs loaded:**
```
SHOULD SEE:
- azahar.exe loaded
- Qt6Widgetsd.dll (or Qt6Widgets.dll for Release)
- Qt6Cored.dll
- etc.
```

3. **Native GPU driver access:**
```
SHOULD SEE:
- qcdx12arm64um.dll (Qualcomm DirectX 12 driver)
- qcvkarm64um.dll (Qualcomm Vulkan driver)

SHOULD NOT SEE:
- D3DMappingLayers (x64 compatibility layer)
- Microsoft.D3DMappingLayers_*_arm64__*/x64/* (x64 DLLs)
```

4. **NO D3D12 SDK version mismatch:**
```
SHOULD NOT SEE:
- "D3D12SDKVersion(614) from D3D12Core != requested D3D12SDKVersion(714)"
- Error 887e0003
```

5. **NO "data area too small" errors:**
```
SHOULD NOT SEE (or much fewer):
- "8007007A The data area passed to a system call is too small"
```

6. **Application version info:**
```
SHOULD SEE:
- "Azahar Version: [commit] | [build info]"
- "Host CPU: Virtual CPU @ 3.41GHz" (or actual CPU info)
- "Host OS: Windows 11 Version 25H2"
```

### Step 4: Compare with x64 Debug Log

**Create comparison report:**

**Command (if both logs available):**
```bash
# Compare key sections
grep "xtajit64.dll" debug_log.txt debug_log_arm64.txt
grep "D3D12SDKVersion" debug_log.txt debug_log_arm64.txt
grep "8007007A" debug_log.txt debug_log_arm64.txt
grep "D3DMappingLayers" debug_log.txt debug_log_arm64.txt
```

**Expected differences:**

| Indicator | x64 Log | ARM64 Log |
|-----------|---------|-----------|
| xtajit64.dll | ✅ Present | ❌ Absent |
| D3D12 SDK mismatch | ✅ Present | ❌ Absent |
| Data area errors | ✅ Many (~12+) | ❌ None or few |
| D3DMappingLayers | ✅ Present | ❌ Absent |
| qcdx12arm64um.dll | ❌ Absent | ✅ Present |
| OpenGLOn12.dll | ✅ Present | ❓ May or may not |

### Step 5: Functional Testing

**Test basic emulator functionality:**

1. **UI Navigation:**
   - ✅ Main window appears
   - ✅ Menu bar functional (File, Emulation, View, etc.)
   - ✅ Can open configuration dialog
   - ✅ Can browse for ROM files

2. **Load a Game (if ROM available):**
   - Try loading a 3DS game ROM or homebrew
   - Verify emulator starts emulation
   - Check that rendering works (game graphics appear)
   - Listen for audio output

3. **Graphics Backend Testing:**
   - Go to: Configure → Graphics
   - Try different backends:
     - **OpenGL** - Should work (via OpenGLOn12 or native if available)
     - **Vulkan** - Test if direct Qualcomm Vulkan works
     - **Software** - Fallback, should always work
   - Note which backends work best

4. **Input Testing:**
   - Configure → Controls
   - Test keyboard input
   - Test gamepad if connected

**Document any issues encountered.**

### Step 6: Performance Testing (Optional)

**If you have a game ROM to test:**

1. **Measure FPS:**
   - Load same game in both x64 and ARM64 builds
   - Note the FPS counter (View → FPS counter)
   - Compare performance

2. **Measure loading times:**
   - Time how long game takes to boot
   - Compare x64 vs ARM64

3. **Subjective feel:**
   - Does ARM64 feel smoother?
   - Any lag or stuttering differences?

**Expected:** ARM64 should be faster or equal to x64 emulated build.

### Step 7: Document Results

**Create test report: `test_results_arm64.md`**

**Include:**
- ✅/❌ Functional tests results
- Debug log comparison summary
- Performance observations
- Any issues or regressions found
- Screenshots (optional)

## Validation Checklist

### Critical Validations (Must Pass)

- [ ] Application launches without crashing
- [ ] Main window and UI appear correctly
- [ ] No x64 emulation layer (no xtajit64.dll in log)
- [ ] ARM64 DLLs loaded (not x64 DLLs)
- [ ] No D3D12 SDK version mismatch errors
- [ ] Qt plugins load correctly

### Important Validations (Should Pass)

- [ ] Can open configuration dialogs
- [ ] Graphics settings accessible
- [ ] No "data area too small" errors (or significantly reduced)
- [ ] Native GPU drivers used (qcdx12arm64um.dll, qcvkarm64um.dll)
- [ ] No D3DMappingLayers used for Direct3D access

### Nice to Have (Optional)

- [ ] Can load and run a game ROM
- [ ] Graphics render correctly
- [ ] Audio works
- [ ] Performance is better than x64 build
- [ ] All rendering backends work (OpenGL, Vulkan, Software)

## Success Criteria

**Minimum for success:**
- ✅ Application launches and shows UI
- ✅ ARM64 native execution confirmed (no x64 emulation)
- ✅ No critical errors in debug log
- ✅ No D3D12 SDK mismatch
- ✅ Qt libraries load correctly

**Full success:**
- ✅ All minimum criteria met
- ✅ Can load and run games
- ✅ Performance improved over x64
- ✅ No regressions in functionality
- ✅ Direct GPU driver access confirmed

## Expected Debug Log Highlights (ARM64)

**Clean ARM64 execution should show:**

```
azahar.exe (XXXX): Loaded 'C:\Users\benca\...\azahar.exe'. Symbols loaded.
azahar.exe (XXXX): Loaded 'C:\Windows\System32\ntdll.dll'.
azahar.exe (XXXX): Loaded 'C:\Windows\System32\kernel32.dll'.
azahar.exe (XXXX): Loaded 'C:\Users\benca\...\Qt6Widgetsd.dll'.
azahar.exe (XXXX): Loaded 'C:\Users\benca\...\Qt6Cored.dll'.
...
azahar.exe (XXXX): Loaded 'C:\Windows\System32\d3d12.dll'.
azahar.exe (XXXX): Loaded 'C:\Windows\System32\DriverStore\...\qcdx12arm64um.dll'.
...
[Frontend <Info> ...]: Azahar Version: 67f6735 | ...
[Frontend <Info> ...]: Host CPU: Virtual CPU @ 3.41GHz
[Frontend <Info> ...]: Host OS: Windows 11 Version 25H2 (Build 26100.7019)
[Frontend <Info> ...]: Host RAM: 63.49 GiB
```

**Key absences (should NOT appear):**
- `xtajit64.dll` (x64 emulation)
- `D3D12SDKVersion(614) from D3D12Core != requested D3D12SDKVersion(714)` (version mismatch)
- Excessive `8007007A` errors
- `Microsoft.D3DMappingLayers_*_arm64__*\x64\` paths (x64 compatibility DLLs)

## Troubleshooting

**Issue:** Application crashes on launch

**Symptoms:**
- Window opens briefly then closes
- Crash dialog appears
- Error in debug log

**Diagnostic steps:**
1. Check debug log for crash location
2. Verify all Qt ARM64 DLLs are present in bin/Release/
3. Check if ARM64 DLL dependencies are met:
   ```bash
   dumpbin /dependents build/bin/Release/azahar.exe
   ```
4. Try running from Visual Studio debugger for detailed crash info

**Solutions:**
- Re-run windeployqt if Qt DLLs missing
- Rebuild in Debug mode for better error messages
- Check Windows Event Viewer for crash details

**Issue:** "Entry point not found" error

**Symptoms:**
```
The procedure entry point ... could not be located in the dynamic link library
```

**Cause:** Mixed x64 and ARM64 DLLs

**Solution:**
1. Delete all DLLs from bin/Release/
2. Re-run windeployqt:
   ```bash
   cd build/bin/Release
   c:/Qt/6.10.0/msvc2022_arm64/bin/windeployqt6.exe azahar.exe
   ```
3. Verify only ARM64 DLLs present

**Issue:** Graphics rendering issues

**Symptoms:**
- Black screen
- Corrupted graphics
- GPU errors in log

**Solutions:**
1. Try different rendering backend:
   - OpenGL
   - Vulkan
   - Software renderer
2. Update GPU drivers (Qualcomm drivers)
3. Check GPU compatibility with emulator

**Issue:** Still seeing D3D12 SDK mismatch

**Symptoms:**
```
D3D12SDKVersion(614) != requested D3D12SDKVersion(714)
```

**Cause:** Still loading x64 compatibility layers

**Diagnostic:**
```bash
grep "D3DMappingLayers" debug_log_arm64.txt
```

**Solution:**
Verify build is truly ARM64:
```powershell
dumpbin /headers build/bin/Release/azahar.exe | findstr "machine"
```

Should show `AA64 machine (ARM64)`.

If shows x64, rebuild with correct architecture (repeat Tasks 2-4).

## Performance Comparison Template

**Create this comparison if doing performance testing:**

| Metric | x64 Emulated | ARM64 Native | Improvement |
|--------|--------------|--------------|-------------|
| Launch time | X seconds | Y seconds | +/- Z% |
| Game load time | X seconds | Y seconds | +/- Z% |
| Average FPS | X fps | Y fps | +/- Z% |
| CPU usage | X% | Y% | +/- Z% |
| Memory usage | X MB | Y MB | +/- Z MB |

**Expected:** ARM64 should show improvements in most metrics.

## Next Steps After Validation

**If tests pass:**
1. ✅ ARM64 build is successful and functional
2. Consider making ARM64 the primary development build
3. Update build documentation for ARM64
4. Consider adding ARM64 to CI/CD pipeline

**If tests fail:**
1. Document specific failures
2. Debug issues (use Debug build for better diagnostics)
3. File issues on GitHub if bugs found
4. May need to revert to x64 while issues are resolved

## Rollback

If ARM64 build has critical issues:
1. Continue using x64 build (keep it intact)
2. Document ARM64 issues for later investigation
3. Both builds can coexist on the system

## Notes for Agent Execution

**Agent approach:**
1. **Cannot directly run the application** - Must ask user to launch and test
2. Can analyze debug log if user provides it
3. Can compare logs using Grep/Read tools
4. Can generate comparison reports
5. Can validate architecture from logs

**User actions required:**
- Run the ARM64 executable
- Capture debug output
- Perform functional testing
- Report results to agent

**Agent validation tasks:**
1. Analyze provided debug log for success indicators
2. Compare with x64 log to identify improvements
3. Generate test report based on findings
4. Provide recommendations based on results

**Expected execution time:**
- User testing: ~10-15 minutes
- Agent analysis: ~5 minutes
- Total: ~20 minutes

## Documentation Outputs

**Files to create:**
1. `debug_log_arm64.txt` - ARM64 debug output
2. `test_results_arm64.md` - Test results summary
3. `comparison_arm64_vs_x64.md` - Performance comparison (optional)

## Important Notes

- **First launch may be slow** - Windows may need to cache ARM64 binaries
- **Some compatibility layer warnings are normal** - Windows ARM64 is still maturing
- **GPU driver differences** - Qualcomm Adreno has different capabilities than x86 GPUs
- **Not all games may work perfectly** - Emulation is complex, ARM64 may expose different issues
- **Performance varies** - Some operations faster on ARM64, some slower depending on code paths
- **The main goal** - Eliminate x64 emulation overhead and compatibility issues, not necessarily perfection

## Success Definition

**This task is successful when:**
1. ARM64 build runs and shows UI
2. No x64 emulation detected in logs
3. No D3D12 SDK mismatch errors
4. Basic functionality works (menus, configuration, etc.)
5. No critical regressions from x64 build
6. Test results documented

**It's okay if:**
- Not all features work perfectly (this is expected for first ARM64 build)
- Some minor warnings appear (as long as core functionality works)
- Performance isn't dramatically better (eliminating compatibility issues is the main goal)
- Some games don't work (emulator compatibility is an ongoing effort)

The key achievement is **native ARM64 execution without x64 emulation overhead**.
