#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

mkdir ./logs
mkdir ./secrets/
touch ./logs/play.log

echo "[SETUP] Installing Poetry dependencies..."
poetry install --no-root

mkdir -p logs ~/.config/systemd/user

echo "[SETUP] Installing systemd user service and timer..."
cp service/spotify-autoplay.service ~/.config/systemd/user/
cp service/spotify-autoplay.timer ~/.config/systemd/user/

systemctl --user daemon-reload
systemctl --user enable --now spotify-autoplay.timer

echo "[SETUP COMPLETE]"
echo "Timer is active. Check with: systemctl --user list-timers spotify-autoplay*"
