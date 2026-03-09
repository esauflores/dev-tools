#!/bin/bash
set -euo pipefail

rm -f /tools/.ready

mise ls --missing --json | jq -r 'to_entries[] | "\(.key)@\(.value[0].version)"' | while read -r tool; do
  echo "Installing $tool..."
  mise use -g "$tool"
done

mise upgrade

mise reshim

uv tool install ansible --with-executables-from ansible-core

mise reshim

chmod -R 755 /tools

touch /tools/.ready

exec "$@"
