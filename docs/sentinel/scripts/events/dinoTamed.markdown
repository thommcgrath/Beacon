---
title: Dino Tamed
parent: Events
grand_parent: Scripts
description: "A wild dino was tamed."
properties:
  - key: dinoId
    type: String
    notes: The Sentinel UUID of the dino that was tamed.
  - key: tribeId
    type: String
    notes: The Sentinel UUID of the tribe that tamed the dino.
  - key: dinoName
    type: String
    notes: The name of the dino that was tamed. Usually empty, but included just in case.
---
# {{ page.title }}

{{ page.description }}

{% capture metadata %}
{
  "dinoId": "8ebd16a3-6055-5d6e-8898-7021b1a19e73",
  "tribeId": "b72a9dd3-1a64-52a2-8f9c-f90409c871f0",
  "dinoName": "Tin Weasel"
}
{% endcapture %}

{% include sentinelevent.markdown sample=metadata %}
