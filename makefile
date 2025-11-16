
---

### File: `pyproject.toml`
```toml
[tool.poetry]
name = "spotify-autoplay-racer"
version = "0.1.0"
description = "Autoplay 'racer' Spotify playlist on Linux startup with correct device and PipeWire configuration"
authors = ["Jettsy <jettsy@localhost>"]
readme = "README.md"
packages = [{ include = "src" }]

[tool.poetry.dependencies]
python = "^3.11"
spotipy = "^2.23.0"
requests = "^2.32.3"

[tool.poetry.scripts]
spotify-autoplay = "src.main:main"

[build-system]
requires = ["poetry-core"]
build-backend = "poetry.core.masonry.api"
