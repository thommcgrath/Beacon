---
title: killSurvivor
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.killSurvivor(characterId);
parameters:
  - name: characterId
    type: String
    description: The Sentinel UUID of the survivor that should be killed.
examples:
  - title: Kick a survivor
    code: beacon.killSurvivor('305b1849-c7ac-5a4b-afe9-86628d91bf23');
---
# {{page.title}}

Kills a survivor, even if the player is offline.

{% include sentinelfunction.markdown %}
