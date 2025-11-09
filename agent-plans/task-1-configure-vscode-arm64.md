# Task 1: Configure VSCode for ARM64 Qt

## Objective

Update VSCode workspace settings to use Qt 6.10.0 ARM64 binaries instead of x64 binaries.

## Prerequisites

- Qt 6.10.0 installed with ARM64 support at `c:/Qt/6.10.0/msvc2022_arm64/`
- VSCode with CMake Tools extension installed
- Azahar repository open in VSCode

## Current State

Current `.vscode/settings.json`:
```json
{
    "cmake.cmakePath": "C:\\Program Files\\CMake\\bin\\cmake.exe",
    "cmake.configureSettings": {
        "CMAKE_PREFIX_PATH": "c:/Qt/6.10.0/msvc2022_64"
    },
    "cmake.environment": {
        "PATH": "c:/Qt/6.10.0/msvc2022_64/bin;${env:PATH}"
    }
}
```

Note: This is configured for x64 Qt (`msvc2022_64`).

## Target State

Updated `.vscode/settings.json` for ARM64:
```json
{
    "cmake.cmakePath": "C:\\Program Files\\CMake\\bin\\cmake.exe",
    "cmake.configureSettings": {
        "CMAKE_PREFIX_PATH": "c:/Qt/6.10.0/msvc2022_arm64"
    },
    "cmake.environment": {
        "PATH": "c:/Qt/6.10.0/msvc2022_arm64/bin;${env:PATH}"
    }
}
```

Changes:
- `CMAKE_PREFIX_PATH`: `msvc2022_64` → `msvc2022_arm64`
- `PATH`: `msvc2022_64/bin` → `msvc2022_arm64/bin`

## Implementation Steps

### Step 1: Verify Qt ARM64 Installation

**Command:**
```bash
ls c:/Qt/6.10.0/msvc2022_arm64
```

**Expected Output:**
Should show directories including:
- `bin/` - ARM64 Qt binaries and tools
- `lib/` - ARM64 Qt libraries
- `include/` - Qt headers
- `plugins/` - ARM64 Qt plugins

**Validation:**
Check that `windeployqt6.exe` exists:
```bash
ls c:/Qt/6.10.0/msvc2022_arm64/bin/windeployqt6.exe
```

### Step 2: Update VSCode Settings

**Action:** Edit `.vscode/settings.json`

**Changes to make:**
1. Replace all instances of `msvc2022_64` with `msvc2022_arm64`
2. Keep the CMake path unchanged (CMake itself is universal)

**Specific edits:**
- Line 4: Change `"CMAKE_PREFIX_PATH": "c:/Qt/6.10.0/msvc2022_64"`
  to `"CMAKE_PREFIX_PATH": "c:/Qt/6.10.0/msvc2022_arm64"`

- Line 7: Change `"PATH": "c:/Qt/6.10.0/msvc2022_64/bin;${env:PATH}"`
  to `"PATH": "c:/Qt/6.10.0/msvc2022_arm64/bin;${env:PATH}"`

### Step 3: Verify Settings File

**Command:**
```bash
cat .vscode/settings.json
```

**Expected Content:**
The file should now contain ARM64 paths (`msvc2022_arm64`) instead of x64 paths.

## Validation

### Check 1: File Syntax
Ensure the JSON is valid (no syntax errors).

### Check 2: Path Correctness
Verify the paths point to actual directories:
```bash
ls "c:/Qt/6.10.0/msvc2022_arm64/bin"
```

Should show Qt ARM64 binaries including:
- `Qt6Core.dll`
- `Qt6Widgets.dll`
- `windeployqt6.exe`
- etc.

## Success Criteria

- ✅ `.vscode/settings.json` updated with ARM64 Qt paths
- ✅ Qt ARM64 directory exists and contains binaries
- ✅ JSON syntax is valid
- ✅ No errors when opening the file in VSCode

## Troubleshooting

**Issue:** Qt ARM64 directory doesn't exist

**Solution:**
1. Open Qt Maintenance Tool (`c:/Qt/MaintenanceTool.exe`)
2. Select "Add or remove components"
3. Navigate to Qt 6.10.0
4. Check "MSVC 2022 ARM64" component
5. Install and retry

**Issue:** JSON syntax error

**Solution:**
Ensure proper comma placement and quote matching. Use VSCode's JSON validation (bottom right should show "JSON" with no errors).

## Next Task

After completing this task, proceed to **Task 2: Select ARM64 Build Kit** to configure the Visual Studio compiler for ARM64.

## Rollback

To revert to x64 configuration:
```json
{
    "cmake.cmakePath": "C:\\Program Files\\CMake\\bin\\cmake.exe",
    "cmake.configureSettings": {
        "CMAKE_PREFIX_PATH": "c:/Qt/6.10.0/msvc2022_64"
    },
    "cmake.environment": {
        "PATH": "c:/Qt/6.10.0/msvc2022_64/bin;${env:PATH}"
    }
}
```

## Notes for Agent Execution

**Tools to use:**
- `Read` tool to check current settings
- `Edit` tool to update the paths (replace `msvc2022_64` with `msvc2022_arm64`)
- `Bash` tool to verify Qt ARM64 installation
- `Read` tool again to verify the changes

**Expected execution time:** ~5 minutes
