---
title: Tribe Destroyed
parent: Events
grand_parent: Scripts
description: "The last member has left a tribe."
properties:
  - key: tribeId
    type: String
    notes: The Sentinel UUID of the tribe that was destroyed.
---
# {{ page.title }}

{{ page.description }}

{% capture metadata %}
{
  "tribeId": "b72a9dd3-1a64-52a2-8f9c-f90409c871f0"
}
{% endcapture %}

{% include sentinelevent.markdown sample=metadata %}
