---
title: giveItem
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.giveItem(characterId, itemPath, [quantity], [quality], [asBlueprint], [minRandomQuality], [respectStatClamps]);
  - beacon.giveItem(characterId, itemInfo);
parameters:
  - name: characterId
    type: String
    description: The Sentinel UUID of the survivor this item should be given to.
  - name: itemPath
    type: String
    description: The blueprint path of the item to be given.
  - name: quantity
    type: Number
    description: How many of the item to give. Unlike cheat commands, is not limited to stack size. Sentinel will create the appropriate stacks.
  - name: quality
    type: Number
    description: The **maximum** quality that can be selected, between 0 and 100. Like `cheat giveitem`, the game still introduces quality randomness.
  - name: asBlueprint
    type: Boolean
    description: True will create a blueprint instead of a usable item.
  - name: minRandomQuality
    type: Number
    description: The **minimum** quality that can be selected, between 0 and 100.
  - name: respectStatClamps
    type: Boolean
    description: True if the created item should respect stat clamps, should the server have them configured. This will not allow creating items beyond their mathematical stat limits.
  - name: itemInfo
    type: Object
    description: An object describing the item to create. Use this object instead of positional arguments when you want more control over which values to set.
    supportsMessage: "This object supports all of the previous parameters, except characterId, as well as these additional parameters:"
    subobject:
      - key: itemRating
        type: Number
        notes: Include to override the item rating, which can be seen on the info card in-game. This will not affect quality, which means it is possible to create a very expensive primitive item, a very cheap ascendant item, or anything in between.
      - key: stats
        type: Array
        notes: An array of objects used for choosing specific stats. Each object must have `index` and `value` keys. See [stat indexes](#stat-indexes) below for a list of the stat indexs the game uses. The `value` should be a number between 0 and 255.
examples:
  - title: Give a player an assault rifle
    code: "const characterId = '305b1849-c7ac-5a4b-afe9-86628d91bf23';\nconst itemPath = '/Game/PrimalEarth/CoreBlueprints/Weapons/PrimalItem_WeaponRifle.PrimalItem_WeaponRifle';\nbeacon.giveItem(characterId, itemPath);"
  - title: Give a player a max damage longneck rifle
    code: "const characterId = '305b1849-c7ac-5a4b-afe9-86628d91bf23';\nconst itemInfo = {\n  itemPath: '/Game/PrimalEarth/CoreBlueprints/Weapons/PrimalItem_WeaponOneShotRifle.PrimalItem_WeaponOneShotRifle',\n  stats: [\n    {\n      index: 3,\n      value: 255,\n    },\n  ],\n};\nbeacon.giveItem(characterId, itemInfo);"
  - title: Give a player a cheap capped ptera saddle blueprint
    code: "const characterId = '305b1849-c7ac-5a4b-afe9-86628d91bf23';\nconst itemInfo = {\n  itemPath: '/Game/PrimalEarth/CoreBlueprints/Items/Armor/Saddles/PrimalItemArmor_PteroSaddle.PrimalItemArmor_PteroSaddle',\n  asBlueprint: true,\n  itemRating: 0,\n  quality: 0,\n  stats: [\n    {\n      index: 1,\n      value: 255,\n    },\n    {\n      index: 2,\n      value: 255,\n    }\n  ],\n};\nbeacon.giveItem(characterId, itemInfo);"
---
# {{page.title}}

Creates an item in a survivor's inventory. The player does not need to be online for this to work.

{% include sentinelfunction.markdown %}

## Stat Indexes

| Index | Stat |
| -- | -- |
| 0 | Generic Quality |
| 1 | Armor |
| 2 | Durability |
| 3 | Damage |
| 4 | Ammo |
| 5 | Hypothermal |
| 6 | Weight |
| 7 | Hyperthermal |
{:.classdefinition}
