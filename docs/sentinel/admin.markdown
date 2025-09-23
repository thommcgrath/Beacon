---
title: Admin Commands
parent: Sentinel
---
# {{page.title}}

Sentinel supports a handful of admin commands that can help with troubleshooting.

- `cheat scriptcommand sentinel reconnect`: Causes the mod to disconnect (if connected) and start a new connection to the Sentinel network.
- `cheat scriptcommand sentinel restartqueue`: The Sentinel event queue uses numbered events to ensure they are processed in the correct sequence. This command restarts the queue from 1 and renumbers existing queued events accordingly.
- `cheat scriptcommand sentinel breakqueue`: Intentionally messes up the queue to test the network's behavior of an interrupted queue.
- `cheat scriptcommand sentinel emptyqueue`: Events are normally removed once the Sentinel network has confirmed their receipt, but the mod will continue to queue events to the map save file if disconnected. This command will delete all queued events.
- `cheat scriptcommand sentinel disable`: Turns off the Sentinel mod. If connected to the Sentinel network, the connection will be closed. The event queue will be emptied, and no new events will be added to the queue.
- `cheat scriptcommand sentinel enable`: If Sentinel has been disabled, returns the mod to normal behavior.
