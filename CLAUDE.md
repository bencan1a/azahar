# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Azahar is a 3DS emulator based on Citra, supporting multiple platforms (Windows, macOS, Linux, Android) and frontends (Qt GUI, SDL2 CLI). The codebase is written in C++20 and uses CMake for building.

## Build Commands

### Desktop (Windows/Linux/macOS)

```bash
# Initial setup - ensure submodules are present
git submodule update --init --recursive

# Standard build
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
cmake --build . -- -j$(nproc)  # Linux/macOS
cmake --build . -- -j%NUMBER_OF_PROCESSORS%  # Windows

# Build specific frontend only
cmake .. -DENABLE_QT=OFF  # Skip Qt GUI, build SDL2 only
cmake .. -DENABLE_SDL2_FRONTEND=OFF  # Qt only

# Optimized builds
cmake .. -DENABLE_LTO=ON  # Link-time optimization (default on non-MSVC release builds)
cmake .. -DENABLE_NATIVE_OPTIMIZATION=ON  # CPU-specific optimizations via -march=native
```

### Android

Open `src/android` in Android Studio and build via 'Build' > 'Make Project'.

### Create distributable bundle

```bash
make bundle  # After building, creates distributable package
```

## Testing

Tests use the Catch2 framework:

```bash
# From build directory
ctest  # Run all tests
./bin/tests  # Run test executable directly
```

Tests are located in `src/tests/` and cover:
- Common utilities (bit fields, file utilities, parameter packages)
- Core emulation (memory, file system, kernel IPC, core timing)
- Audio core (HLE/LLE, DSP processing, decoders)
- Video core (shader compilation)

## Code Quality

### Formatting

```bash
# From root directory
cmake --build build --target clang-format
```

This runs clang-format-15 against all .h, .cpp, and .mm files in `src/`. The project will auto-download clang-format on Windows if not found.

## Architecture

### Multi-Frontend Design

The emulator uses a **separation of concerns** architecture where the core emulation is completely decoupled from presentation:

- **Core emulation** (`src/core/`) implements the 3DS hardware/OS through HLE (High-Level Emulation)
- **Frontends** implement the abstract interfaces defined in `src/core/frontend/`
- **citra_meta** (`src/citra_meta/main.cpp`) acts as a launcher that dispatches to the appropriate frontend based on command-line arguments

Three frontend implementations exist:
1. **Qt** (`src/citra_qt/`) - Full-featured GUI with debugger, configuration, game list
2. **SDL2** (`src/citra_sdl/`) - Lightweight CLI for headless/server scenarios
3. **Android** (`src/android/`) - Native Android app using JNI bridge to core

### Rendering Backend Architecture

The emulator supports multiple rendering backends through the `RendererBase` abstraction in `src/video_core/`:

- **OpenGL** (`renderer_opengl/`) - Desktop GL 4.3+, can be disabled on Linux aarch64 with `-DENABLE_OPENGL=OFF`
- **Vulkan** (`renderer_vulkan/`) - Cross-platform Vulkan 1.1+
- **Software** (`renderer_software/`) - CPU-based fallback

The Pica200 GPU (3DS GPU) is emulated in `src/video_core/pica/`. Shaders are JIT-compiled using platform-specific backends:
- `shader_jit_x64_compiler.cpp` for x86-64
- `shader_jit_a64_compiler.cpp` for ARM64
- `shader_interpreter.cpp` as fallback

### ARM CPU Emulation

Two CPU emulation backends provide flexibility vs. performance tradeoffs:

- **Dynarmic** (`src/core/arm/dynarmic/`) - JIT recompiler for x86-64 and ARM64, high performance
- **Dyncom** (`src/core/arm/dyncom/`) - Interpreter fallback, portable but slower

### HLE Service Framework

The 3DS OS is emulated through HLE in `src/core/hle/`:

- **Kernel** (`hle/kernel/`) - Threads, processes, memory management, IPC
- **Services** (`hle/service/`) - 40+ system service modules (FS, GSP, HID, CAM, etc.)
- **Applets** (`hle/applets/`) - System UI components (Mii selector, software keyboard, etc.)

Services use a template-based IPC framework. Adding new service implementations requires understanding the IPC command handler registration pattern.

### File System Architecture

Virtual file system (`src/core/file_sys/`) supports multiple archive backends:
- SDMC (SD card emulation)
- Save data, ExtSaveData, SystemSaveData
- NCCH RomFS (read-only game data)
- Artic network archives (for loading from real hardware)

Loaders (`src/core/loader/`) support multiple formats: NCCH/CXI, CIA, 3DSX (homebrew), ELF, Artic.

### Audio Subsystem

Two emulation modes in `src/audio_core/`:

- **HLE** (`hle/`) - Fast software audio processing with AAC decoding
- **LLE** (`lle/`) - Cycle-accurate DSP emulation using the Teakra library

Output sinks are configurable: SDL2, Cubeb, OpenAL, or null. Audio and video cores run independently of the CPU core.

### Cross-Platform Considerations

Platform-specific code is isolated:
- Apple: Uses Objective-C/C++ for Cocoa, AVFoundation, IOSurface, MoltenVK (Vulkan)
- Windows: Links against winmm, ws2_32, and additional libraries for MinGW (psapi, imm32)
- Linux: Requires rt library
- Android: JNI layer in `src/android/app/src/main/jni/` bridges Java UI to C++ core

### Memory Layout & Timing

- `Memory::MemorySystem` manages the 3DS memory map (FCRAM, VRAM, DSP RAM, etc.)
- `Core::Timing` provides cycle-accurate event scheduling
- All timing-sensitive operations (CPU, GPU, DSP) use the timing system for synchronization

### CMake Configuration

Important CMake options that affect available functionality:
- `ENABLE_DEVELOPER_OPTIONS` - Enables stress testing tools (e.g., game launch stress tests)
- `ENABLE_SCRIPTING` - RPC server for scripting
- `ENABLE_WEB_SERVICE` - Telemetry and online services
- `ENABLE_TESTS` - Build test executable (enabled by default except iOS)
- `ENABLE_ROOM` - Multiplayer room/lobby functionality
- `CITRA_USE_PRECOMPILED_HEADERS` - Faster compilation (enabled by default)
- `CITRA_WARNINGS_AS_ERRORS` - Treat warnings as errors (enabled by default)

### Serialization & Save States

Boost.Serialization is used extensively throughout the codebase for save state support. When modifying core emulation structures, ensure serialization code is updated appropriately.
