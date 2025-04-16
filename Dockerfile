FROM debian:bookworm-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    wget curl perl make texinfo ghostscript \
    fontconfig libfontconfig1-dev \
    unzip \
    && apt-get clean

# Install TeX Live full (recommended for LuaLaTeX + MetaPost)
RUN apt-get update && \
    apt-get install -y texlive-full && \
    apt-get clean

# Set default workdir
WORKDIR /data

# Default command to run LuaLaTeX
CMD ["lualatex", "main.tex"]
