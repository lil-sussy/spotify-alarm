#!/usr/bin/env bash
# Run the app inside the virtualenv for testing, showing logs to stdout.

set -euo pipefail

# Activate virtualenv
source .venv/bin/activate

# Ensure log dir exists
mkdir -p logs

# Run main
poetry run python3 src/main.py 2>&1 | tee -a logs/play.log