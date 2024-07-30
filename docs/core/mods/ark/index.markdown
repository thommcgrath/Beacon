---
title: "Ark: Survival Evolved"
parent: Game Mods in Beacon
grand_parent: Core Features
---
# Managing Mod Content for Ark: Survival Evolved

## Editing Blueprints

In Unreal Engine, almost everything is a blueprint. So when you edit mod content, you are telling Beacon about blueprints that have been added to Ark via a mod. This has nothing to do with Ark's in-game concept of a blueprint being a recipe for an item you can craft.

Start with the **New Blueprint**{:.ui-keyword} button to create a blueprint, or double-click a blueprint to edit it.

### Common Settings

All blueprints start with the same **Common**{:.ui-keyword} tab. This is where you tell Beacon the basic information about the blueprint, such as path, name, and availability.

{% include image.html file="common.png" file2x="common@2x.png" caption="Common settings for all Ark: Survival Evolved blueprints." %}

- **Blueprint Path**{:.ui-keyword}: Beacon needs the full path to the item, because mod authors sometimes use the same class names as each other or as official content. Mod paths will always start with `/Game/Mods/`, so any path that does not must be an official path.
- **Name**{:.ui-keyword}: The name you want the blueprint to appear as in Beacon. This does not necessarily have to be the same as the blueprint's in-game name. For example, natural thatch and thatch made in an industrial grinder have the same in-game name, but should be named differently in Beacon for clarity, so you know which you are working with in your projects.
- **Tags**{:.ui-keyword}: A comma-separated list of tags for the blueprint. See [Object Tagging](/core/tagging/) for more details on tagging. Resist the urge to create separate tags for each mod, as Beacon already has a way of organizing mod content, and too many tags will cause the tag picker to take up a lot of space.
- **Map Availability**{:.ui-keyword}: Tells Beacon where this blueprint is normally used. For example, Desert Cloth Armor is not available on The Island. Beacon uses this information in various wizards, such as automatically unlocking items that are not available on any of the project's maps. Most mod content will use the **All Maps**{:.ui-keyword} option, which will automatically list the blueprint as available on all current and future maps.

### Engram Advanced Settings

{% include image.html file="engram-advanced.png" file2x="engram-advanced@2x.png" caption="Advanced engram settings control things like unlock and crafting requirements." %}

- **Unlock String**{:.ui-keyword}: Typically starts with `EngramEntry`, this is the class name used to unlock the item in the game's Engrams page.
- **Unlockable At Level**{:.ui-keyword}: The player's required level to unlock the item. If this is a tek item, write `Tek`.
- **Required Engram Points**{:.ui-keyword}: The number of unlock points needed to unlock the item. If this is a tek item, write `Tek`.
- **Stack Size**{:.ui-keyword}: The maximum number of this item that can exist in a stack. Beacon uses this in the [Stack Sizes](/configs/ark/stack_sizes/) editor to calculate the default stack size when adding a new override.
- **Crafting Recipe**{:.ui-keyword}: The recipe for the item. Beacon uses this in various tools, such as the Adjust All Crafting Costs tool. The default recipe can be loaded into your projects when this list is filled in.

### Creature Advanced Settings

{% include image.html file="creature-advanced.png" file2x="creature-advanced@2x.png" caption="Advanced creature settings control things breeding times and stats." %}

Times in this tab use a `Nd Nh Nm Ns` format, so 1 minute 30 seconds would be written as `1m 30s`. Values that are not needed can be skipped. So 2 days could be written as `2d` instead of `2d 0h 0m 0s`.

- **Incubation Time**{:.ui-keyword}: The incubation or gestation period of the creature.
- **Mature Time**{:.ui-keyword}: The time it takes for the baby to grow into an adult.
- **Mating Interval Min**{:.ui-keyword}: The minimum amount of time a mother requires before mating again.
- **Mating Interval Max**{:.ui-keyword}: The maximum amount of time a mother requires before mating again.

