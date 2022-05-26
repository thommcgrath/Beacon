---
title: Item Stat Limits
parent: Config Editors
configkeys:
  - ClampItemStats
  - ItemStatClamps
---
{% include editortitle.markdown %}

Ark allows server admins to define maximum values for the game's 8 item stats, which will apply to all items, no matter how or when they were obtained.

> This setting requires setting the `ClampItemSets` command line option to True. Beacon will do this for Nitrado and GameServerApp.com servers automatically. Users with other hosts will need to refer to their control panel to enable the option.

{% include image.html file="limitseditor.png" file2x="limitseditor@2x.png" caption="The Item Stat Limits editor without any stats limited." %}

By default, no stats are limited. To limit a stat, check the checkbox next to it. Values can be entered into the field to the right of the stat or using the column in the list below. For example, if you wanted to limit Damage to 200%, check the checkbox next to Damage, then enter 200 into the Damage column next to either Longneck Rifle or Assault Rifle. The field next to Damage will compute the correct value to use. If you wanted to limit Damage to that of official servers, use the value 19800 in the field next to Damage. The list will show 298% next to both Longneck Rifle and Assault Rifle.

{% include image.html file="twoninetyeight.png" file2x="twonintyeight@2x.png" caption="Damage limited to 298% like on official servers." %}

It is not practical for Beacon to compute the effective limits for every item, so Beacon displays a few items to demonstrate the effects. The Raptor Saddle is used for demonstrating basic saddle armor, and the Doedicurus Saddle demonstrates "tank" saddle armor. Longneck Rifle and Assault Rifle share the same damage values, but they have different durability values.

### Usage Tips

- **Warning**: Setting a stat maximum will permanently affect all items in the game. For example, a 400% damage Longneck blueprint will become a 300% damage Longneck blueprint if the damage stat is limited to 300%. Removing or increasing the limit will **not** restore the blueprint to its original damage.
- This feature cannot be used to increase the damage limit. Item stats work exactly the same as player and dino stats, except the player does not get to choose which stats to put points into. Like player and dino stats, no stat can have more than 255 points assigned to it. This is where the 755.3% damage cap comes from: no more points can be assigned to damage.
- In the [Loot Drops](/configs/lootdrops/) editor, the _Stat Limits Multiplier_ can be used to influence the limits of individual items. Using the previous 19800 example value from before, a multiplier of 2 would equal 39600 / 496% damage, while a multiplier of 0.5 would equal 9900 / 199% damage. The multiplier is applied to **all** enabled limits, and the server must be using item stat limits for the multiplier to have an effect.

{% include affectedkeys.html %}