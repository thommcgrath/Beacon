---
title: Player Left
parent: Events
grand_parent: Scripts
description: "A player has left the server."
properties:
  - key: playerId
    type: String
    notes: The Sentinel UUID of the player who left the server.
---
# {{ page.title }}

{{ page.description }}

{% capture metadata %}
{
  "playerId": "fc4c921c-ba83-4d1b-8470-a08fedf8246f"
}
{% endcapture %}

{% include sentinelevent.markdown sample=metadata %}
