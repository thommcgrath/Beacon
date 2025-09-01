---
title: teleportDino
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.teleportDino(dinoId, coordinates);
parameters:
  - name: dinoId
    type: String
    description: The Sentinel UUID of the dino to teleport.
  - name: coordinates
    type: Object
    description: An object describing how the dino should be teleported.
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
        notes: A relative distance to move the dino forward along the direction they are facing. Positive values are forward, negative values are backwards.
      - key: r
        type: Number
        notes: A relative distance to move the dino right, relative to the direction they are facing. Positive values are right, negative values are left.
      - key: u
        type: Number
        notes: A relative distance to move the dino vertically. Positive values are up, negative values are down.
examples:
  - title: Teleport a dino to 50, 50
    code: "beacon.teleportDino('8ebd16a3-6055-5d6e-8898-7021b1a19e73', {x: 0, y: 0});"
  - title: Teleport a dino up 3 wall heights
    code: "beacon.teleportDino('8ebd16a3-6055-5d6e-8898-7021b1a19e73', {u: 900});"
  - title: Teleport a dino into the sky
    code: "beacon.teleportDino('8ebd16a3-6055-5d6e-8898-7021b1a19e73', {z: 10000});"
seelaso:
  - teleportCharacter
---
# {{page.title}}

Teleports a dino. Cannot deleport a dino that is dead, in a cryopod, or uploaded.

Movement is always absolute or relative. Therefore, `x`, `y`, and `z` values cannot be combined with `f`, `r`, and `u` values. An exception will be triggered if you attempt to combine absolute and relative values.

{% include sentinelfunction.markdown %}

## Notes

The size of 1 foundation is 300 by 300.

Sentinel's locate feature returns coordinates that are intentionally 300 units away from the dino's center in a random direction, to avoid collisions.

There is no locateCharacter or locateDino functions due to the asynchronous nature of Sentinel's communication with the game server.
