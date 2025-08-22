# Use Ubuntu 22.04 as base image (ARM64 compatible)
FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    git \
    python3 \
    python3-pip \
    build-essential \
    unzip \
    sudo \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Create vscode user
RUN groupadd --gid 1000 vscode \
    && useradd --uid 1000 --gid vscode --shell /bin/bash --create-home vscode \
    && echo vscode ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/vscode \
    && chmod 0440 /etc/sudoers.d/vscode

# Install Boriel Basic compiler
RUN cd /tmp && \
    wget -O zxbasic.zip https://github.com/boriel/zxbasic/archive/refs/heads/master.zip && \
    unzip zxbasic.zip && \
    mv zxbasic-main /opt/zxbasic && \
    chmod +x /opt/zxbasic/zxbc.py && \
    ln -s /opt/zxbasic/zxbc.py /usr/local/bin/zxbc && \
    rm zxbasic.zip

# Install Python dependencies for Boriel Basic
RUN pip3 install ply

# Install Z80 assembler toolchain
RUN apt-get update && apt-get install -y \
    z80asm \
    && rm -rf /var/lib/apt/lists/*

# Install SjASMPlus (modern Z80 cross-assembler)
RUN cd /tmp && \
    git clone --recursive https://github.com/z00m128/sjasmplus.git && \
    cd sjasmplus && \
    git checkout v1.20.3 && \
    git submodule update --init --recursive && \
    make && \
    sudo cp sjasmplus /usr/local/bin/ && \
    cd .. && \
    rm -rf sjasmplus

# Set up working directory
WORKDIR /workspace

# Switch to vscode user
USER vscode

# Set environment variables
ENV PATH="/opt/zxbasic:${PATH}"
ENV PYTHONPATH="/opt/zxbasic"