---
title: Dino Died
parent: Events
grand_parent: Scripts
description: "A dino was killed. Includes information about what killed it."
properties:
  - key: dinoId
    type: String
    notes: The Sentinel UUID of the tamed dino that died.
  - key: tribeId
    type: String
    notes: The Sentinel UUID of the tribe the dino belonged to.
  - key: attacker
    type: Object
    notes: An object conforming to the [Attacker](../classes/attacker.html) class.
---
# {{ page.title }}

{{ page.description }}

{% capture metadata %}
{
  "dinoId": "8f6d4f98-ab40-5e4c-8b62-cbc4b468efa1",
  "tribeId": "b72a9dd3-1a64-52a2-8f9c-f90409c871f0", 
  "attacker": {
    "kind": "wildDino",
    "species": "Aberrant Raptor",
    "level": 12,
    "speciesPath": "/Game/PrimalEarth/Dinos/Raptor/Raptor_Character_BP_Aberrant.Raptor_Character_BP_Aberrant",
    "nameTag": "Raptor"
  }
}
{% endcapture %}

{% include sentinelevent.markdown sample=metadata %}
