# Azahar Dev Container

This directory contains the development container configuration for Azahar emulator development.

## What's Included

The dev container provides a complete Ubuntu 22.04-based development environment with:

### Compilers & Build Tools
- GCC and Clang 15
- CMake and Ninja build system
- ccache for faster rebuilds
- clang-format, clang-tidy for code quality

### Dependencies
- Qt6 (for desktop GUI)
- SDL2 (for input and windowing)
- Vulkan SDK (for graphics)
- Boost libraries
- OpenSSL, libusb, FFmpeg libraries
- Catch2 testing framework

### Development Tools
- Git and GitHub CLI
- GDB, LLDB debuggers
- Valgrind for memory checking
- Performance profiling tools

### VS Code Extensions
- C/C++ IntelliSense
- CMake Tools
- Clangd language server
- GitHub Copilot
- GitLens and Git Graph
- Doxygen documentation generator

## Getting Started

1. **Open in Container**
   - Install Docker Desktop and VS Code Remote Containers extension
   - Open this repository in VS Code
   - Click "Reopen in Container" when prompted
   - Wait for the container to build and setup to complete

2. **Configure Build**
   ```bash
   cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo
   ```

3. **Build Project**
   ```bash
   cmake --build build -j$(nproc)
   ```

4. **Run Azahar**
   ```bash
   ./build/bin/citra-qt
   ```

## Build Configurations

### Debug Build (for development)
```bash
cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Debug
cmake --build build
```

### Release Build (optimized)
```bash
cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Release
cmake --build build
```

### RelWithDebInfo (recommended for testing)
```bash
cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo
cmake --build build
```

## Running Tests

```bash
ctest --test-dir build
```

## Code Formatting

Format all source files:
```bash
find src -name "*.cpp" -o -name "*.h" | xargs clang-format -i
```

## Debugging

### GDB
```bash
gdb ./build/bin/citra-qt
```

### LLDB
```bash
lldb ./build/bin/citra-qt
```

### Valgrind (Memory Leaks)
```bash
valgrind --leak-check=full ./build/bin/citra-qt
```

## ccache Statistics

Check build cache effectiveness:
```bash
ccache -s
```

## Notes

- The container mounts the workspace folder, so all changes persist
- Git credentials are shared from the host
- The container runs as the `vscode` user (non-root)
- X11 forwarding is configured for GUI applications (may need setup on host)

## Troubleshooting

### GUI doesn't display
On Linux hosts, you may need to allow X11 connections:
```bash
xhost +local:docker
```

### Submodules not initialized
```bash
git submodule update --init --recursive
```

### Build cache issues
Clear ccache:
```bash
ccache -C
```

### Permission issues
The container runs as user `vscode`. If you have permission issues:
```bash
sudo chown -R vscode:vscode /workspaces/azahar
```
