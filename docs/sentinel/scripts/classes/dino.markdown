---
title: Dino
parent: Classes
grand_parent: Scripts
properties:
  - key: dinoAge
    type: Number
    notes: A value, greater than 0 but less than or equal to 1, that presents the creature's maturity. Less than 0.1 is baby, less than 0.5 is juvenille, less than 1 is adolescent, and 1 is adult.
  - key: dinoDisplayName
    type: String
    notes: A reliable name string to use in messages. When the creature has a name, that name will be used. When the creature does not have a name, returns the species instead.
  - key: dinoGender
    type: String
    notes: 'One of `None`, `Female`, or `Male`.'
  - key: dinoHasGender
    type: Boolean
    notes: True if the creature has a gender.
  - key: dinoId
    type: String
    notes: A Sentinel-generated v5 UUID to uniquely identify this creature.
  - key: dinoIsDead
    type: Boolean
    notes: True if the creature is currently dead. Dead creatures are purged from Sentinel after 30 days.
  - key: dinoIsFemale
    type: Boolean
    notes: True if the creature is female.
  - key: dinoIsFrozen
    type: Boolean
    notes: True if the creature is currently stored in a cryopod.
  - key: dinoIsUploaded
    type: Boolean
    notes: True if the creature is currently uploaded to an obelisk, transmitted, loot drop, or similar.
  - key: dinoLevel
    type: Number
    notes: The creatures's level.
  - key: dinoName
    type: String
    notes: The creature name. Not all creatures have names, so this value may be empty, such as after taming.
  - key: dinoNameTag
    type: String
    notes: 'The "name tag" of the species. This is a value used to group similar creatures together and allows the game to identify which saddles fit onto each creature.'
  - key: dinoNumber
    type: Number
    notes: A 64-bit unsigned integer that the game uses to uniquely identify the creature.
  - key: dinoRestoreEligible
    type: Boolean
    notes: True when the creature can be revived with Sentinel's revive feature. This usually means the creature is dead and backup cryopod data is available.
  - key: dinoSpecies
    type: String
    notes: The official species name of the creature.
  - key: dinoSpeciesPath
    type: String
    notes: The blueprint path of the creature species.
  - key: dinoStatus
    type: String
    notes: 'One of `Deployed`, `Dead`, `Frozen`, or `Uploaded`.'
  - key: tribeId
    type: String
    notes: The Sentinel-generated v5 UUID of the tribe the creature belongs to.
---
# {{page.title}}

The `Dino` class represents a tamed creature. Sentinel does not track wild creatures.

{% capture sample_object %}
{
	"dinoAge": 1.0,
	"dinoDisplayName": "Biljak",
	"dinoGender": "Female",
	"dinoHasGender": true,
	"dinoId": "8ebd16a3-6055-5d6e-8898-7021b1a19e73",
	"dinoIsDead": false,
	"dinoIsFemale": true,
	"dinoIsFrozen": false,
	"dinoIsUploaded": false,
	"dinoLevel": 32,
	"dinoName": "Biljak",
	"dinoNameTag": "Dodo"
	"dinoNumber": 183600354641289556,
	"dinoRestoreEligible": false,
	"dinoSpecies": "Dodo",
	"dinoSpeciesPath": "/Game/PrimalEarth/Dinos/Dodo/Dodo_Character_BP.Dodo_Character_BP",
	"dinoStatus": "Deployed",
	"tribeId": "b72a9dd3-1a64-52a2-8f9c-f90409c871f0"
}
{% endcapture %}
{% include sentinelclass.markdown sample=sample_object %}
