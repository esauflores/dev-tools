# toolbox

Custom dev-tools Docker image for local development and self-hosted deployments.

## dev-tools - base

Based on `ubuntu:24.04`. Tools are managed by [mise](https://mise.jdx.dev/) and persisted on a shared volume mounted at `/tools`.

### Tools

| Category         | Tools                                       |
| ---------------- | ------------------------------------------- |
| Runtimes         | Node 24, Python 3.11, Go 1.26               |
| Package managers | uv                                          |
| Infrastructure   | kubectl, terraform, docker-cli, ansible     |
| Secrets          | sops, age                                   |
| CLI utilities    | just, gh, jq, yq, bat, ripgrep, fzf, direnv |

### Configuration

| Variable       | Default  | Description                                   |
| -------------- | -------- | --------------------------------------------- |
| `GITHUB_TOKEN` | _(none)_ | GitHub token to increase mise API rate limits |

### Usage

```bash
docker pull git.fastwaydata.com/esauflores/dev-tools:base
```

```yaml
services:
  dev-tools:
    image: git.fastwaydata.com/esauflores/dev-tools:base
    environment:
      - GITHUB_TOKEN=${GITHUB_TOKEN}
    volumes:
      - dev-tools-data:/tools

volumes:
  dev-tools-data:
```

On first run the container installs all tools into the volume. Once healthy, the volume can be mounted read-only in other containers:

```yaml
services:
  app:
    volumes:
      - dev-tools-data:/tools:ro
```

Add the following to your container's `Dockerfile` to use the tools:

```dockerfile
ENV MISE_DATA_DIR="/tools/mise"
ENV MISE_CONFIG_DIR="/tools/config"
ENV PATH="/tools/bin:/tools/shims:${PATH}"
```
