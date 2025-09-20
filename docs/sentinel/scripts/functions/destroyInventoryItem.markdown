---
title: destroyInventoryItem
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.destroyInventoryItem(itemPath);
parameters:
  - name: itemPath
    type: String
    description: The blueprint path of the item that should be destroyed in all inventories.
examples:
  - title: Destroy all longnecks
    code: beacon.destroyInventoryItem('/Game/PrimalEarth/CoreBlueprints/Weapons/PrimalItem_WeaponOneShotRifle.PrimalItem_WeaponOneShotRifle');
---
# {{page.title}}

Searches all player, dino, and storage inventories (including offline players) for instances of the specified item and destroys them. Players will not see an "item removed" icon on their screen.

{% include sentinelfunction.markdown %}
