# Makefile for ZX Spectrum Basic projects

.PHONY: all clean build examples build-asm examples-asm help

# Default target
all: build build-asm

# Build all source files
build:
	@echo "Building ZX Spectrum Basic projects..."
	@mkdir -p build
	@for basfile in src/*.bas; do \
		if [ -f "$$basfile" ]; then \
			filename=$$(basename "$$basfile" .bas); \
			echo "Compiling $$basfile..."; \
			zxbc "$$basfile" -o "build/$$filename.tap" -O 2; \
			zxbc "$$basfile" -o "build/$$filename.bin" -O 2; \
		fi \
	done
	@echo "Build complete!"

# Build example files
examples:
	@echo "Building example files..."
	@mkdir -p build/examples
	@for basfile in examples/*.bas; do \
		if [ -f "$$basfile" ]; then \
			filename=$$(basename "$$basfile" .bas); \
			echo "Compiling $$basfile..."; \
			zxbc "$$basfile" -o "build/examples/$$filename.tap" -O 2; \
			zxbc "$$basfile" -o "build/examples/$$filename.bin" -O 2; \
		fi \
	done
	@echo "Examples build complete!"

# Build assembly source files
build-asm:
	@echo "Building Z80 Assembly projects..."
	@mkdir -p build/asm
	@for asmfile in src/asm/*.asm; do \
		if [ -f "$$asmfile" ]; then \
			filename=$$(basename "$$asmfile" .asm); \
			echo "Assembling $$asmfile..."; \
			sjasmplus --raw="build/asm/$$filename.bin" "$$asmfile" || \
			z80asm -o "build/asm/$$filename.bin" "$$asmfile"; \
		fi \
	done
	@echo "Assembly build complete!"

# Build assembly examples
examples-asm:
	@echo "Building assembly example files..."
	@mkdir -p build/examples/asm
	@for asmfile in examples/asm/*.asm; do \
		if [ -f "$$asmfile" ]; then \
			filename=$$(basename "$$asmfile" .asm); \
			echo "Assembling $$asmfile..."; \
			sjasmplus --raw="build/examples/asm/$$filename.bin" "$$asmfile" || \
			z80asm -o "build/examples/asm/$$filename.bin" "$$asmfile"; \
		fi \
	done
	@echo "Assembly examples build complete!"

# Clean build artifacts
clean:
	@echo "Cleaning build directory..."
	@rm -rf build
	@echo "Clean complete!"

# Show help
help:
	@echo "Available targets:"
	@echo "  all         - Build all BASIC and assembly source files (default)"
	@echo "  build       - Build all BASIC source files in src/"
	@echo "  build-asm   - Build all assembly source files in src/asm/"
	@echo "  examples    - Build all BASIC example files in examples/"
	@echo "  examples-asm- Build all assembly example files in examples/asm/"
	@echo "  clean       - Remove all build artifacts"
	@echo "  help        - Show this help message"