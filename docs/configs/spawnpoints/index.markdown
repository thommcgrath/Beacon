---
title: Creature Spawns
parent: Config Editors
configkeys:
  - ConfigAddNPCSpawnEntriesContainer
  - ConfigOverrideNPCSpawnEntriesContainer
  - ConfigSubtractNPCSpawnEntriesContainer
---
{% include editortitle.markdown %}

Ark server admins are given great control over the game's spawn system. Admins can add creatures/dinos to certain parts of the map, remove creatures, increase levels, and even change colors. This powerful editor requires great care though, as it's easy to create an overspawning problem.

{% include omninotice.markdown %}

## Add a Spawn Point

Just like editing loot drops in Beacon, spawn points must be added to a file before anything will change on the server. Spawn points not added to Beacon will be left as default.

Press the _New Point_ button to begin adding a spawn point.

{% include image.html file="addspawndialog.png" file2x="addspawndialog@2x.png" caption="The &quot;Add Spawn Point&quot; dialog." %}

The _Filter_ field at the top allows searching the spawn points. To the right of the _Filter_ field is a switch that allows searching for _Spawn Points_ or for _Creatures_. When set to _Creatures_, type the name of a creature and Beacon will show all the spawn points that include the creature.

> Users can select multiple spawn points to be added at the same time. Hold shift while selecting points to select a range. Windows users can use Control while clicking to select non-sequential spawn points, and Control-A will select all. Mac users should substitute the Command/Apple key for Control.

The next step is to select a _Mode_ value. _Replace Default Spawns_ will replace all creatures in the spawn point with the ones specified in Beacon. _Add to Default Spawns_ does exactly what it sounds like, allowing users to add new creatures without affecting the current creatures. And _Remove from Default Spawns_ allows removing one or more creatures without affecting the other creatures.

## Adding Shinehorns to Beaches

In this tutorial, the goal is to add Shinehorns to the beaches on The Island. Press the _New Point_ button, select _Beaches_ in the list, and set the _Mode_ to _Add to Default Spawns_.

{% include image.html file="addtobeaches.png" file2x="addtobeaches@2x.png" caption="Adding creatures to the &quot;Beaches&quot; spawn point." %}

Press _OK_ when ready. Next, add a new spawn set by pressing the _New Set_ button in the _Spawn Sets_ column. This will create and select a new spawn set. Use the _Name_ field to call the spawn set Shinehorns. The _Weight_ field in the upper right works exactly the same as every other weight value in Ark. Ark's default weight values are always less than or equal to 1.0, so Beacon defaults the weight to 0.5. The _Beaches_ spawn point often uses much lower values, so to prevent being overrun by Shinehorns, set the _Weight_ field to 0.06.

> **Tip**: Create a new Beacon project, switch to _Creature Spawns, and add the same spawn point in _Replace Default Spawns_ mode with _Load Simplified Default Spawns_ selected. Then look through the weights of each default spawn set to help decide on an appropriate weight value.

Next, press the _Add_ button in the _Creatures_ box. In the _Creature Entry_ dialog, press the _Choose…_ button next to _Creature_ and select _Shinehorn_. Leave all the other fields empty, they are not needed in this step.

At this point, the absolute minimum to make Shinehorns appear on the beaches has been done. However, they will always spawn directly on top of each other. The solution is utilize the _Spread Radius_ value. Nearly all of Ark's default spawn sets use a value of 650, so enter that into _Spread Radius_. This will help, but there is more that can be done to make the spawn point feel even more natural.

It sounds weird, but the solution is **more** Shinehorns. Press the _Add_ button again, select _Shinehorn_, but this time enter 680 into the _Offset Y_ field. That's the middle one. Repeat these steps for values 340, -680, and -340. There should be a total of 5 _Shinehorn_ entries in the _Creatures_ list. To get the spawning to feel even more like Ark's spawning, set the _Weight_ values of each entry according to the screenshot below.

{% include image.html file="shinehorn.png" file2x="shinehorn@2x.png" caption="A completed Shinehorn Spawn Set." %}

To save time, consider using the _Auto Creature_ tool in the _Spawn Sets_ column. This will create a new spawn set with common values. However, pay attention to the spawn set weight, as the chosen weights are estimated based on all maps and spawn points and may not be the best fit for the target spawn point.

Lastly, it is important to limit the number of Shinehorns that will spawn in the area. Press the _New Limit_ button in the _Limits_ section to define a new limit. From the _Creature_ menu, select _Shinehorn_ and set the _Max Percentage_ to 5. This will limit the number of Shinehorns in each of the spawn point instances to 5% of the instance's total population. But... what does that actually mean? That's hard to know exactly. Most spawn point instances use a max population of 40. So 5% of 40 would be 2. This does NOT mean only 2 Shinehorns on the entire map. It means a **maximum** of 2 on each instance of a spawn point. The _Beaches_ spawn point has many instances along the map's coastline. So a 5% limit could still produce dozens of Shinehorns on the map.

### Understanding Limits

The limits work by counting the number of the limited creature that is already at the spawn point, and preventing a new spawn if that number is already over the limit. So, for example, setting the limit to 0.0001 does not mean the creature will not spawn. When there are 0 at the point the creature can still spawn because 0 ÷ 40 = 0 is below 0.0001. As soon as 1 spawns, the limit is reached because 1 ÷ 40 = 0.025 is greater than the limit of 0.0001.

This means users could create a spawn set with a very high weight and very low limit that effectively guarantees one and only one of a certain creature.

> Some users report Ark not obeying their limits when using the _Add to Default Spawns_ mode. It may be necessary to replace the default spawns instead if population cannot be controlled with a combination of spawn set weight and population limit.

## The Other Settings

Each _Spawn Set_ has many more options that can be used to influence spawning.

