---
title: Dino Created
parent: Events
grand_parent: Scripts
description: "A dino was created by Sentinel's web interface by a Sentinel script."
properties:
  - key: playerId
    type: String
    notes: The Sentinel UUID of the player to receive the dino.
  - key: characterId
    type: String
    notes: The Sentinel UUID of the survivor to receive the dino.
  - key: tribeId
    type: String
    notes: The Sentinel UUID of the tribe the survivor belongs to.
  - key: dinoPath
    type: String
    notes: The blueprint path of the dino that was created.
  - key: name
    type: String
    notes: The dino name, if a name was included in the function parameters.
  - key: level
    type: Number
    notes: The dino level, if a level was included in the function parameters.
  - key: age
    type: Number
    notes: The dino age, if an age was included in the function parameters.
  - key: isFemale
    type: Boolean
    notes: True or false if gender was included in the function parameters.
  - key: isSterilized
    type: Boolean
    notes: True or false if sterilization was included in the function parameters.
  - key: imprint
    type: Number
    notes: The imprint amount, if the imprint amount was included in the function parameters.
  - key: colors
    type: Array
    notes: The requested colors, if colors were included in the function parameters.
  - key: stats
    type: Array
    notes: The requested stats, if stats were included in the function parameters.
  - key: traits
    type: Array
    notes: The requested traits, if traits were included in the function parameters.
---
# {{ page.title }}

{{ page.description }}

{% capture metadata %}
{
  "playerId": "fc4c921c-ba83-4d1b-8470-a08fedf8246f",
  "characterId": "305b1849-c7ac-5a4b-afe9-86628d91bf23",
  "tribeId": "b72a9dd3-1a64-52a2-8f9c-f90409c871f0", 
  "dinoPath": "/Game/PrimalEarth/Dinos/Dodo/Dodo_Character_BP.Dodo_Character_BP",
  "name": "Tin Weasel",
  "level": 12,
  "age": 1.0,
  "isFemale": true,
  "isSterilized": false,
  "imprint": 0.8,
  "colors": [
    "Dino Dark Orange",
    "Dino Light Blue",
    "Dino Medium Blue",
    "Dino Dark Orange",
    "Dino Light Orange",
    "Dino Dark Purple"
  ],
  "stats": [
    {
      "index": 8,
      "value": 3
    }
  ],
  "traits": [
    "Vampiric[2]",
    "InheritWeightRobust[0]"
  ]
}
{% endcapture %}

{% include sentinelevent.markdown sample=metadata %}
