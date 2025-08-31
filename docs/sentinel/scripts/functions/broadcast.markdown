---
title: broadcast
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.broadcast(message);
parameters:
  - name: message
    description: The message to be displayed. Avoid special characters like emoji and accented characters. The characters which Ark's font can display vary depending on the player's language.
examples:
  - title: Send a warning about an upcoming dino wipe
    code: beacon.broadcast("Wild dino wipe coming in 5 minutes. Sorry in advance if you're taming something.");
---
# {{page.title}}

Sends a broadcast to all players on the server. This shows as a large blue box near the top of the screen along with the message of the day chimes.

{% include sentinelfunction.markdown %}
