---
title: Dino Tribe Changed
parent: Events
grand_parent: Scripts
description: "A dino's tribe has changed, usually due to its owner joining a tribe."
properties:
  - key: dinoId
    type: String
    notes: The Sentinel UUID of the dino that changed tribes.
  - key: oldTribeId
    type: String
    notes: The Sentinel UUID of the tribe the dino originally belonged to.
  - key: newTribeId
    type: String
    notes: The Sentinel UUID of the tribe the dino now belongs to.
---
# {{ page.title }}

{{ page.description }}

{% capture metadata %}
{
  "oldTribeId": "e188c013-12b7-5877-8af5-0c284fe8250e",
  "newTribeId": "b72a9dd3-1a64-52a2-8f9c-f90409c871f0",
  "dinoId": "8ebd16a3-6055-5d6e-8898-7021b1a19e73"
}
{% endcapture %}

{% include sentinelevent.markdown sample=metadata %}
