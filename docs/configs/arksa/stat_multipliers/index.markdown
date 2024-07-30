---
title: Stat Multipliers
parent: "Ark: Survival Ascended"
grand_parent: Config Editors
configkeys:
  - MutagenLevelBoost
  - MutagenLevelBoostBred
  - PerLevelStatsMultiplier_DinoTamed
  - PerLevelStatsMultiplier_DinoTamed_Add
  - PerLevelStatsMultiplier_DinoTamed_Affinity
  - PerLevelStatsMultiplier_DinoWild
  - PerLevelStatsMultiplier_Player
  - PlayerBaseStatMultipliers
supportedgames:
  - "Ark: Survival Ascended"
---
{% include editortitle.markdown %}

For a greater effect on server difficulty than just changing the level of the wild creatures on a server, Ark admins can adjust the values granted for each stat point distributed to players, tamed creatures, and wild creatures.

## Player Stats

{% include image.html file="playerstats.png" file2x="playerstats@2x.png" caption="Beacon's player stats editor shows the effects in real time." %}

Player stats are built from two columns. The **Base Value**{:.ui-keyword} column shows the values a brand new player spawns in with, and the **Per Level**{:.ui-keyword} column is the amount of increase the player will see when a point is added to the stat.

> **Ark Bug**: Although Ark and Beacon support editing the **Base Value**{:.ui-keyword} for some stats, most server admins recommend against changing the base values. Players will often join a server later to find their stats aren't quite what they remember. A respawn fixes the issue, but changing the base usually isn't worth the trouble caused to players.

Every editable value in the **Per Level**{:.ui-keyword} column is a multiplier. This means a value of 2 would double the amount gained per level. Editing a value will immediately calculate the effect to the right of the field after the equals sign.

## Creature Stats

{% include image.html file="creaturestats.png" file2x="creaturestats@2x.png" caption="Beacon's creature stat editor has four different sections, each with a unique meaning, and allows previewing effects using a creature as a guideline." %}

The **Preview with Creature**{:.ui-keyword} menu allows users to select any creature in the game to preview the effect of stat changes. Ark does not support setting stats on a creature-by-creature basis; stat adjustments will always affect all creatures.

> **Note**: The calculated values shown are not perfect. Perfect stat calculation requires knowing many details about a specific creature, which doesn't make sense for this editor. As a result, Beacon's calculations are an approximation. For those curious, [the wiki has a detailed explanation of the math required](https://ark.wiki.gg/wiki/Creature_stats_calculation).

The **Wild Per-Level**{:.ui-keyword} and **Tamed Per-Level**{:.ui-keyword} columns work very similarly to the player stats. Every wild creature is granted a number of points based on their wild level, which are distributed randomly to the creature's stats. Tamed creatures, of course, allow the rider to decide which stat each point is assigned.

The **Taming Reward**{:.ui-keyword} column applies to the levels earned during taming. All creatures gain a number of levels based on the taming effectiveness, which equals the number of points that will be randomly distributed once taming is complete.

The **Max Effectiveness Reward**{:.ui-keyword} is granted once to all stats based on the taming effectiveness. At 100% effectiveness, the values displayed would be added to each stat. At 50% effectiveness, only half of each displayed value would be added to each stat. In the screenshot above, the Fire Wyvern would gain 13.2% damage at 100% efficiency, 9.9% at 75% efficiency, 6.6% at 50% efficiency, and so on.

## Mutagen

{% include image.html file="mutagen.png" file2x="mutagen@2x.png" caption="Beacon can also adjust Mutagen bonuses." %}

The Mutagen page allows changing the number of levels added to each stat when a creature is fed mutagen. The **Tamed**{:.ui-keyword} column is used when feeding mutagen to a creature that has wild parents, while the **Bred**{:.ui-keyword} column is used when feeding mutagen to a creature with tamed parents. See [Ark wiki](https://ark.wiki.gg/wiki/Mutagen#Usage) for more details.

{% include affectedkeys.html %}