#!/bin/bash
# Dev Container Setup Script for Azahar Emulator

set -e

echo "=== Azahar Dev Container Setup ==="

# Update package lists
echo "Updating package lists..."
sudo apt-get update

# Install build essentials and tools
echo "Installing build tools..."
sudo apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    ccache \
    git \
    pkg-config \
    clang-15 \
    clang-format-15 \
    clang-tidy-15 \
    lldb-15 \
    lld-15

# Create clang symlinks
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-15 100
sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-15 100
sudo update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-15 100

# Install Qt6 dependencies
echo "Installing Qt6 dependencies..."
sudo apt-get install -y \
    qt6-base-dev \
    qt6-base-private-dev \
    qt6-multimedia-dev \
    qt6-tools-dev \
    libqt6svg6-dev \
    libqt6opengl6-dev \
    libglx-dev \
    libgl1-mesa-dev

# Install SDL2
echo "Installing SDL2..."
sudo apt-get install -y \
    libsdl2-dev

# Install Vulkan dependencies
echo "Installing Vulkan..."
sudo apt-get install -y \
    libvulkan-dev \
    vulkan-tools \
    vulkan-validationlayers

# Install additional libraries
echo "Installing additional dependencies..."
sudo apt-get install -y \
    libusb-1.0-0-dev \
    libavcodec-dev \
    libavformat-dev \
    libavutil-dev \
    libswscale-dev \
    libssl-dev \
    libfmt-dev \
    libboost-all-dev \
    catch2

# Install tools for profiling and debugging
echo "Installing profiling tools..."
sudo apt-get install -y \
    gdb \
    valgrind \
    linux-tools-generic \
    heaptrack

# Clean up
echo "Cleaning up..."
sudo apt-get autoremove -y
sudo apt-get clean

# Initialize git submodules
echo "Initializing git submodules..."
git submodule update --init --recursive || true

# Setup ccache
echo "Configuring ccache..."
ccache --max-size=5G
ccache --set-config=compression=true

# Create build directory
echo "Creating build directory..."
mkdir -p build

echo ""
echo "=== Setup Complete ==="
echo ""
echo "Quick start commands:"
echo "  cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo"
echo "  cmake --build build -j\$(nproc)"
echo "  ./build/bin/citra-qt"
echo ""
echo "For debug builds:"
echo "  cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Debug"
echo ""
echo "To run tests:"
echo "  ctest --test-dir build"
echo ""
