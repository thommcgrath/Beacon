---
title: Admin Command Used
parent: Events
grand_parent: Scripts
description: "An admin command has been executed, either in-game by an admin, using the Sentinel web interface, or from a Sentinel script."
properties:
  - key: command
    type: String
    notes: The exact command that was used, which may include a `cheat` prefix. Sentinel makes no attempt to parse this command.
  - key: playerId
    type: String
    notes: The Sentinel UUID of the player that executed the command.
---
# {{ page.title }}

{{ page.description }}

{% capture metadata %}
{
  "command": "gcm",
  "playerId": "fc4c921c-ba83-4d1b-8470-a08fedf8246f"
}
{% endcapture %}

{% include sentinelevent.markdown sample=metadata %}
