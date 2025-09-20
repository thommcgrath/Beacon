---
title: Workflow
parent: Languages
grand_parent: Scripts
---
# {{page.title}}

Sentinel's "Workflow" language is an "if this, then that" style interface that guides you through setting up basic scripts.

## Conditions

Conditions allow you to only run the script in certain situations, such as if a player were killed by a specific kind of dino.

When adding a condition, the first thing to worry about is the "Field" column. Every event or feature will have a different selection of fields to pick from, so browse the menu carefully. In addition to event data fields, script parameters will also appear in the field menu.

Depending on the chosen field, the "Operator" column will show different options. Strings will have operators such as "equals", "contains", and "begins with", while numbers will have operators such as "equals", "is greater than" and "is less than or equal to".

The "Value" column is where you'll specify what the field will be compared against. See the [Value Fields](#value-fields) section below for information about using these fields.

Adding a second condition will reveal a "Match All" and "Match Any" button pair. "Match All" will require that all conditions are met, while "Match Any" will only require that any of the conditions are met.

### Value Fields

String values will show an asterisk icon on the right that when clicked, will allow you to choose a value to insert.

## Logic

The **Logic**{:.ui-keyword} section is where you'll specify exactly which actions the script should take when the conditions are met. After pressing the **Add Action**{:.ui-keyword} button, you will then choose from a menu of possible actions. You can add as many as you like.

| Action | Notes |
| - | - |
| Ban Player | Accepts a Sentinel Player ID or EOS ID, which will automatically fill in with the `{{playerId}}` placeholder, a reason, a length in days, and the Sentinel Server ID or Group ID to ban the player from. |
| Clear Bucket Value | Accepts a Sentinel Bucket ID and key to clear a value from. Optionally also accepts a Sentinel Player ID to remove the value from a player instead of the bucket's global value. |
| Create Dino | Creates a new dino in a cryopod to be given to the survivor identified by their Sentinel Survivor ID. |
| Destroy Inventory Item | Takes an item blueprint path and destroys all instances of it in all player, dino, and storage inventories.
| Give Custom Item | Accepts a Sentinel Survivor ID, item path, and quantity. Optionally also allows specific stat values such as item rating, armor amount, and durability. The Sentinel mod will generate an item that perfectly matches the given stats, within the limitations of the game of course. This does not respect any stat clamps set on the server. |
| Give Item | Similar to Give Custom Item, this action accepts a Sentinel Survivor ID, item path, quality, and quantity. This action behaves much like the the "GiveItem" cheat code, except that Sentinel will allow greater values than the stack size. |
| Kick Player | Removes the player specified by Sentinel Player ID. |
| Kill Survivor | Kills a survivor by their Sentinel Survivor ID. |
| Rename Survivor | Changes the name of the survivor specified by the Sentinel Survivor ID to the name provided. |
| Run Admin Commands | Sends an admin command to the server utilizing Sentinel's smart command routing. |
| Run Subroutine | Schedules a [Subroutine](/sentinel/scripts/features/subroutine.html) to be executed immediately or after a delay. |
| Send Chat Message | Sends a global chat message to the server using a custom sender name. |
| Send Discord Message | Sends a message to a [Discord webhook](https://support.discord.com/hc/en-us/articles/228383668-Intro-to-Webhooks). Discord webhooks are heavily rate limited, so use this sparingly for best reliability. |
| Set Bucket Value | Saves a value to a specific bucket under the specified key. Optionally accepts a Sentinel Player ID to save the value to. |
| Teleport Character | Teleports a survivor to a specific location or location relative to their current position and facing direction. See the [beacon.teleportCharacter](/sentinel/scripts/functions/teleportCharacter.html) JavaScript function reference for a detailed explanation of the required values. |
| Teleport Dino | Teleports a dino to a specific location or location relative to their current position and facing direction. See the [beacon.teleportDino](/sentinel/scripts/functions/teleportDino.html) JavaScript function reference for a detailed explanation of the required values. |
{:.classdefinition}

## Value Fields

Each field in both Conditions and Logic behave differently depending on the data type in use.

### String Fields

String fields show an asterisk to the right. This allows choosing any available field to be added as a placeholder. Multiple placeholders can exist in a string field. This is most useful for crafting natural language, such as `{{characterName}} was killed by a wild {{dinoSpecies}}`.

### Number Fields

Number fields act as a menu that allows you to select an existing number field. To enter your own value, click the pencil icon to the right of the field. You can use this icon to toggle manual editing on and off.

### Boolean Fields

Boolean fields are always a menu. You can choose between yes, no, and any other boolean values available to the script or event.
