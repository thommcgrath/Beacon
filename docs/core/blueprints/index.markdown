---
title: Adding Unsupported Engrams, Creatures, Loot Drops, or Spawn Points to Beacon
parent: Core Features
nav_order: 1
---
# {{page.title}}

> If you find that something is missing which Ark supports without mods, please [let us know](/help/contact).

## Using Mod Discovery

New in Beacon 1.6.3 is a feature called mod discovery. Beacon can download the mod files from Steam, install them, and launch a dedicated server to retrieve information about the mod automatically.

> **There are some things to be aware of**: 
> - While this process will not affect your save data, it will install mods if they are not already installed.
> - This process uses the [DataDumper](https://steamcommunity.com/sharedfiles/filedetails/?id=2171967557) mod to do its work. This mod is pretty good at what it does, but it isn't perfect and some things may be missed. Discovering some mods may not work at all. This is no fault of the mod author, the modding tools just don't provide access to everything it could need. Still, starting from the discovery results and manually making adjustments from there is better than nothing.
> - Mod discovery is only available on Windows, as there is no Ark dedicated server available for macOS.

To begin, open the **Blueprints**{:.ui-keyword} view at the top of Beacon's window. Below that, if the "User Blueprints" mod opens automatically, close it or click the **Mods**{:.ui-keyword} item on the far left. Below the **Mods**{:.ui-keyword} item will be a **Discover Mods**{:.ui-keyword} button.

{% include image.html file="ui.png" file2x="ui@2x.png" caption="Getting started in the Mods section of Blueprints." %}

Mod discovery needs to know the path to your Ark install. The default path may be correct, though if you have the game installed on a different drive, you'll need to correct it. It should be inside your Steam library at `SteamApps\common\ARK\`. You're looking for the folder which contains the "Engine", "ShooterGame", and "Tools" folders. If you need help finding it, choose Ark in your Steam library, click the gear to the far right of the window, opposite the Play button, and choose "Manage" -> "Browse local files." The folder that opens is the one you're looking for.

Next, you'll need one or more mod ids to discover. When browsing the workshop, most mods will list their id. It will be a number such as 655261420. If the mod author has not listed the id, you can find it in the mod url. You may need to turn on the "Display web address bars when available" option in Steam's interface settings. Near the top of Steam's window, just below the "Store", "Library", and "Community" buttons, you will see the mod url. The id is the numbers at the after `?id=`, up until the next `&` symbol. Both mod ids on the page have been highlighted in the screenshot below.

{% include image.html file="workshop.png" file2x="workshop@2x.png" caption="The mod id of Homing Pigeon is 655261420." %}

Once your mod discovery window is setup with your ark install path and desired mod ids, you're ready to let it work.

{% include image.html file="setup.png" file2x="setup@2x.png" caption="Mod discovery ready to begin." %}

If the mod or mods are not already installed, Beacon will first download and install them. Then a command line window will open up. Leave it alone. This next step can take 5-15 minutes, maybe more, depending on the number of mods to be discovered and the capabilities of the computer. During this time, very little will appear to happen. You might even see messages like `gethostname() failed` that you don't need to be worried about. Just let it work.

{% include image.html file="launching.png" file2x="launching@2x.png" caption="Launching the server... and waiting..." %}

When you start seeing output like the screenshot below, the process is almost finished.

{% include image.html file="server_output.png" file2x="server_output@2x.png" caption="Blueprints being discovered." %}

When the command window closes, Beacon will spend a few seconds importing the discovered blueprints. You'll be given a report like the one below.

{% include image.html file="discovery_finished.png" file2x="discovery_finished@2x.png" caption="The Homing Pigeon mod was discovered, and 7 blueprints were added." %}

You can find the added mods in the **Mods**{:.ui-keyword} list. Double click one to view or edit blueprints.

{% include image.html file="imported_blueprints.png" file2x="imported_blueprints@2x.png" caption="The Homing Pigeon blueprints." %}

Skip to [Editing Blueprints](#editing-blueprints) below unless you manually need to add blueprints yourself.

## Adding Manually

Beacon needs the full blueprint path to everything you want to add. Beacon can extract the paths from the spawn cheat codes, such as `cheat giveitem` or `cheat spawndino`. Less specific variants, such as `cheat giveitemnum`, `cheat gfi`, `cheat summon`, and `cheat spawnactor` will not work, as they do not contain the full blueprint path or do not provide Beacon with enough information. If you don't have the cheat codes, you will need to add items one by one.

> If you only have the class strings, such as `PrimalItemStructure_Something_C`, Beacon will allow you to enter the value as a blueprint path. You will be warned that doing so is not recommended, because Beacon will need to make up a fake path for the item. It will not be correct and could cause confusion should the correct path ever be added to Beacon.

### Getting Started

At the top of the window, select the **Blueprints**{:.ui-keyword} view. This is where mod authors can manage the engrams, creatures, and spawn points their mod provides. But all Beacon users also have a "User Blueprints" mod that is exclusive to their Beacon account. This isn't really a mod, but it is used by Beacon to separate user-specific content from content shared by all users. For most users, selecting the **Blueprints**{:.ui-keyword} view will also automatically open the **User Blueprints**{:.ui-keyword} mod for editing.

{% include image.html file="user_blueprints.png" file2x="user_blueprints@2x.png" caption="The Blueprints view provides access to the blueprints you have added to Beacon." %}

In the **User Blueprints**{:.ui-keyword} mod tab there are seven buttons. From left to right, they are:

- **New Blueprint**, which is used for adding a blueprint manually.
- **Save** or **Publish** will be used for saving changes to the mod. **Save** will be displayed for the **User Blueprints**{:.ui-keyword} mod, while **Publish** will be displayed for globally-shared mods.
- **Revert** will discard all the changes made and restore the mod back to the last saved or published state.
- **Import File**, which imports all available blueprints from the selected file. The file must contain the cheat codes; it cannot import from Ark game files.
- **Import URL**, which imports all available blueprints from the provided url. The url must contain the cheat codes.
- **Import Copied**, which will be disabled until you have copied cheat codes. Pressing it will import from the copied cheat codes.
- **Export**, will prepare a JSON file of your blueprints that can be imported by another user or onto another computer.

#### Adding From a Website

The easiest way to get items into Beacon is using the **Import URL**{:.ui-keyword} button described above. Enter the full URL to a web page containing the cheat codes, and Beacon will attempt to do the rest.

{% include image.html file="import_url.png" file2x="import_url@2x.png" caption="Importing blueprints from a web page." %}

> This feature works with most websites, but some websites such as Google Docs will not work with Beacon.

#### Adding From the Clipboard

When adding from a website isn't practical, you can also copy the cheat codes for Beacon to import. Beacon can find any number of codes through just about any formatting, so selecting a copying an entire column of codes from a Google Docs spreadsheet should work just fine. Once you have copied at least one working cheat code, the **Import Copied**{:.ui-keyword} button will become enabled. All you need to do is click it.

#### Adding From a File

Beacon can also import from a file on your computer. Just like the other methods, formatting is not important to Beacon. Select a file containing cheat codes in some form, and Beacon will try to find them.

#### Adding Manually

Pressing the **New Blueprint**{:.ui-keyword} button will present an empty editor for the new blueprint.

{% include image.html file="blueprint_common.png" file2x="blueprint_common@2x.png" caption="An empty blueprint editor." %}

See the next step for editing blueprints.

## Editing Blueprints

Everything that Beacon has imported will be listed in the list. Double clicking a blueprint allows it to be edited.

{% include image.html file="blueprint_common_filled.png" file2x="blueprint_common_filled@2x.png" caption="This is Beacon's import of the Homing Pigeon mod's Flag item." %}

Every field is important in some way. For imported blueprints, the **Type**{:.ui-keyword} and **Blueprint Path**{:.ui-keyword} fields should almost never be changed. Manually created blueprints will need these filled in though.

Beacon will guess at the blueprint name based on its path. While these are reasonable guesses, if you wish to fine tune the names, use the **Name**{:.ui-keyword} field to do so.

The **Tags**{:.ui-keyword} field allows you to add organization to your blueprints. You can add as many tags as you like, separated by commas. Beacon uses a few special tags. `Blueprintable` means the blueprint can be a blueprint in the game, and causes Beacon to enable the **Chance To Be Blueprint**{:.ui-keyword} setting in the loot drop editor. The `Blueprint` tag is tells Beacon the blueprint is a recipe, such as the "Element from Dust" blueprint that crafts Element. The `Generic` tag tells Beacon that the blueprint is non-specific, such as "Any Egg" or "Any Artifact" and is intended for use in crafting recipes. The loot drop editor will not export or deploy drops containing engrams with either the `Blueprint` or `Generic` tags.

The **Map Availability**{:.ui-keyword} checkboxes tell Beacon which maps to pre-select when adding the blueprint to a Preset. Most users choose to leave all maps selected.

There is an **Advanced**{:.ui-keyword} tab at the top of the blueprint editor that will display a different set of fields depending on the blueprint type. These advanced fields are optional, but each can help Beacon in some way. If you choose to set these values, be sure to set them to match their in-game values, not the values you would like them to be.

#### Engrams

**Entry String**{:.ui-keyword}, **Unlockable At Level**{:.ui-keyword}, and **Required Engram Points**{:.ui-keyword} will allow the engram to appear in the **Engram Control**{:.ui-keyword} editor. If the engram has only an entry string, it will be treated as a Tek engram. Otherwise, both the level and point requirements must be included.

**Stack Size**{:.ui-keyword} is used by Beacon's **Stack Sizes**{:.ui-keyword} editor to make sure the user does not set the stack size greater than Ark can handle. For example, Ark stack sizes cannot exceed 2,147,483,647. If the engram normally stacks to 1,000 and the user were to enter a **Global Stack Size Multiplier**{:.ui-keyword} value of 10,000,000 (don't laugh, users do it) Beacon will know the engram would exceed the maximum and automatically insert a `ConfigOverrideItemMaxQuantity` line to limit the engram appropriately.

**Crafting Recipe**{:.ui-keyword} is used by Beacon's **Crafting Cost**{:.ui-keyword} editor when the user checks the **Load Official Values When Available**{:.ui-keyword} checkbox. It also allows the **Adjust All Crafting Costs**{:.ui-keyword} tool to work on the engram.

#### Creatures

**Incubation Time**{:.ui-keyword} and **Mature Time**{:.ui-keyword} are for the incubation/gestation time and mature times for the creature. Setting these values will allow the creature to appear in the **Breeding Multipliers**{:.ui-keyword} editor.

**Mating Interval Min**{:.ui-keyword} and **Mating Interval Max**{:.ui-keyword} are used to specify the default range of the creature's mating interval.

**Stats**{:.ui-keyword} will allow the creature to appear as a preview option in Beacon's **Stat Multipliers**{:.ui-keyword} editor.

#### Loot Drop

**Minimum Multiplier**{:.ui-keyword} and **Maximum Multiplier**{:.ui-keyword} describe the range of quality multipliers the game will add to everything in the drop. If you don't know these, leave them at 1.0.

**Icon**{:.ui-keyword} and **Icon Color**{:.ui-keyword} allow you to choose how the drop appears in Beacon's lists.

Turn on **Experimental**{:.ui-keyword} if the drop should be hidden until the **Show Experimental Loot Drops**{:.ui-keyword} option is turned on.

**Minimum Item Sets**{:.ui-keyword} is the minimum number of item sets the drop **must** contain. For example, if the drop does not work properly without at least two item sets, set this to two. This is not the minimum range of item sets to be chosen.

**Notes**{:.ui-keyword} will be displayed below the drop in the **Add Loot Drop**{:.ui-keyword} list, as well as inside the **Item Sets**{:.ui-keyword} column. This is most useful for instructions about what makes the drop unusual, if anything.

**Sort Order**{:.ui-keyword} helps Beacon decide how to sort the drop in the list. For example, Aberration Green has a value of 3, Aberration Green Bonus has 4, and Aberration Blue has 5. Island Blue also uses 5 though, so Beacon will sort Aberration Blue and Island Blue together, alphabetically. The **Suggest**{:.ui-keyword} button will guess at a value to use based on the icon.

Lastly, the **Contents**{:.ui-keyword} tab is a full-featured loot drop editor. This sets the contents of the drop when the **Load Default Contents When Available**{:.ui-keyword} option is enabled.

#### Spawn Points

The **Advanced**{:.ui-keyword} tab for a Spawn Point is a full spawn point editor. Use this to provide Beacon default values available when the user choose the **Load Simplified Defaults**{:.ui-keyword} in Beacon's **Spawn Points**{:.ui-keyword} editor. This data also allows the **Convert Creature Replacements to Spawn Point Additions**{:.ui-keyword} tool to function corrected with the mod's spawn point.

### Multi Editor

Users can select multiple blueprints to edit them at the same time. Right click any of the selected blueprints and choose Edit.

{% include image.html file="multi.png" file2x="multi@2x.png" caption="Select as many blueprints as you wish and edit them at the same time." %}

When selecting multiple blueprints, only the **Tags**{:.ui-keyword} and **Map Availability**{:.ui-keyword} options will be available. No **Advanced**{:.ui-keyword} tab will be available when editing multiple blueprints. Blue tags will be added to all blueprints that do not already have the tag, and Red tags will be removed from any blueprint that has the tag. Gray tags will be left alone, neither added nor removed from any blueprint.
