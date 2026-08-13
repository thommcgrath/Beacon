## Request Path Rules

- Paths must always use url-style forward slashes (`/`) not backward slashes (`\`).
- Paths containing `../` will be rejected.
- `./` and `//` will be replaced with `/`.
- Leading and trailing slashes will be removed.
- Do not encode the path components. Example: use `Ark: Survival Ascended/ShooterGame/Saved/Config/WindowsServer/Game.ini` not `Ark%3A%20Survival%20Ascended/ShooterGame/Saved/Config/WindowsServer/Game.ini`.