The stats list helps Beacon compute effects in the [Stat Multipliers](/configs/ark/stat_multipliers/) **Creatures**{:.ui-keyword} tab.

### Loot Drop Advanced Settings

{% include image.html file="loot-advanced.png" file2x="loot-advanced@2x.png" caption="Loot drop advanced settings control how the drop appears in Beacon's lists." %}

- **Minimum Multiplier**{:.ui-keyword}: The minimum quality multiplier the loot drop will apply to its contents. If this is not known, leave it at 1.
- **Maximum Multiplier**{:.ui-keyword}: The maximum quality multiplier the loot drop will apply to its contents. If this is not known, leave it at 1.
- **Icon**{:.ui-keyword}: A choice of icons for Beacon to show for the drop in the [Loot Drops](/configs/ark/loot_drops/) editor.
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

Beacon can download the mod files from Steam, install them, and launch a dedicated server to automatically retrieve information about the mod.

> **There are some things to be aware of**: 
> - While this process will not affect your save data, it will install mods if they are not already installed.
> - This process uses the [DataDumper](https://steamcommunity.com/sharedfiles/filedetails/?id=2171967557) mod to do its work. This mod is pretty good at what it does, but it's not perfect and some things may be missing. Discovering some mods may not work at all. This is not the fault of the mod author, the modding tools just don't provide access to everything it might need. Still, starting from the discovery results and making manual adjustments from there is better than nothing.
> - Mod discovery is only available on Windows, as there is no Ark dedicated server available for macOS.

To begin, open the **Mods**{:.ui-keyword} view at the top of Beacon's window. Below the **Mods**{:.ui-keyword} item will be a **Discover Mods**{:.ui-keyword} button.

Mod discovery needs to know the path to your Ark installation. The default path may be correct, but if you've installed the game on a different drive, you'll need to correct it. It should be in your Steam library under `SteamApps\common\ARK\`. You're looking for the folder that contains the `Engine`, `ShooterGame`, and `Tools` folders. If you need help finding it, select Ark in your Steam Library, click the gear on the far right of the window, opposite the play button, and select "Manage" -> "Browse local files". The folder that opens is the one you're looking for.

Next, you'll need to find one or more mod ids. If you browse the Steam Workshop, most mods will list their id. It will be a number like 655261420. If the mod author has not listed the id, you can find it in the mod URL. You may need to turn on the "Display web address bars when available" option in Steam's interface settings. At the top of the Steam window, just below the Store, Library, and Community buttons, you will see the mod URL. The id is the numbers after `?id=`, up to the next `&` symbol. Both mod ids on the page are highlighted in the screenshot below.

{% include image.html file="workshop.png" file2x="workshop@2x.png" caption="The mod id of Homing Pigeon is 655261420." %}

Once your mod discovery window is set up with your Ark installation path and desired mod IDs, you're ready to get started.

{% include image.html file="setup.png" file2x="setup@2x.png" caption="Mod discovery ready to begin." %}

If the mod or mods are not already installed, Beacon will first download and install them. Then a command line window will open. Leave it alone. This next step may take 5-15 minutes, maybe more, depending on the number of mods to discover and the capabilities of your computer. During this time, very little will seem to happen. You may even see messages like `gethostname() failed`, but don't worry about it. Just let it work.

{% include image.html file="launching.png" file2x="launching@2x.png" caption="Launching the server... and waiting..." %}

When you see output like the screenshot below, the process is almost finished.

{% include image.html file="server_output.png" file2x="server_output@2x.png" caption="Blueprints being discovered." %}

When the command window closes, Beacon will spend a few seconds importing the blueprints it found. You'll get a report like the one below.

{% include image.html file="discovery_finished.png" file2x="discovery_finished@2x.png" caption="The Homing Pigeon mod was discovered, and 7 blueprints were added." %}

You can find the added mods in the **Mods**{:.ui-keyword} list. Double click one to view or edit its blueprints.