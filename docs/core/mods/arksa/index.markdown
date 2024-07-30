---
title: "Ark: Survival Ascended"
parent: Game Mods in Beacon
grand_parent: Core Features
---
# Managing Mod Content for Ark: Survival Ascended

## Editing Blueprints

In Unreal Engine, almost everything is a blueprint. So when you edit mod content, you are telling Beacon about blueprints that have been added to Ark via a mod. This has nothing to do with Ark's in-game concept of a blueprint being a recipe for an item you can craft.

Start with the **New Blueprint**{:.ui-keyword} button to create a blueprint, or double-click a blueprint to edit it.

### Common Settings

All blueprints start with the same **Common**{:.ui-keyword} tab. This is where you tell Beacon the basic information about the blueprint, such as path, name, and availability.

{% include image.html file="common.png" file2x="common@2x.png" caption="Common settings for all Ark: Survival Ascended blueprints." %}

- **Blueprint Path**{:.ui-keyword}: Beacon needs the full path to the item, because mod authors sometimes use the same class names as each other or as official content. Official paths always start with `/Game/`, but mod path will start with their short name, such as `/DraconicChronicles/` or `/JVHLandscaping/`.
- **Name**{:.ui-keyword}: The name you want the blueprint to appear as in Beacon. This does not necessarily have to be the same as the blueprint's in-game name. For example, natural thatch and thatch made in an industrial grinder have the same in-game name, but should be named differently in Beacon for clarity, so you know which you are working with in your projects.
- **Tags**{:.ui-keyword}: A comma-separated list of tags for the blueprint. See [Object Tagging](/core/tagging/) for more details on tagging. Resist the urge to create separate tags for each mod, as Beacon already has a way of organizing mod content, and too many tags will cause the tag picker to take up a lot of space.
- **Map Availability**{:.ui-keyword}: Tells Beacon where this blueprint is normally used. For example, Desert Cloth Armor is not available on The Island. Beacon uses this information in various wizards, such as automatically unlocking items that are not available on any of the project's maps. Most mod content will use the **All Maps**{:.ui-keyword} option, which will automatically list the blueprint as available on all current and future maps.

### Engram Advanced Settings

{% include image.html file="engram-advanced.png" file2x="engram-advanced@2x.png" caption="Advanced engram settings control things like unlock and crafting requirements." %}

- **Unlock String**{:.ui-keyword}: Typically starts with `EngramEntry`, this is the class name used to unlock the item in the game's Engrams page.
- **Unlockable At Level**{:.ui-keyword}: The player's required level to unlock the item. If this is a tek item, write `Tek`.
- **Required Engram Points**{:.ui-keyword}: The number of unlock points needed to unlock the item. If this is a tek item, write `Tek`.
- **Stack Size**{:.ui-keyword}: The maximum number of this item that can exist in a stack. Beacon uses this in the [Stack Sizes](/configs/arksa/stack_sizes/) editor to calculate the default stack size when adding a new override.
- **Crafting Recipe**{:.ui-keyword}: The recipe for the item. Beacon uses this in various tools, such as the Adjust All Crafting Costs tool. The default recipe can be loaded into your projects when this list is filled in.

### Engram Stats

{% include image.html file="engram-stats.png" file2x="engram-stats@2x.png" caption="Engram stats are complicated and must come from the dev kit to be correct." %}

Completing the stats tab allows the item to show in Beacon's [Item Stat Limits](/configs/arksa/stat_limits/) editor.

### Creature Advanced Settings

{% include image.html file="creature-advanced.png" file2x="creature-advanced@2x.png" caption="Advanced creature settings control things breeding times and stats." %}

Times in this tab use a `Nd Nh Nm Ns` format, so 1 minute 30 seconds would be written as `1m 30s`. Values that are not needed can be skipped. So 2 days could be written as `2d` instead of `2d 0h 0m 0s`.

- **Incubation Time**{:.ui-keyword}: The incubation or gestation period of the creature.
- **Mature Time**{:.ui-keyword}: The time it takes for the baby to grow into an adult.
- **Mating Interval Min**{:.ui-keyword}: The minimum amount of time a mother requires before mating again.
- **Mating Interval Max**{:.ui-keyword}: The maximum amount of time a mother requires before mating again.
- **Name Tag**{:.ui-keyword}: Beacon uses the name tag in the [Creature Spawns](/configs/arksa/creature_spawns/) editor in the **Weight Multipliers**{:.ui-keyword} tab.

