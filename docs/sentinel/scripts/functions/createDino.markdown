---
title: createDino
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.createDino(characterId, dinoPath);
  - beacon.createDino(characterId, dinoPath, dinoInfo);
parameters:
  - name: characterId
    description: The Sentinel UUID of the survivor this dino should be given to.
  - name: dinoPath
    description: The blueprint path of the desired dino species.
  - name: dinoInfo
    description: An object describing one or more specific details about the dino to create.
    subobject:
      - key: level
        type: Number
        notes: The desired dino level. A random level will be chosen if ommitted.
      - key: age
        type: Number
        notes: To create a baby, specify a value less than 1. Baby is less than 0.1, juvenille is less than 0.5, and adolescent is less than 1. The default is 1.
      - key: isFemale
        type: Boolean
        notes: Specify true to create a female, false to create a male. Default is random. It is possible to use this to assign gender to a dino that does not normally have a gender.
      - key: isSterilized
        type: Boolean
        notes: Specify true to create a dino that has been spayed or neutered. Default is false.
      - key: name
        type: String
        notes: The name for the dino. Defaults to empty.
      - key: imprint
        type: Number
        notes: Created dinos are automatically imprinted to the survivor they are given to. This 0-1 number specifies the amount of imprinting quality. Defaults to 0.
      - key: stats
        type: Object
        notes: Allows specifying the number of stat points for each stat. Ark stat points are capped at 255. Attempting to send a value less than 0 or greater than 255 will trigger an exception. Valid keys are `0`, `health`, `1`, `stamina`, `2`, `torpor`, `3`, `oxygen`, `4`, `food`, `5`, `water`, `6`, `temperature`, `temp`, `7`, `weight`, `8`, `melee`, `9`, `speed`, `10`, `fortitude`, `fort`, `11`, `crafting`, `crafting_speed`, `craft`, `craftingSpeed`, `craft_speed`, `craftSpeed`. Yes, there is a lot of overlap in this list. This is to allow for human errors.
      - key: colors
        type: Array
        notes: An array of exactly 6 color names. Not numeric color values. Full color list is available at [usebeacon.app](https://usebeacon.app/Games/ArkSA/Colors){:target="_blank"}. Use the values from the Official Name column.
      - key: traits
        type: Array
        notes: An array of dino traits. It is valid to include the same trait multiple times. Full trait list is available at [usebeacon.app](https://usebeacon.app/Games/ArkSA/Traits){:target="_blank"}. Use the values from the Official Name column.
examples:
  - title: Give a player random dodo
    code: "const characterId = '305b1849-c7ac-5a4b-afe9-86628d91bf23';\nconst dinoPath = '/Game/PrimalEarth/Dinos/Dodo/Dodo_Character_BP.Dodo_Character_BP';\nbeacon.createDino(characterId, dinoPath);"
  - title: Give a player an albino kaprosuchus
    code: "const characterId = '305b1849-c7ac-5a4b-afe9-86628d91bf23';\nconst dinoPath = '/Game/PrimalEarth/Dinos/Kaprosuchus/Kaprosuchus_Character_BP.Kaprosuchus_Character_BP';\nconst dinoInfo = {\n  colors: [\n    'White',\n    'White',\n    'White',\n    'White',\n    'White',\n    'White',\n  ],\n};\nbeacon.createDino(characterId, dinoPath, dinoInfo);"
  - title: Give a player an imprinted spayed female rex
    code: "const characterId = '305b1849-c7ac-5a4b-afe9-86628d91bf23';\nconst dinoPath = '/Game/PrimalEarth/Dinos/Rex/Rex_Character_BP.Rex_Character_BP';\nconst dinoInfo = {\n  isFemale: true,\n  isSterilized: true,\n  imprint: 1.0,\n};\nbeacon.createDino(characterId, dinoPath, dinoInfo);"
---
# {{page.title}}

Creates a cryopod containing the specified dino. Dinos can be random like a natural spawn or can have very specific details.

{% include sentinelfunction.markdown %}
