---
name: Graphics/Video Fix
about: Template for graphics and rendering pull requests
---

## Graphics Issue
<!-- Describe the rendering problem being fixed -->

## Root Cause
<!-- Explain what was causing the graphics issue -->
- **Affected component**: <!-- GPU command processing/Shader/Texture/etc. -->
- **Hardware behavior**: <!-- How real 3DS hardware handles this -->

## Solution
<!-- Describe the fix implementation -->

## Related Issues
Fixes #

## Testing
### Visual Testing
- [ ] Graphics render correctly
- [ ] Tested with affected game(s): <!-- List games -->
- [ ] No visual regressions in other games
- [ ] Screenshots/video comparison provided

### Rendering Backends
- [ ] OpenGL backend tested
- [ ] Vulkan backend tested
- [ ] Software renderer tested (if applicable)
- [ ] Metal backend tested (macOS/iOS, if applicable)

### Platform Testing
- [ ] Windows (GPU: <!-- NVIDIA/AMD/Intel -->)
- [ ] Linux (GPU: <!-- NVIDIA/AMD/Intel -->)
- [ ] macOS (GPU: <!-- Intel/AMD/Apple Silicon -->)
- [ ] Android (GPU: <!-- Adreno/Mali/PowerVR -->)

## Screenshots/Videos
<!-- REQUIRED: Before/after comparison -->

### Before Fix
<!-- Screenshot or video showing the issue -->

### After Fix
<!-- Screenshot or video showing the fix -->

### Reference (Real 3DS)
<!-- Optional: Screenshot from real hardware if available -->

## Technical Details
### Shader Changes
<!-- If shader code was modified -->
- [ ] PICA200 shader assembly behavior researched
- [ ] GLSL translation correct
- [ ] SPIR-V generation verified (for Vulkan)

### GPU State Changes
<!-- If GPU state handling was modified -->
- [ ] State changes match hardware behavior
- [ ] State transitions handled correctly
- [ ] Cache invalidation proper

### Performance Impact
<!-- Measure frame time impact if relevant -->
- **Frame time change**: <!-- +/- X ms or "negligible" -->
- **Draw call changes**: <!-- If modified -->

## Hardware Documentation
<!-- Reference to 3DS hardware documentation -->
- **3dbrew reference**: <!-- Link to relevant 3dbrew.org page -->
- **Hardware behavior**: <!-- Description of correct behavior -->

## Compatibility
- **Games fixed**: <!-- List games where issue was present -->
- **Games tested for regression**: <!-- List other games tested -->

## Code Quality
- [ ] Code follows style guidelines (clang-format applied)
- [ ] Shader code properly commented
- [ ] Complex logic well-documented
- [ ] Follows existing rendering patterns

## Checklist
- [ ] Tested on multiple rendering backends
- [ ] Tested on different GPU vendors
- [ ] Screenshots provided showing fix
- [ ] No performance regression
- [ ] Hardware documentation referenced
- [ ] Similar issues checked in codebase

## Additional Notes
<!-- Any other relevant information -->
