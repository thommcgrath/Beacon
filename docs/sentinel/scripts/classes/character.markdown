---
title: Character
parent: Classes
grand_parent: Scripts
properties:
  - key: characterId
    type: String
    notes: The Sentinel-generated v5 UUID of the survivor.
  - key: playerId
    type: String
    notes: The Sentinel-generated v4 UUID of the player controlling the survivor.
  - key: name
    type: String
    notes: The survivor's name
  - key: tribeId
    type: String
    notes: The Sentinel-generated v5 UUID of the tribe the survivor belongs to. All survivors belong to a tribe, even if alone.
  - key: specimenId
    type: Number
    notes: Sometimes also called implant number, this is usually 9 digits and found when a player hovers over their implant in their inventory.
---
# {{page.title}}

The `Character` class represents a survivor. Admittedly, this class name is a bit of an oversight, but changing it would cause to many problems.

{% capture sample_object %}
{
  "characterId": "305b1849-c7ac-5a4b-afe9-86628d91bf23",
  "playerId": "fc4c921c-ba83-4d1b-8470-a08fedf8246f",
  "name": "Velvety Dimetrodon",
  "tribeId": "b72a9dd3-1a64-52a2-8f9c-f90409c871f0",
  "specimenId": 802991937
}
{% endcapture %}
{% include sentinelclass.markdown sample=sample_object %}