- _Offset (X, Y, Z)_: Allows moving the spawn set away from the spawn point instance in a three dimensional space.
- _Distance from * Multiplier_: These three settings allow users to increase or decrease the distance the creature must be from players, structures, or tames before it can spawn. Values greater than 1.0 will require more space, values less than 1.0 will require less space.
- _Spread Radius_: Introduces a random amount of distance away from the spawn point instance's center + set offset to make spawns feel more natural.
- _(Water Only) Min Height_: For water spawns, this is the depth the spawn set needs to spawn. This is to prevent sharks from spawning in puddles, for example. 140 is a common value, larger creatures should use 520.
- Colors: The creatures in the spawn set can spawn with different colors than normal. Not all color sets are noticeable on all creatures, and some creatures such as the X variants will not show colors at all. See [this Reddit discussion](https://www.reddit.com/r/playark/comments/mavua0/adding_different_colored_dinos_to_spawns/) for additional details.
- _Add Level Offset Before Multiplier_: This option will change how the level calculations are performed. When selected, the _Level Offset_ will be added to the creature's level first, then the _Level Multiplier_ applied. When not selected, the _Level Multiplier_ is applied first, then the _Level Offset_ is added. These values are described in the next paragraph.

The _Level Range_, _Level Offset_, and _Level Multipliers_ allow changing the level that creatures will spawn. Ark uses this for cave spawns, for example. Use _Level Range_ to specify a specific range for the creature. The levels will automatically scale if the server difficulty is changed. _Level Offset_ is a fixed number of levels to add or remove. _Level Multiplier_ will multiply the creature's level. A value of 2 would turn a 120 creature into a 240 creature, for example.

## Creature Replacements

A _Spawn Set_ can exchange creatures for other creatures. Ark typically uses this to add alpha creatures wherever a standard creature could spawn. When adding a replacement, the replaced creature should also be included. For example, adding Alpha Raptor would be done by adding a new replacement and choosing _Raptor_ as the _Target Creature_. Next add _Alpha Raptor_ as a replacement creature, and set the weight to 1. Then add another replacement, this time select _Raptor_ and set the weight to 9. This will give a 10% chance for any raptor in the set to be an alpha raptor.

{% include image.html file="replacements.png" file2x="replacements@2x.png" caption="Adding Alpha Raptor where Raptors could spawn." %}

## Removing Creatures

When removing creatures from a spawn point, most options are not useful at all. Use a _Spawn Set_ and list the creatures that should be removed in the _Creatures_ box.

## Choosing a Spawn Point

Figuring out which spawn point to use can take practice, so here are some tips the community has learned.

The Ark wiki has spawn maps available to help visualize each point.
- [The Island Spawn Map](https://ark.wiki.gg/wiki/Spawn_Map_(The_Island))
- [Scorched Earth Spawn Map](https://ark.wiki.gg/wiki/Spawn_Map_(Scorched_Earth))
- [Aberration Spawn Map](https://ark.wiki.gg/wiki/Spawn_Map_(Aberration))
- [Extinction Spawn Map](https://ark.wiki.gg/wiki/Spawn_Map_(Extinction))
- [Genesis Part 1 Spawn Map](https://ark.wiki.gg/wiki/Spawn_Map_(Genesis:_Part_1))
- [Genesis Part 2 Spawn Map](https://ark.wiki.gg/wiki/Spawn_Map_(Genesis:_Part_2))
- [The Center Spawn Map](https://ark.wiki.gg/wiki/Spawn_Map_(The_Center))
- [Ragnarok Spawn Map](https://ark.wiki.gg/wiki/Spawn_Map_(Ragnarok))
- [Valguero Spawn Map](https://ark.wiki.gg/wiki/Spawn_Map_(Valguero))
- [Crystal Isles Spawn Map](https://ark.wiki.gg/wiki/Spawn_Map_(Crystal_Isles))
- [Lost Island Spawn Map](https://ark.wiki.gg/wiki/Spawn_Map_(Lost_Island))

By using creatures that you know spawn in an area, the spawn maps can help figure out which spawn point to choose. For example, if you were trying to add wolves to the lighthouse area of Ragnarok, you could check the Ragnarok spawn map for ovis. This will show you `SE_Oasis`, `Snow`, `Grassland`, and `Ragnarok_Scotland`. Using the checkboxes above the map, spawn points can be turned off until we can figure out which is the one for the lighthouse area. In this case, we're looking for `Ragnarok_Scotland`.

**Pay attention to the rectangles on the spawn map.** Each of these rectangles represents a single spawn point instance. Each instance has its own population limits. This means if you were to add a major creature such as Magmasaur to a spawn point with a lot of rectangles, such as the `SE_Dunes` point, even with a limit to allow only 1 there could be up to 113 Magmasaurs in the desert. **For this reason, you are advised to keep similar creatures together.**

Armed with this `Ragnarok_Scotland` spawn point, the next step is to find that in Beacon. The wiki, Ark, and Beacon each use their own naming system since spawn points don't officially have names. The wiki's names are based on the spawn point's class string, which Beacon will search. Sometimes it is necessary to drop the first part of the wiki's name, such as `SE` in the case of the Scorched Earth spawn points. In this instance, searching for `Ragnarok_Scotland` shows the "Lighthouse" point in Beacon. That's the one we're looking for.

{% include image.html file="scotland.png" file2x="scotland@2x.png" caption="The Ragnarok_Scotland point from the wiki is the Lighthouse point in Beacon." %}

Another option is to set the search field to _Creatures_ instead and search for the creature you're looking for. This will give you the same results as the wiki's spawn maps, but without the visuals of course.

{% include image.html file="ovis.png" file2x="ovis@2x.png" caption="Searching for spawn points based on creature." %}

{% include affectedkeys.html %}