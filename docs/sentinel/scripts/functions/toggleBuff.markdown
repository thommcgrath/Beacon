---
title: toggleBuff
parent: Functions
grand_parent: Scripts
signatures:
  - beacon.toggleBuff(charcterId, mode, path);
  - beacon.toggleBuff(dinoId, mode, path);
parameters:
  - name: characterId
    type: String
    description: Sentinel UUID of the survivor to buff.
  - name: dinoId
    type: String
    description: Sentinel UUID of the dino to buff
  - name: mode
    type: String
    description: One of `add`, `remove`, or `toggle`. `add` will only add the buff if the target does not already have the buff, `remove` will only remove the buff if the target has it, and `toggle` will add the buff if the target does not have the buff or remove the buff if the target does have the buff. Use the constants `BUFF_MODE_ADD`, `BUFF_MODE_REMOVE`, and `BUFF_MODE_TOGGLE` if desired.
  - name: path
    type: String
    description: The full path to the buff. Most of the game's buffs exist in `/Game/PrimalEarth/CoreBlueprints/Buffs`.
examples:
  - title: Set a survivor on fire
    code: "beacon.toggleBuff('305b1849-c7ac-5a4b-afe9-86628d91bf23', BUFF_MODE_ADD, '/Game/PrimalEarth/CoreBlueprints/Buffs/Buff_OnFire.Buff_OnFire_C');"
---
# {{page.title}}

Adds or removes buffs on a survivor or dino. Will trigger the [Survivor Buffs Changed](/sentinel/scripts/events/playerBuffsChanged.html) event. The game considers all effects buffs, even if they are negative effects.

{% include sentinelfunction.markdown %}
