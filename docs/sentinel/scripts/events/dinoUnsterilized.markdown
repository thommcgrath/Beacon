---
title: Dino Unsterilized
parent: Events
grand_parent: Scripts
description: "A dino is no longer neutered / spayed."
properties:
  - key: dinoId
    type: String
    notes: The Sentinel UUID of the the dino that was unsterilized.
  - key: dinoName
    type: String
    notes: The name of the dino that was unsterilized.
  - key: tribeId
    type: String
    notes: The Sentinel UUID of the tribe the unsterilized dino belongs to.
  - key: tribeName
    type: String
    notes: The name of the tribe the unsterilized dino belongs to.
---
# {{ page.title }}

{{ page.description }}

{% capture metadata %}
{
  "dinoId": "8ebd16a3-6055-5d6e-8898-7021b1a19e73",
  "dinoName": "Tin Weasel",
  "tribeId": "b72a9dd3-1a64-52a2-8f9c-f90409c871f0"
  "tribeName": "Reusable Breakfast Cereals"
}
{% endcapture %}

{% include sentinelevent.markdown sample=metadata %}
