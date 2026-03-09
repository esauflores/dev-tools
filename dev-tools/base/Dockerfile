FROM ubuntu:24.04

RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates git sudo tini jq \
  && rm -rf /var/lib/apt/lists/*

COPY --from=ghcr.io/jdx/mise:2026.3.5 /usr/local/bin/mise /tools/bin/mise

RUN mkdir -p /tools/config /tools/bin /tools/shims \
  /tools/mise /tools/uv

### Global tools path ###
ENV PATH="/tools/bin:/tools/shims:${PATH}"

### MISE env vars ###
ENV MISE_DATA_DIR="/tools/mise"
ENV MISE_CACHE_DIR="/tools/.cache/mise"
ENV MISE_INSTALL_PATH="/tools/bin/mise"
# Always needed env vars for mise
ENV MISE_CONFIG_DIR="/tools/config"
ENV MISE_SHIMS_DIR="/tools/shims"

### UV env vars ###
ENV UV_TOOL_DIR="/tools/uv"
ENV UV_TOOL_BIN_DIR="/tools/bin"
ENV UV_CACHE_DIR="/tools/.cache/uv"
ENV UV_PYTHON="3.11"

COPY config/ /tools/config/

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

HEALTHCHECK --interval=5s --timeout=5s --start-period=300s --retries=5 \
  CMD test -f /tools/.ready

ENTRYPOINT ["/usr/bin/tini", "--", "/entrypoint.sh"]
CMD ["sleep", "infinity"]
