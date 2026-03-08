#!/bin/bash
set -euo pipefail

rm -f /tools/.ready

mise ls --missing --json | jq -r 'keys[]' | while read -r tool; do
  mise install "$tool"
done

mise reshim

uv tool install ansible --with-executables-from ansible-core

chmod -R 755 /tools

touch /tools/.ready

exec "$@"
