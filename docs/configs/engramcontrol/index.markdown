---
title: Engram Control
parent: Config Editors
configkeys:
  - bAutoUnlockAllEngrams
  - bOnlyAllowSpecifiedEngrams
  - EngramEntryAutoUnlocks
  - OverrideEngramEntries
  - OverrideNamedEngramEntries
  - OverridePlayerLevelEngramPoints
---
{% include editortitle.markdown %}

Ark server admins can customize how and when engrams are unlocked, as well as the number of points granted at each level. This guide will help admins understand their options, such as unlocking everything at player creation, or granting tek a specific level instead of by completing boss fights.

{% include omninotice.markdown %}

## Understanding the Editor

{% include image.html file="engramcontrol.png" file2x="engramcontrol@2x.png" caption="Engram Control is pre-populated with all engrams for your enabled mods." %}

The editor is split into two major sections, each with two columns. The **Engram Control**{:.ui-keyword} list takes up the majority of the space and has columns for **Engram**{:.ui-keyword}, **Behaviors**{:.ui-keyword}, and **Mod**{:.ui-keyword}. Beacon will list every engram with a known unlock code for the mods currently enabled. The **Behaviors**{:.ui-keyword} column will describe the status of the engram. The **Mod**{:.ui-keyword} column will show which mod the engram comes from.

The **Unlock Points**{:.ui-keyword} list is used for controlling the number of points awarded at each level.

Both lists are pre-populated with Ark's default values. Any row in either list may be deleted to restore the value to Ark's default, and multiple selection is possible for editing or restoring many engrams or levels at the same time.

## Changing Engram Behavior

{% include image.html file="engramsettings.png" file2x="engramsettings@2x.png" caption="Each engram has options that control how and when it can be unlocked." %}

To change an engram, double-click a row or use the **Edit**{:.ui-keyword} icon at the top of the list. There are six options to choose from:

- **Entry String**{:.ui-keyword}: While editing an engram, this field will not be editable. To add an unlock that Beacon does not know, use the plus button at the top of the **Engrams**{:.ui-keyword} list, and this field will be editable.
- **Enabled**{:.ui-keyword} and **Disabled**{:.ui-keyword}: This option turns the engram on or off. When an engram is disabled, it cannot be learned and will not spawn in the game at all, including from loot drops. Cheat codes will still work, and disabling an engram will not prevent it from being transferred in from another server, nor will it destroy existing items already created.
- **Automatically Unlocks**{:.ui-keyword}: This option causes the engram to automatically unlock at the level specified by the **Auto Unlocks At**{:.ui-keyword} value. The **Required Points**{:.ui-keyword} field and **Remove Prerequisites**{:.ui-keyword} checkbox will become disabled.
- **Required Level**{:.ui-keyword} or **Auto Unlocks At**{:.ui-keyword}: This is the level the player must reach to either allow the engram to be unlocked, or have the engram auto unlocked, depending on the **Automatically Unlocks**{:.ui-keyword} choice. Some engrams will say "Tek" for this value. Ark does not allow Tek engrams to be manually unlocked. Tek engrams must be auto-unlocked at a specified level, or auto-unlocked by meeting their original requirements.
- **Required Points**{:.ui-keyword}: If the engram is not automatically unlocked, the player must spend this many points to unlock the engram.
- **Remove Prerequisites**{:.ui-keyword}: Engrams often require other engrams to be learned first. For example, a Wood Foundation requires the Thatch Foundation to be learned. This option allows those requirements to be ignored. Ark does not allow changing the requirements, only removing them. This option will not remove Tek engram unlock requirements.

After making changes, the **Behaviors**{:.ui-keyword} column will update to explain the new unlock behaviors.

## Changing Earned Engram Points

The **Unlock Points**{:.ui-keyword} list on the right shows the number of engram points earned at each level. This list will update according to the levels defined in Beacon's [Levels and XP editor](/configs/experiencecurves/), if it has been used. The official player levels will be used otherwise. Double click a row or use the pencil icon at the top of the list to change the number of points earned for the selected level or levels. Use the add icon to define a new level if necessary. This will not add a new level that the player may earn, that must be done with the **Levels and XP**{:.ui-keyword} editor.

## Use the Wizard to Make Large Changes Quickly

{% include image.html file="engramwizard.png" file2x="engramwizard@2x.png" caption="Use the engram wizard to choose from many common engram unlock designs." %}

Press the **Auto Control**{:.ui-keyword} button to open a dialog with a **Design**{:.ui-keyword} menu. The following options are available:

- **Unlock all at spawn**{:.ui-keyword}: All engrams, including Tek engrams, will be unlocked immediately when the player first spawns.
- **Unlock all except Tek at spawn**{:.ui-keyword}: Same as the previous option, but Tek engrams will not be changed.
- **Unlock all while leveling**{:.ui-keyword}: This option will produce the same behavior as the **Automatically Unlock Engrams While Leveling**{:.ui-keyword} [advanced option](#advanced-settings), but will do so by changing each individual engram. This will reduce lag, as Ark will not need to search through its entire list of engrams to determine what needs to be unlocked.
- **Unlock all except Tek while leveling**{:.ui-keyword}: Same as the previous option, but Tek engrams will not be changed.
- **Unlock unobtainable while leveling**{:.ui-keyword}: Any engrams that cannot be earned on the project's enabled maps will be auto unlocked at their unlock level. For example, if only The Island is selected, the Adobe Foundation will be automatically unlock at level 15. If both The Island and Scorched Earth are selected, no change will be made to Adobe Foundation.
- **Unlock Tek at level**{:.ui-keyword}: A level field will become visible. Use this to have Tek engrams automatically unlocked when the player reaches the specified level.
- **Grant exact points needed per level**{:.ui-keyword}: Computes the total number of engram points required for every engram that is obtainable, not disabled, and not automatically unlocked, then changes the points earned at each level accordingly. This will respect any engram changes previously made.
- **Make everything unlockable at level**{:.ui-keyword}: A level field will become visible. Every engram will become learnable at the specified level, but will not be automatically unlocked, so the player will still be required to spend engram points. Since Tek engrams must always be automatically unlocked, no changes are made to Tek engrams.

## Advanced Settings

Ark has two settings which have a huge impact on how engrams behave. At the top of Beacon's editor, is an **Advanced**{:.ui-keyword} button. Clicking the icon opens a menu with two options:

{% include image.html file="advanced.png" file2x="advanced@2x.png" caption="The two advanced options completely change how unlocks work." %}

- **Automatically Unlock Engrams While Leveling**{:.ui-keyword}: With this option enabled, Ark will automatically unlock any engrams the player is able to learn at their level. Tek engrams are unlocked at level 1. Admins are advised not to use this option because there is significant game lag at every level up, even if there are no engrams to be unlocked. When this option is enabled, Beacon will immediately update its **Behaviors**{:.ui-keyword} column according to this setting.
- **Disable Engrams by Default**{:.ui-keyword}: Normally, all engrams are allowed and if the admin wants to prevent an engram from being learned, the admin can add a config option to disable it. With this option chosen, the logic is reversed. All engrams will be disabled by default, and the admin can choose to enable engrams with config options. When this option is enabled, Beacon will immediately update its **Behaviors**{:.ui-keyword} column according to this setting.

{% include affectedkeys.html %}