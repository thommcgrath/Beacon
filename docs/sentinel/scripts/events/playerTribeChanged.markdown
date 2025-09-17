---
title: Survivor Tribe Changed
parent: Events
grand_parent: Scripts
description: "A survivor has changed tribes. This can execute when they leave a tribe, as well as when they join another tribe."
properties:
  - key: characterId
    type: String
    notes: The Sentinel UUID of the survivor that was renamed.
  - key: oldTribeId
    type: Number
    notes: The Sentinel UUID of the tribe the survivor left.
  - key: newTribeId
    type: String
    notes: The Sentinel UUID of the tribe the survivor joined.
---
# {{ page.title }}

{{ page.description }}

{% capture metadata %}
{
  "characterId": "305b1849-c7ac-5a4b-afe9-86628d91bf23",
  "oldTribeId": "e188c013-12b7-5877-8af5-0c284fe8250e",
  "newTribeId": "b72a9dd3-1a64-52a2-8f9c-f90409c871f0"
}
{% endcapture %}

{% include sentinelevent.markdown sample=metadata %}
