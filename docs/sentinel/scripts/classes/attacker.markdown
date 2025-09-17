---
title: Attacker
parent: Classes
grand_parent: Scripts
properties:
  - key: kind
    type: String
    notes: One of `wildDino`, `tamedDino`, `mountedDino`, `structure`, `player`, or `self`.
  - key: species
    type: String
    notes: For attackers involving a dino, the official species name of the dino.
  - key:  level
    type: Number
    notes: For attackers involving a dino, the level of the dino.
  - key: speciesPath
    type: String
    notes: For attackers involving a dino, the blueprint path of the dino species.
  - key: nameTag
    type: String
    notes: For attackers involving a dino, the species name tag. The species name tag is a grouping system the game uses, primarily for saddle compatibility, but can be useful for normalization.
  - key: dinoId
    type: String
    notes: For attackers involving a tamed dino, the Sentinel UUID of the dino.
  - key: dinoTribeId
    type: String
    notes: For attackers involving a tamed dino, the Sentinel UUID of the tribe.
  - key: riderPlayerId
    type: String
    notes: For mounted dinos, the Sentinel UUID of the player.
  - key: riderCharacterId
    type: String
    notes: For mounted dinos, the Sentinel UUID of the survivor.
  - key: riderTribeId
    type: String
    notes: For mounted dinos, the Sentinel UUID of the survivor's tribe. This _can_ be different from the dino's tribe.
  - key: tribeId
    type: String
    notes: For structures and player attackers, the Sentinel UUID of the tribe.
  - key: structureName
    type: String
    notes: For structure attackers, the name of the structure, such as Heavy Turret.
  - key: characterId
    type: String
    notes: For player attackers, the Sentinel UUID of the survivor.
  - key: playerId
    type: String
    notes: For player attackers, the Sentinel UUID of the player.
---
# {{page.title}}

The `Attacker` class provides information about what killed a dino or player, or what destroyed a structure.

{% capture sample_object %}
{
  "kind": "mountedDino",
  "species": "Aberrant Raptor",
  "level": 12,
  "speciesPath": "/Game/PrimalEarth/Dinos/Raptor/Raptor_Character_BP_Aberrant.Raptor_Character_BP_Aberrant",
  "nameTag": "Raptor",
  "dinoId": "8ebd16a3-6055-5d6e-8898-7021b1a19e73",
  "dinoTribeId": "b72a9dd3-1a64-52a2-8f9c-f90409c871f0",
  "riderPlayerId": "fc4c921c-ba83-4d1b-8470-a08fedf8246f",
  "riderCharacterId": "305b1849-c7ac-5a4b-afe9-86628d91bf23",
  "riderTribeId": "b72a9dd3-1a64-52a2-8f9c-f90409c871f0"
}
{% endcapture %}
{% include sentinelclass.markdown sample=sample_object %}