The stats list helps Beacon compute effects in the [Stat Multipliers](/configs/arksa/stat_multipliers/) **Creatures**{:.ui-keyword} tab.

### Loot Drop Advanced Settings

{% include image.html file="loot-advanced.png" file2x="loot-advanced@2x.png" caption="Loot drop advanced settings control how the drop appears in Beacon's lists." %}

- **Minimum Multiplier**{:.ui-keyword}: The minimum quality multiplier the loot drop will apply to its contents. If this is not known, leave it at 1.
- **Maximum Multiplier**{:.ui-keyword}: The maximum quality multiplier the loot drop will apply to its contents. If this is not known, leave it at 1.
- **Icon**{:.ui-keyword}: A choice of icons for Beacon to show for the drop in the [Loot Drops](/configs/arksa/loot_drops/) editor.
- **Icon Color**{:.ui-keyword}: A choice of colors to apply to the icon.
- **Experimental**{:.ui-keyword}: If enabled, the drop will not show in the **Add Loot Drop**{:.ui-keyword} window unless the **Show Experimental Loot Drops**{:.ui-keyword} option is turned on. Beacon's official data uses this to hide drops that don't behave like normal drops.
- **Minimum Item Sets**{:.ui-keyword}: The minimum number of item sets the drop must contain in order to function. This should almost always be set to 1.
- **Notes**{:.ui-keyword}: Tips shown to the user in older versions of Beacon.
- **Sort Order**{:.ui-keyword}: Beacon's loot drop lists are not sorted alphabetically, so this field allows you to specify a number. Higher values will sort further down the list. Drops with the same sort value are sorted alphabetically. Regular drops use values between 1 and 16. Odd numbers for basic drops, even numbers for bonus drops. The order is white, green, blue, purple, yellow, red, cyan, and orange. So Island White uses 1, Island White Bonus uses 2, Island Green uses 3, and so on. Cave drops continue in a similar fashion, and dino drops always use 200. Specialty drops, such as candy corn and gift drops, use 500. The **Suggest**{:.ui-keyword} will make a guess based on the icon and color.

### Loot Drop Contents

{% include image.html file="loot-contents.png" file2x="loot-contents@2x.png" caption="The loot drop contents allow the 'Load Default Contents When Available' option to function." %}

The **Contents**{:.ui-keyword} tab contains a loot drop editor where the default contents of the drop can be entered.

### Spawn Point Contents

{% include image.html file="spawn-contents.png" file2x="spawn-contents@2x.png" caption="The Contents tab contains a spawn point editor where the default contents of the spawn point can be entered." %}

## When Done Editing

Custom mods - those that are stored in your account for your own use - will show a **Save**{:.ui-keyword} button to save your changes. To make your changes visible to your projects, save your changes first.

Remote mods will show a **Publish**{:.ui-keyword} button instead. This works like saving, but your changes will go to Beacon's live data and become available to all users after approximately a 15 minute delay. Beacon batches changes to avoid users having to download lots of smaller files.

## Mod Discovery

Mod Discovery for Ark: Survival Ascended downloads the mod file from CurseForge and attempts to automatically detect the mod's contents.

To begin, open the **Mods**{:.ui-keyword} view at the top of Beacon's window. Below the **Mods**{:.ui-keyword} item will be a **Discover Mods**{:.ui-keyword} button.

{% include image.html file="discovery-classic.png" file2x="discovery-classic@2x.png" caption="The Mod Discovery window needs to know what you want discovered." %}

### Mod Numbers

