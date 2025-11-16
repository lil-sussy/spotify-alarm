#!/usr/bin/env bash
# Detect a PipeWire sink by friendly name.

set -euo pipefail
NAME="${1:-USB audio speakers}"

sink=$(pactl list short sinks | grep -i "$NAME" | awk '{print $2}' | head -n1 || true)
if [ -z "$sink" ]; then
  echo ""
  exit 1
fi
echo "$sink"
