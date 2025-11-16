"""
pipewire.py
Helpers to detect and configure PipeWire (via pactl).
"""

# Standard libs
import subprocess
import shlex
import os
import logging

def run_cmd(cmd):
    """
    Run shell command and return stdout text. Raise on failure.
    """
    logging.debug("Running command: %s", cmd)
    proc = subprocess.run(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    if proc.returncode != 0:
        raise RuntimeError(f"Command failed: {cmd}\n{proc.stderr.strip()}")
    return proc.stdout.strip()

def detect_sink_by_friendly_name(friendly_name: str):
    """
    Return sink name (e.g. pipewire-pulse sink id) matching friendly_name.
    """
    # Call pactl to list sinks in a compact way
    out = run_cmd("pactl list short sinks")
    # Each line: index \t name \t driver \t state ...
    for line in out.splitlines():
        parts = line.split()
        if len(parts) >= 2:
            name = parts[1]
            # Query more descriptive info to compare description if needed
            # Also check if friendly_name appears in name or description
            if friendly_name.lower() in name.lower():
                return name
            # Get description property
            try:
                desc = run_cmd(f"pactl list sinks | grep -A 20 'Name: {name}' | grep 'Description:' || true")
                if friendly_name.lower() in desc.lower():
                    return name
            except Exception:
                pass
    return None

def set_default_sink(sink_name: str):
    """
    Set the default sink to sink_name using pactl.
    """
    run_cmd(f"pactl set-default-sink {shlex.quote(sink_name)}")

def set_sink_volume_percent(sink_name: str, percent: int):
    """
    Set the sink volume (percent) for sink_name. Percent as integer (0-100).
    """
    # Set sink volume
    run_cmd(f"pactl set-sink-volume {shlex.quote(sink_name)} {percent}%")