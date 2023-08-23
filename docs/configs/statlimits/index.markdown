---
title: Item Stat Limits
parent: Config Editors
configkeys:
  - ClampItemStats
  - ItemStatClamps
supportedgames:
  - "Ark: Survival Evolved"
---
{% include editortitle.markdown %}

Ark allows server admins to define maximum values for the game's 8 item stats, which will apply to all items, no matter how or when they were obtained.

{:.primary .titled}
> Important
> 
> This setting requires setting the `ClampItemSets` command line option to True. Beacon will do this for Nitrado and GameServerApp.com servers automatically. Users with other hosts will need to refer to their control panel to enable the option.

{:.caution .titled}
> Note
> 
> This feature cannot be used to increase the damage limit. Item stats work exactly the same as player and dino stats, except the player does not get to choose which stats to put points into. Like player and dino stats, no stat can have more than 255 points assigned to it. This is where the 755.3% damage cap comes from: no more points can be assigned to damage.

{:.warning .titled}
> Warning
>
> Setting a stat maximum will permanently affect all items in the game. For example, a 400% damage Longneck blueprint will become a 300% damage Longneck blueprint if the damage stat is limited to 300%. Removing or increasing the limit will **not** restore the blueprint to its original damage.

## Defining Limits

{% include image.html file="limitseditor.png" file2x="limitseditor@2x.png" caption="The Item Stat Limits editor without any stats limited." %}

By default, no stats are limited. To limit a stat, check the checkbox next to the stat. Values can be entered into the field to the right of the stat or using the column in the list below. For example, if you wanted to limit Damage to 200%, check the checkbox next to Damage, then enter 200 into the Damage column next to either Longneck Rifle or Assault Rifle. The field next to Damage will compute the correct value to use.

{% include image.html file="twohundred.png" file2x="twohundred@2x.png" caption="The limit can be set in the list column, which will compute the correct value in the fields above." %}

If you wanted to limit Damage to that of official servers, use the value 19800 in the field next to Damage. The list will show 298% next to both Longneck Rifle and Assault Rifle.

{% include image.html file="twoninetyeight.png" file2x="twoninetyeight@2x.png" caption="Damage limited to 298% like on official servers." %}

It is not practical for Beacon to compute the effective limits for every item, so Beacon displays a few items to demonstrate the effects. The Raptor Saddle is used for demonstrating basic saddle armor, and the Doedicurus Saddle demonstrates "tank" saddle armor. Longneck Rifle and Assault Rifle share the same damage values, but they have different durability values.

## Loot Stat Limits Multiplier

{% include image.html file="multiplier.png" file2x="multiplier@2x.png" caption="Loot entries have a Stat Limits Multiplier that allows producing loot above or below the defined limit." %}

In the [Loot Drops editor](/configs/lootdrops/), the **Stat Limits Multiplier**{:.ui-keyword} field allows adjusting the item's stat limits. **The stat must have a limit enabled for the multiplier to have an effect**. Using the previous 19800 damage limit as an example, a multiplier of 2.0 would impose a limit of 39600 / 496% damage, while a multiplier of 0.5 would impose a limit of 9900 / 199% damage. The multiplier is applied to **all** enabled limits.

{% include affectedkeys.html %}