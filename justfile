set shell := ["bash", "-c"]

IMAGE := env("IMAGE", "dev-tools")
VERSION := env("VERSION", "latest")

# Setup environment
setup:
  mise install

# Build the Docker image
build:
  docker build -t {{IMAGE}}:{{VERSION}} .

# Tests inside the docker image
test:
  docker run --rm {{IMAGE}}:{{VERSION}} sh -c "\
    mise --version \
    && python --version \
    && node --version"

push:
  docker push {{IMAGE}}:{{VERSION}}
