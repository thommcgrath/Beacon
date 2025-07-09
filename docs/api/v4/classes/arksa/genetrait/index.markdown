---
title: "GeneTrait"
parent: "Ark: Survival Ascended"
grand_parent: "Classes"
has_children: false
apiVersion: 4
classPath: "arksa/geneTraits"
identifierProperty: "geneTraitId"
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
  - label
filters:
  - key: lastUpdate
    mode: greater than
  - key: contentPackId
    mode: exact, list
    notes: "Supports filtering on multiple content packs by separating UUIDs with commas."
  - key: contentPackMarketplaceId
    mode: exact, list
    notes: "Supports filtering on multiple content packs by separating IDs with commas."
  - key: tag
    mode: exact
    notes: "Results must have the specified tag."
  - key: !tag
    mode: exact
    notes: "Removes results that have the specified tag."
  - key: tags
    mode: exact, list
    notes: "Comma separated list of tags results must include."
  - key: !tags
    mode: exact, list
    notes: "Comma separated list of tags to exclude from results."
  - key: label
    mode: contains
  - key: alternateLabel
    mode: contains
properties:
  - key: geneTraitId
    type: UUID
  - key: label
    type: String
  - key: alternateLabel
    type: String
  - key: contentPackId
    type: UUID
  - key: contentPackName
    type: String
  - key: contentPackMarketplace
    type: String
    notes: "One of `Steam`, `Steam Workshop`, or `CurseForge`."
  - key: contentPackMarketplaceId
    type: String
    notes: "The ID of the source of the item, such as Steam App ID, Steam Workshop File ID, or CurseForge Project ID."
  - key: tags
    type: Array of String
    notes: "Valid tag characters are a-z, 0-9, and underscore."
  - key: minVersion
    type: Integer
    notes: "Minimum Beacon client version this object should appear in."
  - key: lastUpdate
    type: Float
  - key: path
    type: String
  - key: maxAllowed
    type: Integer
    notes: "The maximum number of times this trait may stack on a creature."
  - key: description
    type: String
    notes: "The in-game description of the trait."
  - key: name
    type: String
    notes: "The in-game name of the trait."
---
# {{page.title}}

{% capture sample_object %}
{
  "geneTraitId": "237443c3-c7e4-408e-9143-02ced6b7c0c8",
  "label": "Heavy-Hitting",
  "alternateLabel": null,
  "contentPackId": "b32a3d73-9406-56f2-bd8f-936ee0275249",
  "contentPackName": "Ark Official",
  "contentPackMarketplace": "Steam",
  "contentPackMarketplaceId": "2399830",
  "tags": [],
  "minVersion": 20000000,
  "lastUpdate": 1752015852,
  "path": "/Game/PrimalEarth/CoreBlueprints/GeneTraits/TraitBPs/HeavyHitting/Trait_HeavyHitting.Trait_HeavyHitting",
  "maxAllowed": 3,
  "description": "This Creature hits harder, but less quickly",
  "name": "HeavyHitting"
}
{% endcapture %}
{% include classdefinition.markdown sample=sample_object %}