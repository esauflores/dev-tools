# dev-tools

Curated set of dev tools managed by [mise](https://mise.jdx.dev/). Use as a submodule to share a consistent toolset across projects.

## Tools

| Category         | Tools                                              |
| ---------------- | -------------------------------------------------- |
| Languages        | Node 24, Python 3.11, Go 1.26, DuckDB 1            |
| Package managers | uv                                                 |
| Secrets          | sops, age                                          |
| Infra            | mc (MinIO client), Supabase CLI                    |
| Dev utilities    | bat, eza, ripgrep, fzf, jq, yq, just, gh, starship |

## Usage as a submodule

Add to your project:

```bash
git submodule add <repo-url> dev-tools
```

In your `Dockerfile`, install the tools:

```dockerfile
COPY dev-tools/mise.toml /tmp/mise.toml

RUN curl https://mise.run | sh \
    && mise install --config /tmp/mise.toml
```

Add the shims to `PATH`:

```dockerfile
ENV PATH="/tools/shims:${PATH}"
```

## Updating tools

Edit `mise.toml`, bump versions, commit, then update the submodule reference in consuming projects:

```bash
git submodule update --remote dev-tools
```

## Standalone usage

To populate a Docker volume directly:

```bash
cp .env.example .env  # optional, fill in GITHUB_TOKEN
docker volume create dev-tools
docker compose up
```
