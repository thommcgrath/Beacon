---
title: Custom Message Logged
parent: Events
grand_parent: Scripts
description: "A custom Sentinel log message was created by a Sentinel script."
properties:
  - key: message
    type: String
    notes: The message that was logged.
---
# {{ page.title }}

{{ page.description }}

{% capture metadata %}
{
  "message": "A game of hide-and-seek has started."
}
{% endcapture %}

{% include sentinelevent.markdown sample=metadata %}
