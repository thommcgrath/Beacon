---
title: Rollback Detected
parent: Events
grand_parent: Scripts
description: "At the time the game server connected to Sentinel, its in-game clock was older than when it disconnected. This usually indicates a rollback, which may or may not be considered a problem. The event data includes both the previous and new clock times."
properties:
  - key: oldClock
    type: Number
    notes: The previous clock value.
  - key: newClock
    type: Number
    notes: The new clock value.
---
# {{ page.title }}

{{ page.description }}

{% capture metadata %}
{
  "oldClock": 394896.0,
  "newClock": 43200.0
}
{% endcapture %}

{% include sentinelevent.markdown sample=metadata %}

{% include sentinelclock.markdown %}
