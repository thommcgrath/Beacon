---
title: "Dino"
parent: "Sentinel"
grand_parent: "Classes"
has_children: false
apiVersion: 4
classPath: "sentinel/dinos"
identifierProperty: "dinoId"
supportedClassMethods:
  - POST
  - GET
  - PATCH
  - DELETE
supportedInstanceMethods:
  - PUT
  - GET
  - PATCH
  - DELETE
sortableProperties:
  - dinoDisplayName
  - serviceDisplayName
  - tribeName
  - dinoNumber
filters:
  - key: dinoNumber
    mode: exact
  - key: serviceId
    mode: exact
  - key: tribeId
    mode: exact
  - key: serviceDisplayName
    mode: websearch
  - key: tribeName
    mode: websearch
  - key: dinoStatus
    mode: exact list
    notes: "One of more of the following values, separated by commas: `Deployed`, `Dead`, `Frozen`, or `Uploaded`."
  - key: dinoSpecies
    mode: websearch
  - key: dinoNameTag
    mode: exact
  - key: dinoDisplayName
    mode: websearch
properties:
  - key: dinoId
    type: UUID
  - key: dinoNumber
    type: String
    notes: "The dino id as it would appear in-game. This value is made up of 2 unsigned 32-bit integers concatenated together."
  - key: dinoNumber64
    type: String
    notes: "This is the true dino id as an unsigned 64-bit number. It is wrapped in a string to better support languages that have poor support for unsigned 64-bit integers."
  - key: dinoName
    type: String
    notes: "The name of the dino. May be empty."
  - key: dinoNameTag
    type: String
    notes: "The 'name tag' value of the dino species. The name tag is a value used to determine which saddles can attach to each dino. For example, Raptor and Aberrant Raptor both use 'Raptor' as their name tag, allowing both raptor types to use the same saddle."
  - key: dinoDisplayName
    type: String
    notes: "Matches `dinoName` if the dino has a name. Otherwise, returns `dinoSpecies` instead."
  - key: dinoSpecies
    type: String
    notes: "The official name of the dino species."
  - key: dinoSpeciesPath
    type: String
    notes: "The full blueprint path of the dino species."
  - key: dinoLevel
    type: Integer
  - key: dinoAge
    type: Float
    notes: "A value between 0 and 1, inclusive. 1 indicates an adult. >= 0.5 is adolescent, >= 0.1 is juvenile, and anything lower is baby."
  - key: dinoIsDead
    type: Boolean
  - key: dinoIsFrozen
    type: Boolean
  - key: dinoIsUploaded
    type: Boolean
  - key: dinoRestoreEligible
    type: Boolean
    notes: "When true, the dino is dead and backup data is available."
  - key: dinoStatus
    type: String
    notes: "One of `Deployed`, `Dead`, `Frozen`, or `Uploaded`."
  - key: dinoGender
    type: String
    notes: "One of `None`, `Female`, or `Male`."
  - key: dinoHasGender
    type: Boolean
    notes: "True when `dinoGender` does not equal `None`."
  - key: dinoIsFemale
    type: Boolean
    notes: "True when `dinoGender` equals `Female`."
  - key: permissions
    type: Integer
  - key: serviceId
    type: UUID
  - key: serviceDisplayName
    type: String
  - key: tribeId
    type: UUID
  - key: tribeName
    type: String
---
# {{page.title}}

{% capture sample_object %}
{
  "dinoId": "cc00bcbf-ed79-5d02-87c5-f3b384f2d2ca",
  "dinoNumber": "229217179286823665",
  "dinoNumber64": "984480287773201649",
  "dinoName": "Bill",
  "dinoNameTag": "Dodo",
  "dinoDisplayName": "Bill",
  "dinoSpecies": "Dodo",
  "dinoSpeciesPath": "/Game/PrimalEarth/Dinos/Dodo/Dodo_Character_BP.Dodo_Character_BP",
  "dinoLevel": 19,
  "dinoAge": 1,
  "dinoIsDead": false,
  "dinoIsFrozen": false,
  "dinoIsUploaded": false,
  "dinoRestoreEligible": false,
  "dinoStatus": "Deployed",
  "dinoGender": "Female",
  "dinoHasGender": true,
  "dinoIsFemale": true,
  "permissions": 9007199254740991,
  "serviceId": "a516c6dc-b075-49c9-8f18-96a8d91e5dd0",
  "serviceDisplayName": "Play-In-Editor",
  "serviceColor": "Green",
  "tribeId": "10281288-5c5b-56c2-b88a-d569cabe5c93",
  "tribeName": "Tribe of Velvety Dimetrodon"
}
{% endcapture %}
{% include classdefinition.markdown sample=sample_object %}