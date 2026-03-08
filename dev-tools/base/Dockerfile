FROM ubuntu:24.04

RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates git sudo tini jq \
  && rm -rf /var/lib/apt/lists/*

COPY --from=ghcr.io/jdx/mise:2026.3.5 /usr/local/bin/mise /tools/bin/mise

# Always needed env vars for mise
ENV PATH="/tools/bin:/tools/shims:${PATH}"
ENV MISE_DATA_DIR="/tools"
ENV MISE_CONFIG_DIR="/tools/config"

# Installation and cache paths
ENV MISE_CACHE_DIR="/tools/.cache"
ENV MISE_INSTALL_PATH="/tools/bin/mise"

# UV environment variables
ENV UV_TOOL_BIN_DIR=/tools/bin
ENV UV_PYTHON=3.11

COPY mise.toml /tools/config/mise.toml

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

HEALTHCHECK --interval=5s --timeout=5s --start-period=300s --retries=5 \
  CMD test -f /tools/.ready

ENTRYPOINT ["/usr/bin/tini", "--", "/entrypoint.sh"]
CMD ["sleep", "infinity"]
