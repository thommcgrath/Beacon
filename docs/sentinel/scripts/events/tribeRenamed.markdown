---
title: Tribe Renamed
parent: Events
grand_parent: Scripts
description: "A tribe's name has changed."
properties:
  - key: tribeId
    type: String
    notes: The Sentinel UUID of the tribe that was destroyed.
  - key: newTribeName
    type: String
    notes: The tribe's new name.
  - key: oldTribeName
    type: String
    notes: The tribe's old name.
---
# {{ page.title }}

{{ page.description }}

{% capture metadata %}
{
  "tribeId": "b72a9dd3-1a64-52a2-8f9c-f90409c871f0",
  "newTribeName": "Lost Wayfinders Society",
  "oldTribeName": "Reusable Breakfast Cereals"
}
{% endcapture %}

{% include sentinelevent.markdown sample=metadata %}
