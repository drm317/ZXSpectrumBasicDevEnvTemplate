#!/bin/bash

# ZX Spectrum Basic Build Script
# Compiles .bas files using Boriel Basic compiler

set -e

BUILD_DIR="build"
SRC_DIR="src"
ASM_SRC_DIR="src/asm"

# Create build directory if it doesn't exist
mkdir -p "$BUILD_DIR"

echo "Building ZX Spectrum Basic projects..."

# Compile all .bas files in src directory
for basfile in "$SRC_DIR"/*.bas; do
    if [ -f "$basfile" ]; then
        filename=$(basename "$basfile" .bas)
        echo "Compiling $basfile..."
        
        # Compile to TAP format (ZX Spectrum tape format)
        zxbc "$basfile" -o "$BUILD_DIR/$filename.tap" -O 2
        
        # Also compile to binary
        zxbc "$basfile" -o "$BUILD_DIR/$filename.bin" -O 2 --output-file-type=bin
        
        echo "Created: $BUILD_DIR/$filename.tap and $BUILD_DIR/$filename.bin"
    fi
done

echo "Build complete! Output files are in the $BUILD_DIR directory."

# Compile assembly files if they exist
if [ -d "$ASM_SRC_DIR" ] && [ "$(ls -A "$ASM_SRC_DIR"/*.asm 2>/dev/null)" ]; then
    echo ""
    echo "Building Z80 Assembly projects..."
    mkdir -p "$BUILD_DIR/asm"
    
    for asmfile in "$ASM_SRC_DIR"/*.asm; do
        if [ -f "$asmfile" ]; then
            filename=$(basename "$asmfile" .asm)
            echo "Assembling $asmfile..."
            
            # Try SjASMPlus first, fallback to z80asm
            if command -v sjasmplus >/dev/null 2>&1; then
                sjasmplus --raw="$BUILD_DIR/asm/$filename.bin" "$asmfile"
            elif command -v z80asm >/dev/null 2>&1; then
                z80asm -o "$BUILD_DIR/asm/$filename.bin" "$asmfile"
            else
                echo "Warning: No Z80 assembler found. Skipping assembly files."
                break
            fi
            
            echo "Created: $BUILD_DIR/asm/$filename.bin"
        fi
    done
    
    echo "Assembly build complete!"
fi