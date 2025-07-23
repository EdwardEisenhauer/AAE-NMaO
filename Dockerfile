FROM ubuntu:24.04

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    texlive-full=2023.20240207-1 \
    make=4.3-4.1build2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
