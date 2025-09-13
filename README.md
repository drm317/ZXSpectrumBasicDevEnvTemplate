# ZX Spectrum Development Environment Template

A VS Code devcontainer template for ZX Spectrum programming using Boriel Basic compiler and Z80 assembly tools, optimized for Apple Silicon Mac hosts.

## Features

- **Boriel Basic Compiler**: Pre-installed ZX Basic compiler for creating ZX Spectrum programs
- **Z80 Assembly Support**: SjASMPlus and z80asm assemblers for low-level programming
- **ARM64 Compatible**: Optimized for Apple Silicon Mac hosts
- **VS Code Integration**: Configured with syntax highlighting and build tasks
- **Sample Projects**: Includes example programs demonstrating graphics, sound, and basic functionality in both BASIC and assembly
- **Build Scripts**: Ready-to-use compilation scripts and Makefile for both languages

## Quick Start

1. **Open in VS Code**: Open this folder in VS Code
2. **Reopen in Container**: When prompted, click "Reopen in Container" or use `Ctrl+Shift+P` → "Dev Containers: Reopen in Container"
3. **Wait for Setup**: The container will build automatically (first time may take a few minutes)
4. **Start Coding**: Edit `.bas` files in the `src/` directory or `.asm` files in the `src/asm/` directory

## Project Structure

```
├── .devcontainer/          # Dev container configuration
│   ├── devcontainer.json   # VS Code devcontainer settings
│   └── Dockerfile          # Container setup with Boriel Basic
├── .vscode/                # VS Code workspace settings
│   ├── extensions.json     # Recommended extensions
│   └── settings.json       # File associations and runner config
├── src/                    # Your ZX Spectrum source files
│   ├── hello.bas          # Sample BASIC hello world program
│   └── asm/               # Z80 Assembly source files
│       └── hello.asm      # Sample assembly hello world program
├── examples/               # Example programs
│   ├── graphics.bas       # BASIC graphics demonstration
│   ├── sound.bas          # BASIC sound/beeper demonstration
│   └── asm/               # Assembly example programs
│       ├── graphics.asm   # Assembly graphics demonstration
│       └── sound.asm      # Assembly sound demonstration
├── build.sh               # Build script
├── Makefile              # Make-based build system
└── README.md             # This file
```

## Building Programs

### Using the Build Script
```bash
./build.sh
```

### Using Make
```bash
make build          # Build all BASIC files in src/
make build-asm      # Build all assembly files in src/asm/
make examples       # Build all BASIC example files
make examples-asm   # Build all assembly example files
make all            # Build all BASIC and assembly files (default)
make clean          # Clean build artifacts
make help           # Show available targets
```

### Manual Compilation

#### BASIC Files
```bash
# Compile to TAP format (ZX Spectrum tape)
zxbc src/hello.bas -o build/hello.tap

# Compile to binary
zxbc src/hello.bas -o build/hello.bin
```

#### Assembly Files
```bash
# Using SjASMPlus (recommended)
sjasmplus --raw=build/hello.bin src/asm/hello.asm

# Using z80asm (alternative)
z80asm -o build/hello.bin src/asm/hello.asm
```

## Output Formats

### BASIC Programs
- **TAP files**: ZX Spectrum tape format, can be loaded into emulators
- **BIN files**: Raw binary format

### Assembly Programs
- **BIN files**: Raw binary format that can be loaded into memory at the specified ORG address

## Example Programs

### BASIC Examples
- **Hello World** (`src/hello.bas`) - Simple program demonstrating basic text output and user interaction
- **Graphics Demo** (`examples/graphics.bas`) - Shows basic graphics capabilities including line drawing and plotting
- **Sound Demo** (`examples/sound.bas`) - Demonstrates the ZX Spectrum's beeper sound capabilities

### Assembly Examples
- **Graphics Demo** (`examples/asm/graphics.asm`) - Low-level graphics programming with pixel plotting and line drawing
- **Sound Demo** (`examples/asm/sound.asm`) - Direct beeper control and simple music generation

## Running on ZX Spectrum

### BASIC Programs
The compiled `.tap` files can be loaded into:
- **Emulators**: FUSE, SpectEmu, ZEsarUX, etc.
- **Real Hardware**: Using tape interfaces or modern solutions like DivMMC

### Assembly Programs
The compiled `.bin` files can be loaded using:
- **BASIC LOAD command**: `LOAD "filename" CODE 32768` (adjust address as needed)
- **Emulator memory loading**: Direct memory loading at the ORG address
- **Real Hardware**: Using modern solutions like DivMMC, +3DOS, or custom loaders