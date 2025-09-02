---
title: Message Broadcasted
parent: Events
grand_parent: Scripts
description: "A message was broadcasted from the Sentinel web interface or a Sentinel script. Will not execute for broadcast messages sent via in-game admin commands."
properties:
  - key: originalMessage
    type: String
    notes: The message that was broadcasted.
---
# {{ page.title }}

{{ page.description }}

{% capture metadata %}
{
  "originalMessage": "The dodos become aggressive in 5 minutes!"
}
{% endcapture %}

{% include sentinelevent.markdown sample=metadata %}
