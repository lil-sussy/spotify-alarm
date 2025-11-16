# Spotify Autoplay Racer

# !! it's vibe coded watch out (works though) !!

# Purpose:
Run at login and automatically play your "racer" playlist on Spotify using device
`BriarAssSweat`, set Spotify volume to 50%, system volume to 100%, and set
PipeWire output to `USB audio speakers`.

# Requirements:
- Linux with PipeWire and `pactl` available
- poetry
- Python 3.11+.
- `systemd --user` for autostart (Hyprland typically has this).
- A Spotify Premium account for playback control.

# Environment variables (export or put in ~/.profile / ~/.bashenv):
- SPOTIPY_CLIENT_ID
- SPOTIPY_CLIENT_SECRET
- SPOTIPY_REDIRECT_URI (e.g. http://localhost:8888/callback)
- SPOTIFY_USERNAME
- SPOTIFY_RACER_PLAYLIST_URI (the URI of your `racer` playlist)
- TARGET_DEVICE_NAME=BriarAssSweat
- TARGET_SINK_FRIENDLY_NAME='USB audio speakers'

# Install and setup:
1. Make executable and run setup:
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```

2. Follow the OAuth link printed to obtain tokens (setup script assists).
3. Test:

   ```bash
   ./run.sh
   ```
4. Enable service manually if not enabled:

   ```bash
   systemctl --user enable --now spotify-autoplay.service
   ```

# Notes:

* If the sink name does not match exactly, adjust `TARGET_SINK_FRIENDLY_NAME`.
* Log file: `logs/play.log` contains runtime logs.

# Troubleshooting quick commands:

* List sinks: `pactl list short sinks`
* Check service status: `systemctl --user status spotify-autoplay.service`


# Spotify Autoplay Racer (Poetry Edition)

Automatically plays your **racer** Spotify playlist at system startup, switches
audio to **USB audio speakers**, sets system volume to 100%,
and Spotify volume to 50%, using the device `BriarAssSweat`.

---

## Requirements
- Linux (PipeWire + pactl)
- Spotify Premium
- Poetry (`pipx install poetry`)
- `systemd --user` support (present on Hyprland setups)

---

## Environment Variables
Add these to your `.bash_profile` or `.config/environment.d/envvars.conf`:

## Scheduled Daily Run

The service runs automatically every day at **07:45 AM** local time.

To verify:
```bash
systemctl --user list-timers spotify-autoplay*



