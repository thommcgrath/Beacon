---
title: editDino
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.editDino(dinoId, dinoInfo);
parameters:
  - name: dinoId
    type: String
    description: The Sentinel UUID of the tamed dino to edit.
  - name: dinoInfo
    type: Object
    description: An object describing one or more specific details about the dino to change.
    subobject:
      - key: isSterilized
        type: Boolean
        notes: Set to true to sterilize the dino, false to unsterilize.
      - key: isFemale
        type: Boolean
        notes: Set to true to change the dino to female, false to change the dino to male. Can be used to add gender to a dino that does not normally have gender.
examples:
  - title: Unsterilize breeder Rex
    code: "const dinoId = '8ebd16a3-6055-5d6e-8898-7021b1a19e73';\nconst dinoInfo = {\n  isSterilized: false,\n};\nbeacon.editDino(dinoId, dinoInfo);"
seealso:
  - createDino
---
# {{page.title}}

Changes a tamed dino. The dino must not be dead, in a cryopod, or uploaded.

{% include sentinelfunction.markdown %}
