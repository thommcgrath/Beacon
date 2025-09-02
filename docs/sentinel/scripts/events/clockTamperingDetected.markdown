---
title: Clock Tampering Detected
parent: Events
grand_parent: Scripts
description: "Sentinel has noticed that the in-game clock is older than it was previously, indicating the clock has been changed."
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
  "newClock": 28800.0
}
{% endcapture %}

{% include sentinelevent.markdown sample=metadata %}

{% include sentinelclock.markdown %}
