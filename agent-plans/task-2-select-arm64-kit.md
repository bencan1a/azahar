# Task 2: Select ARM64 Build Kit

## Objective

Configure VSCode CMake Tools extension to use the Visual Studio 2022 ARM64 compiler kit.

## Prerequisites

- Task 1 completed (VSCode configured with ARM64 Qt paths)
- Visual Studio 2022 with ARM64 compiler support installed
- VSCode CMake Tools extension installed

## Current State

Currently using: **Visual Studio Community 2022 Release - amd64** (x64 compiler)

Kit configuration location: `C:\Users\benca\AppData\Local\CMakeTools\cmake-tools-kits.json`

## Target State

Switch to: **Visual Studio Community 2022 Release - arm64** (ARM64 compiler)

## Available ARM64 Kits

Based on the kits file, these ARM64 options should be available:

1. **Visual Studio Community 2022 Release - arm64** (Preferred)
   - Visual Studio ID: `8d9f113e`
   - Architecture: ARM64
   - Generator: Visual Studio 17 2022
   - Platform: arm64
   - Toolset: host=ARM64

2. **Visual Studio Community 2022 Release - amd64_arm64** (Cross-compile)
   - Visual Studio ID: `8d9f113e`
   - Architecture: x64 host, ARM64 target
   - Generator: Visual Studio 17 2022
   - Platform: arm64
   - Toolset: host=x64

**Recommendation:** Use option 1 (native ARM64 host) for best performance.

## Implementation Steps

### Step 1: Verify ARM64 Kit Exists

**Action:** Check the kits configuration file

**Command:**
```bash
cat "C:\Users\benca\AppData\Local\CMakeTools\cmake-tools-kits.json" | grep -A 8 "arm64"
```

**Expected Output:**
Should show ARM64 kit entries including:
- `"name": "Visual Studio Community 2022 Release - arm64"`
- `"visualStudioArchitecture": "ARM64"`
- `"platform": "arm64"`

### Step 2: Select ARM64 Kit (MANUAL USER ACTION)

**Important:** This step requires user interaction in VSCode - an agent cannot automate this directly.

**Instructions for user:**
1. Open VSCode Command Palette: **Ctrl+Shift+P**
2. Type and select: **"CMake: Select a Kit"**
3. Choose: **"Visual Studio Community 2022 Release - arm64"**
4. Wait for kit selection confirmation in status bar

**Alternative method:**
1. Click the kit name in the VSCode status bar (bottom)
2. Select **"Visual Studio Community 2022 Release - arm64"** from the dropdown

### Step 3: Verify Kit Selection

**Check VSCode status bar:**
The bottom status bar should show:
```
[Visual Studio Community 2022 Release - arm64]
```

**Check workspace settings:**
VSCode may create/update `.vscode/cmake-kits.json` with the selected kit.

## Validation

### Check 1: Kit Selection Visible

Look at VSCode status bar - should display ARM64 kit name.

### Check 2: CMake Configuration Prepared

The kit selection should trigger CMake to prepare for reconfiguration. You may see:
- "Configuring project" status message
- Or "Configure needed" indicator

**Note:** Don't configure yet - that's Task 3.

## Success Criteria

- ✅ ARM64 kit appears in available kits list
- ✅ ARM64 kit selected in VSCode (shown in status bar)
- ✅ No errors during kit selection
- ✅ CMake Tools recognizes the kit

## Troubleshooting

**Issue:** ARM64 kit not listed

**Solution 1 - Rescan for kits:**
1. Command Palette: **"CMake: Scan for Kits"**
2. Wait for scan to complete
3. Try selecting ARM64 kit again

**Solution 2 - Check Visual Studio installation:**
1. Open Visual Studio Installer
2. Modify Visual Studio 2022
3. Under "Individual components", ensure these are installed:
   - "MSVC v143 - VS 2022 C++ ARM64 build tools"
   - "C++ ARM64 build tools"
4. Install if missing and rescan kits

**Issue:** Kit selection fails with error

**Possible cause:** Visual Studio installation corrupt or missing components

**Solution:** Repair Visual Studio 2022 installation via Visual Studio Installer

## Architecture Verification

After selecting ARM64 kit, the following should use ARM64:

- **Compiler:** `cl.exe` for ARM64 architecture
- **Platform:** ARM64 (not x64 or x86)
- **Generator:** Visual Studio 17 2022 with ARM64 platform
- **Qt binaries:** ARM64 versions from `msvc2022_arm64` (configured in Task 1)

## Next Task

After completing this task, proceed to **Task 3: Configure CMake for ARM64** to run CMake configuration with the ARM64 kit.

## Rollback

To revert to x64 kit:
1. Command Palette: **"CMake: Select a Kit"**
2. Choose: **"Visual Studio Community 2022 Release - amd64"**

## Notes for Agent Execution

**Agent limitations:**
- Agents **cannot** directly interact with VSCode UI to select kits
- This task requires **user action** in VSCode

**What agent can do:**
1. Verify ARM64 kit exists in kits file (Read/Grep tools)
2. Provide instructions to user for manual kit selection
3. After user selects kit, verify selection by checking status or asking user to confirm
4. Validate prerequisites before user action

**User confirmation needed:**
After user selects kit manually, agent should ask:
"Have you selected the ARM64 kit in VSCode? Please confirm the status bar shows 'Visual Studio Community 2022 Release - arm64'."

**Expected execution time:** ~2 minutes (mostly user action)

## Important Notes

- The kit selection affects which compiler CMake will use
- ARM64 kit ensures native ARM64 binaries are produced
- Cross-compile kit (amd64_arm64) would work but is slower since the compiler itself runs under x64 emulation
- Native ARM64 kit is preferred for performance
