---
name: Performance Improvement
about: Template for performance optimization pull requests
---

## Performance Issue
<!-- Describe the performance problem being addressed -->

## Optimization Approach
<!-- Explain the optimization strategy used -->

## Technical Changes
<!-- Describe the technical changes made -->

## Benchmarks
<!-- Provide concrete performance measurements -->

### Before Optimization
```
Metric: [fps/frame time/memory/etc.]
Value: 
Test case: 
```

### After Optimization
```
Metric: [same as above]
Value: 
Test case: 
Improvement: [X% faster / Y MB less memory / etc.]
```

### Benchmark Configuration
- **Hardware tested**: <!-- CPU/GPU model -->
- **Platform**: <!-- Windows/macOS/Linux/Android -->
- **Build type**: Release
- **Profiler used**: <!-- Visual Studio Profiler/perf/Instruments/etc. -->

## Testing
### Performance Testing
- [ ] Benchmarked with representative workloads
- [ ] Tested on multiple hardware configurations
- [ ] Verified improvement is consistent
- [ ] No performance regression in other areas

### Correctness Testing
- [ ] Emulation accuracy maintained
- [ ] Tested with game(s): <!-- List games -->
- [ ] Visual/audio output unchanged
- [ ] No new bugs introduced

### Test Configuration
- **Games tested**: <!-- List games used for testing -->
- **Platforms tested**: <!-- Windows/macOS/Linux/Android -->

## Profiling Data
<!-- Include profiler screenshots or relevant data -->

### Hotspot Analysis (Before)
<!-- What was the bottleneck? -->

### Hotspot Analysis (After)
<!-- How was it improved? -->

## Impact Analysis
- **CPU usage**: <!-- Improvement percentage -->
- **Memory usage**: <!-- Change in MB -->
- **GPU usage**: <!-- If applicable -->
- **Frame time**: <!-- Average improvement -->
- **Affected components**: <!-- Which parts of emulator -->

## Code Quality
- [ ] Code readability maintained or improved
- [ ] No unnecessary complexity added
- [ ] Comments explain optimization rationale
- [ ] Platform-specific optimizations documented

## Compatibility
- [ ] All platforms benefit or unaffected
- [ ] No platform-specific regressions
- [ ] Save state compatibility maintained

## Trade-offs
<!-- Any trade-offs made (e.g., accuracy vs speed) -->

## Checklist
- [ ] Code follows style guidelines (clang-format applied)
- [ ] Benchmarks documented with methodology
- [ ] Tested on representative hardware
- [ ] No emulation accuracy loss
- [ ] Compiler optimizations considered
- [ ] Memory leaks checked (if applicable)
- [ ] Thread safety maintained (if concurrent code)

## Related Issues
Closes #
Related to #

## Additional Notes
<!-- Any other relevant information about the optimization -->
