---
title: Tribe Created
parent: Events
grand_parent: Scripts
description: "A tribe was created."
properties:
  - key: tribeId
    type: String
    notes: The Sentinel UUID of the tribe that was just created.
  - key: characterId
    type: String
    notes: The Sentinel UUID of the survivor that created the tribe.
---
# {{ page.title }}

{{ page.description }}

{% capture metadata %}
{
  "tribeId": "b72a9dd3-1a64-52a2-8f9c-f90409c871f0",
  "characterId": "305b1849-c7ac-5a4b-afe9-86628d91bf23"
}
{% endcapture %}

{% include sentinelevent.markdown sample=metadata %}
