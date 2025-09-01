---
title: teleportCharacter
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.teleportCharacter(characterId, coordinates);
  - beacon.teleportCharacter(specimenId, coordinates);
parameters:
  - name: characterId
    type: String
    description: The Sentinel UUID of the survivor to teleport.
  - name: specimenId
    type: Number
    description: The specimen / implant number of the survivor to teleport.
  - name: coordinates
    type: Object
    description: An object describing how the survivor should be teleported.
    subobject:
      - key: x
        type: Number
        notes: The absolute X coordinate of the destination. Positive values are west of longitude 50, negative values are east.
      - key: y
        type: Number
        notes: The absolute Y coordinate of the destination. Positive values are south of latitude 50, negative values are north.
      - key: z
        type: Number
        notes: The absolute Z coordinate of the destination. Positive values are above sea level, negative values are below. However, maps do not always place their oceans at 0, so the concept of sea level is completely arbitrary.
      - key: f
        type: Number
        notes: A relative distance to move the survivor forward along the direction they are facing. Positive values are forward, negative values are backwards.
      - key: r
        type: Number
        notes: A relative distance to move the survivor right, relative to the direction they are facing. Positive values are right, negative values are left.
      - key: u
        type: Number
        notes: A relative distance to move the survivor vertically. Positive values are up, negative values are down.
examples:
  - title: Teleport a survivor to 50, 50
    code: "beacon.teleportCharacter('305b1849-c7ac-5a4b-afe9-86628d91bf23', {x: 0, y: 0});"
  - title: Teleport a survivor up 3 wall heights
    code: "beacon.teleportCharacter('305b1849-c7ac-5a4b-afe9-86628d91bf23', {u: 900});"
  - title: Teleport a survivor into the sky
    code: "beacon.teleportCharacter('305b1849-c7ac-5a4b-afe9-86628d91bf23', {z: 10000});"
seelaso:
  - teleportDino
---
# {{page.title}}

Teleports a survivor, even if the player is offline.

Movement is always absolute or relative. Therefore, `x`, `y`, and `z` values cannot be combined with `f`, `r`, and `u` values. An exception will be triggered if you attempt to combine absolute and relative values.

{% include sentinelfunction.markdown %}

## Notes

The size of 1 foundation is 300 by 300.

Sentinel's locate feature returns coordinates that are intentionally 300 units away from the survivor's center in a random direction, to avoid collisions.

There is no locateCharacter or locateDino functions due to the asynchronous nature of Sentinel's communication with the game server.
