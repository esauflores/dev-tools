FROM debian:bookworm-slim

ARG MISE_VERSION=2026.1.7
ARG TOOLS_DIR=/tools

RUN apt-get update \
    && apt-get -y --no-install-recommends install \
    zstd curl git ca-certificates build-essential \
    && rm -rf /var/lib/apt/lists/*

# Mise environment variables
ENV TOOLS_DIR="${TOOLS_DIR}"
ENV MISE_DATA_DIR="${TOOLS_DIR}"
ENV MISE_CONFIG_DIR="${TOOLS_DIR}/config"
ENV MISE_CACHE_DIR="${TOOLS_DIR}/cache"
ENV MISE_INSTALL_PATH=/usr/local/bin/mise
ENV PATH="${TOOLS_DIR}/shims:${PATH}"
ENV MISE_GITHUB_ATTESTATIONS=false
ENV MISE_VERSION=${MISE_VERSION}

RUN curl https://mise.run | sh

COPY mise.toml ${TOOLS_DIR}/config/mise.toml

RUN sh -c "\
    rm -rf ${TOOLS_DIR}/shims ${TOOLS_DIR}/installs \
    && mise install \
    && chmod 755 ${TOOLS_DIR}/shims/* \
    "