You will need to find the mod numbers from CurseForge. Go to [CurseForge](https://www.curseforge.com/ark-survival-ascended) and search for the mod using the box at the top. After selecting a mod, the mod's number will appear as "Project ID" on the right side under "About Project". On small screens, this section is collapsible and will appear near the top, just before the mod's title and author name.

Mod Discovery can be used on multiple mods at once. Separate mod numbers with commas in the **Desired Mod Numbers**{:.ui-keyword} field.

### Server-Assisted Mod Discovery

If available on your device, Server-Assisted Mod Discovery (SAMD) will provide much better results. Beacon will only display this option if it is compatible with your device. SAMD is available for Windows x86 64-bit systems. Windows ARM, Windows x86 32-bit, and macOS systems will not be able to run the utility required to extract data from the game files.

{% include image.html file="discovery-sa.png" file2x="discovery-sa@2x.png" caption="On compatible devices, Server-Assisted Mod Discovery will be available." %}

SAMD requires the Ark: Survival Ascended Dedicated Server to be installed on the system, but does not need to actually run the server. If you are using the server for another purpose, such as hosting a server, SAMD won't interfere. SAMD just needs to read some of the game files.

Set the **Dedicated Server Path**{:.ui-keyword} to the top level of the game folder. This folder will contain the `ShooterGame` and `Engine` folders.

#### If you own Ark: Survival Ascended on Steam

In the Mod Discovery window, with the SAMD option checked, the **Go to Steam Page**{:.ui-keyword} button will open Steam and display the dedicated server for you to install.

The server path can be found by clicking on the gear icon in the top right corner and selecting "Manage" and then "Browse Local Files".

#### If you do not own Ark: Survival Ascended on Steam

SteamCMD can be used to download the dedicated server.

1. Download SteamCMD from [https://developer.valvesoftware.com/wiki/SteamCMD](https://developer.valvesoftware.com/wiki/SteamCMD) and unzip to a location of your choosing. In this example, we're going to put SteamCMD in `D:\steamcmd`, so the path to the exe would be `D:\steamcmd\steamcmd.exe`.
2. Open a command prompt by right-clicking on the Start menu and choosing Terminal. Depending on your version of Windows, the option may be called Command Prompt or PowerShell instead.
3. Run the following command to install the server: `D: \steamcmd\steamcmd +login anonymous +app_update 2430930 validate +quit`
4. The path to the server will be `D:\steamcmd\steamapps\common\ARK Survival Ascended Dedicated Server`.

When the game updates, run the install command again to download and apply those updates.

### Other Options

- **Replace Previously Discovered Blueprints**{:.ui-keyword}: This option tells Beacon to replace anything found by previous discovery runs. This is useful for getting the most up-to-date information, but if you have previously made changes to blueprints, those changes will be lost with this option turned on. Sometimes mod authors name things in a way that makes sense in the game, but needs additional clarity in Beacon, so changing names is not uncommon.
- **Delete Blueprints That Are Not Found by Discovery**{:.ui-keyword}: Sometimes mod authors remove content. With this option turned on, Beacon will delete anything that it cannot discover.
- **Ignore Official Classes**{:.ui-keyword}: In rare cases, mod authors will use the same class names as official classes. These are often not useful to discover as their configs will conflict with the official classes. This option is not available when SADM is turned on.
- **Confidence Threshold**{:.ui-keyword}: With SAMD turned off, Beacon has to do a lot of guessing based on the mod's manifest. Sometimes mod authors name their item classes and unlock classes in such a way that Beacon has a high degree of confidence that they belong together. But sometimes mod authors are inconsistent in their naming. A higher confidence number will find fewer results, but those results are more likely to be correct. There is no correct value for this setting, so trial and error may be necessary.

### Unconfirmed Blueprints

When the process is complete, you may be presented with an **Unconfirmed Blueprints Found**{:.ui-keyword} window. You will need to review its contents and decide if you want to keep anything from the list.

The window shows you blueprints that Beacon found but could not find using the expected mod design techniques. For example, if a mod wants to add a new item to unlock, it does so with a property called `AdditionalEngramBlueprintClasses`, so Beacon will look at that property. It looks in many places to find items that are added to crafting stations, blueprints that replace other blueprints, creatures that are added to spawn points, and more. Sometimes what the mod author wants to do isn't possible using Ark's built-in modding properties, so the author uses code to accomplish the task. Beacon cannot see this code, so it is impossible to know if the code does anything relevant to mod discovery.

To compensate, Beacon will scan the mod's asset registry. Every single class the mod provides will exist in this registry, and Beacon can tell what type of class each one is. This means that Beacon can identify all the blueprints, but cannot tell if they are meaningful.

For example, in the core game you have Stone Arrow and Tranq Arrow. Both can be loaded into a Crossbow. To do this, the Crossbow fires an item called `PrimalItemAmmo_ArrowBase_C`, of which both Stone Arrow and Tranq Arrow are children. But there's no reason to discover `PrimalItemAmmo_ArrowBase_C` because there's not much you can do with it. You can't put it in drops, you can't change its crafting recipe, and you can't change its stack size. It's a generic item. However, you _can_ use generic items in crafting recipes, which Ark does a lot. But Beacon has no way to determine if an item found through the asset registry is one of these meta items.

So what you see in the list may or may not be useful. Beacon can't figure that out, so you have to look at the list and decide what you want to do.