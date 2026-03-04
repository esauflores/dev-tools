# dev-tools

Curated set of dev tools managed by [mise](https://mise.jdx.dev/). Docker-based development environment with tools persisted on a shared volume.

## Tools

| Category         | Tools                                              |
| ---------------- | -------------------------------------------------- |
| Languages        | Node 24, Python 3.11, Go 1.26, DuckDB 1            |
| Package managers | uv                                                 |
| Secrets          | sops, age                                          |
| Infra            | mc (MinIO client), Supabase CLI                    |
| Dev utilities    | bat, eza, ripgrep, fzf, jq, yq, just, gh, starship |

## Quick Start

Clone and run the dev-tools container:

```bash
git clone https://github.com/esauflores/dev-tools
cd dev-tools
cp .env.example .env  # optional, fill in GITHUB_TOKEN
docker compose up
```

This will:

- Create a `dev-tools` Docker volume to persist tool data and configurations
- Start the container with the volume mounted at `/tools`
- Install all tools via mise on first run

**Optional (Important):** Set `GITHUB_TOKEN` in `.env` to increase GitHub API rate limits for mise.

## Using the Volume in Other Containers

The `dev-tools` container populates the volume with all tools. Use that volume in your other containers:

```yaml
services:
  app:
    volumes:
      - dev-tools:/tools:ro
```

Add `/tools/shims` to `PATH` in your container's Dockerfile:

```dockerfile
ENV PATH="/tools/shims:${PATH}"
```

All dev-tools are now available in your container.

## Updating Tools

Edit `mise.toml`, update versions as needed, then rebuild:

```bash
docker compose build --no-cache
docker compose up
```

The `dev-tools` volume persists tool data between runs.
