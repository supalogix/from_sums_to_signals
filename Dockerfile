FROM debian:bookworm-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    wget curl perl make texinfo ghostscript \
    fontconfig libfontconfig1-dev \
    unzip openjdk-17-jre \
    && apt-get clean

# Install TeX Live full (includes MetaPost, LuaLaTeX, and many extras)
RUN apt-get update && \
    apt-get install -y texlive-full && \
    apt-get clean

# Install PlantUML
RUN mkdir -p /opt/plantuml && \
    curl -L -o /opt/plantuml/plantuml.jar https://github.com/plantuml/plantuml/releases/latest/download/plantuml.jar

# Add convenient wrapper script to /usr/local/bin
RUN echo '#!/bin/sh\nexec java -jar /opt/plantuml/plantuml.jar "$@"' > /usr/local/bin/plantuml && \
    chmod +x /usr/local/bin/plantuml

# Set default working directory
WORKDIR /data

# Set PATH for easier usage
ENV PATH="/usr/local/bin:$PATH"

# Default command can be overridden when running container
CMD ["lualatex", "the_survival_guide.tex"]
