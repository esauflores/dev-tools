# dev-tools

Populates a shared `dev-tools` Docker volume with dev tools using [mise](https://mise.jdx.dev/). Run once, mount everywhere.

## Prerequisites

Create the external volume:

```bash
docker volume create dev-tools
```

Optionally, set a GitHub token to avoid API rate limits:

```bash
cp .env.example .env
# fill in GITHUB_TOKEN
```

## Usage

```bash
docker compose up
```

## Tools

| Category         | Tools                                              |
| ---------------- | -------------------------------------------------- |
| Languages        | Node 24, Python 3.11, Go 1.26, DuckDB 1            |
| Package managers | uv                                                 |
| Secrets          | sops, age                                          |
| Infra            | mc (MinIO client), Supabase CLI                    |
| Dev utilities    | bat, eza, ripgrep, fzf, jq, yq, just, gh, starship |

## Consuming the volume

```yaml
volumes:
  - dev-tools:/tools
environment:
  - PATH=/tools/shims:${PATH}

volumes:
  dev-tools:
    name: dev-tools
    external: true
```

## Updating tools

Edit `mise.toml`, bump versions, re-run `docker compose up`.
