---
title: Creature Spawns
parent: Config Editors
configkeys:
  - ConfigAddNPCSpawnEntriesContainer
  - ConfigOverrideNPCSpawnEntriesContainer
  - ConfigSubtractNPCSpawnEntriesContainer
supportedgames:
  - "Ark: Survival Evolved"
---
{% include editortitle.markdown %}

Ark server admins are given great control over the game's spawn system. Admins can add creatures/dinos to certain parts of the map, remove creatures, increase levels, and even change colors. This powerful editor requires great care though, as it's easy to create an overspawning problem.

{% include omninotice.markdown %}

## Add a Spawn Point

Just like editing loot drops in Beacon, spawn points must be added to a file before anything will change on the server. Spawn points not added to Beacon will be left as default.

Press the **New Point**{:.ui-keyword} button to begin adding a spawn point.

{% include image.html file="addspawndialog.png" file2x="addspawndialog@2x.png" caption="The &quot;Add Spawn Point&quot; dialog." %}

The **Filter**{:.ui-keyword} field at the top allows searching the spawn points. To the right of the **Filter**{:.ui-keyword} field is a switch that allows searching by spawn point or by creature. When set to **Creatures**{:.ui-keyword}, type the name of a creature and Beacon will show all the spawn points that include the creature.

{:.tip .titled}
> Tip
> 
> Users can select multiple spawn points to be added at the same time. Hold shift while selecting points to select a range. Windows users can use Control while clicking to select non-sequential spawn points, and Control-A will select all. Mac users should substitute the Command/Apple key for Control.

The next step is to select a **Mode**{:.ui-keyword} value. **Replace Default Spawns**{:.ui-keyword} will replace all creatures in the spawn point with the ones specified in Beacon. When this option is selected, the **Load Simplified Default Spawns**{:.ui-keyword} checkbox will add the spawn point with default spawn data loaded in. The **Add to Default Spawns**{:.ui-keyword} mode allows adding new creatures without affecting the current creatures. And **Remove from Default Spawns**{:.ui-keyword} allows removing one or more creatures without affecting the other creatures.

## Adding Shinehorns to Beaches

In this tutorial, the goal is to add Shinehorns to the beaches on The Island. Press the **New Point**{:.ui-keyword} button, select **Beaches**{:.ui-keyword} in the list, and set the **Mode**{:.ui-keyword} to **Add to Default Spawns**{:.ui-keyword}.

{% include image.html file="addtobeaches.png" file2x="addtobeaches@2x.png" caption="Adding creatures to the &quot;Beaches&quot; spawn point." %}

Press **OK**{:.ui-keyword} when ready. Next, add a new spawn set by pressing the **New Set**{:.ui-keyword} button in the **Spawn Sets**{:.ui-keyword} column. This will create and select a new spawn set. Use the **Name**{:.ui-keyword} field to call the spawn set Shinehorns. The **Weight**{:.ui-keyword} field in the upper right works exactly the same as every other weight value in Ark. Ark's default weight values are always less than or equal to 1.0, so Beacon defaults the weight to 0.5. The **Beaches**{:.ui-keyword} spawn point often uses much lower values, so to prevent being overrun by Shinehorns, set the **Weight**{:.ui-keyword} field to 0.06.

{:.tip .titled}
> Tip
> 
> Create a new Beacon project, switch to **Creature Spawns**{:.ui-keyword}, and add the same spawn point in **Replace Default Spawns**{:.ui-keyword} mode with **Load Simplified Default Spawns**{:.ui-keyword} selected. Then look through the weights of each default spawn set to help decide on an appropriate weight value.

Next, press the **Add**{:.ui-keyword} button in the **Creatures**{:.ui-keyword} box. In the **Creature Entry**{:.ui-keyword} dialog, press the **Choose…**{:.ui-keyword} button next to **Creature**{:.ui-keyword} and select Shinehorn. Leave all the other fields empty, they are not needed in this step.

Ark spawns creatures in packs. Every row in the **Creatures**{:.ui-keyword} list represents one member of the pack. This is how the game always spawns Carnos with a Yuty.

{% include image.html file="shinehorn.png" file2x="shinehorn@2x.png" caption="A completed Shinehorn Spawn Set." %}

To save time, consider using the **Auto Creature**{:.ui-keyword} tool in the **Spawn Sets**{:.ui-keyword} column. This will create a new spawn set with common values, as well as choosing a pack size. Beacon will choose spawn set weights to best fit with the existing spawn sets.

Lastly, it is important to limit the number of Shinehorns that will spawn in the area. Press the **New Limit**{:.ui-keyword} button in the **Limits**{:.ui-keyword} section to define a new limit. From the **Creature**{:.ui-keyword} menu, select Shinehorn and set the **Max Percentage**{:.ui-keyword} to 5. This will limit the number of Shinehorns in each of the spawn point nodes to 5% of the spawn point node's total population. 

### Understanding Limits

The limits work by counting the number of the limited creature that is already at the spawn point node, and preventing a new spawn if that number is already over the limit. So, for example, setting the limit to 0.0001% does not mean the creature will not spawn. When there are 0 at the point the creature can still spawn because `0 ÷ 40 = 0` is below 0.0001. As soon as 1 spawns, the limit is reached because `1 ÷ 40 = 0.025` is greater than the limit of 0.0001.

{:.info .titled}
> Spawn Point Nodes and Population Limits
> 
> A spawn point isn't any one point. Similar to the same loot drop being able to appear at multiple locations on the map, spawn points are also placed on the map one or more times. Every time a spawn point is placed on the map, we call that a spawn node. For example, The Island has 76 nodes for Beaches. Population limits apply to each node, not to the total population. This means certain designs may not possible depending on the spawn point. An example might be trying to add a single Giga to the beaches. Even with a super low limit of 0.000001%, this allows at most 1 to spawn **at each of the map's 76 nodes**. So rather than 1 giga on the beaches, you would wind up with 76 gigas on the beaches.
> 
> For this reason it is **strongly** recommended to keep "like" creatures together. Major creatures often have their own dedicated spawn points because they come with smaller populations and have fewer nodes per map. Adding Magmasaurs to the Gigas spawn point works much better than adding Magmasaurs to the Jungles spawn point.

## The Other Settings

### Creature Settings

- **Offset (X, Y, Z)**{:.ui-keyword}: Allows moving the creature away from the spawn set offset in three dimensional space, measured in centimeters. Y is the North/South axis, X is the East/West axis, and Z is the height/depth axis. 0, 0 is the South West corner of the map.
- **Override Range**{:.ui-keyword}: Can choose a specific range of levels for the creature to spawn. This could be used to make certain pack members higher level than others. **If you change difficulty, the range will change too.**
- **Level Offset**{:.ui-keyword}: Instead of choosing a specific range for the creature, additional levels can be added or removed.
- **Level Multiplier**{:.ui-keyword}: In addition to a fixed number of levels to add or remove, levels can be multiplied.

### Spawn Set Settings

- **Offset (X, Y, Z)**{:.ui-keyword}: Allows moving the spawn set away from the spawn point node in a three dimensional space, measured in centimeters.
- **Distance from x Multiplier**{:.ui-keyword}: These three settings allow users to increase or decrease the distance the creature must be from players, structures, or tames before the creature can spawn. Values greater than 1.0 will require more space, values less than 1.0 will require less space.
- **Spread Radius**{:.ui-keyword}: Introduces a random amount of distance away from the spawn point node's center + set offset to make spawns feel more natural. Value is in centimeters.
- **(Water Only) Min Height**{:.ui-keyword}: For water spawns, this is the depth the spawn set needs to spawn. This is to prevent sharks from spawning in puddles, for example. 140 is a common value, larger creatures should use 520.
- **Colors**{:.ui-keyword}: The creatures in the spawn set can spawn with different colors than normal. Not all color sets are noticeable on all creatures, and some creatures such as the X variants will not show colors at all. See [this Reddit discussion](https://www.reddit.com/r/playark/comments/mavua0/adding_different_colored_dinos_to_spawns/) for additional details.
- **Add Level Offset Before Multiplier**{:.ui-keyword}: This option will change how the level calculations are performed. When selected, the **Level Offset**{:.ui-keyword} will be added to the creature's level first, then the **Level Multiplier**{:.ui-keyword} applied. When not selected, the **Level Multiplier**{:.ui-keyword} is applied first, then the **Level Offset**{:.ui-keyword} is added. These values are described in the next paragraph.

The **Level Range**{:.ui-keyword}, **Level Offset**{:.ui-keyword}, and **Level Multipliers**{:.ui-keyword} allow changing the level that creatures will spawn. Ark uses this for cave spawns, for example. Use **Level Range**{:.ui-keyword} to specify a range for the creature. The levels will automatically scale if the server difficulty is changed. **Level Offset**{:.ui-keyword} is a fixed number of levels to add or remove. **Level Multiplier**{:.ui-keyword} will multiply the creature's level. A value of 2 would turn a 120 creature into a 240 creature, for example.

## Creature Replacements

A spawn set can exchange creatures for other creatures. This could be used to give some variety to a pack. For example, this feature could be used to add a small chance to replace a Carno in a Yuty pack with a Rex. The creature to be replaced **must** exist in the **Creatures**{:.ui-keyword} list.

{:.tip .titled}
> Tip
> 
> Most spawn sets have no use for this feature. The maps control creature variant substitutions, so adding alphas, aberrants, or other variants will not work.

1. Start by pressing the **Add**{:.ui-keyword} button in the **Creature Replacement**{:.ui-keyword} list.
2. Choose Carno for the **Target Creature**{:.ui-keyword}.
3. Press **Add Creature…**{:.ui-keyword} and select both Carno and Rex. Press **Select**{:.ui-keyword} to add both to the list.
4. Set replacement weights so that Rex only has a 5% chance to spawn in place of Carno. This can be achieve with weight 95 for Carno and 5 for Rex.

{% include image.html file="replacements.png" file2x="replacements@2x.png" caption="Adding Alpha Raptor where Raptors could spawn." %}

## Removing Creatures

When removing creatures from a spawn point, most options are not useful at all. Use a **Spawn Set**{:.ui-keyword} and list the creatures that should be removed in the **Creatures**{:.ui-keyword} list.

## Choosing a Spawn Point

Figuring out which spawn point to use can take practice, so here are some tips the community has learned.

The Ark wiki has spawn maps available to help visualize each point.
- [The Island Spawn Map](https://ark.wiki.gg/wiki/Spawn_Map/The_Island)
- [Scorched Earth Spawn Map](https://ark.wiki.gg/wiki/Spawn_Map/Scorched_Earth)
- [Aberration Spawn Map](https://ark.wiki.gg/wiki/Spawn_Map/Aberration)
- [Extinction Spawn Map](https://ark.wiki.gg/wiki/Spawn_Map/Extinction)
- [Genesis Part 1 Spawn Map](https://ark.wiki.gg/wiki/Spawn_Map/Genesis:_Part_1)
- [Genesis Part 2 Spawn Map](https://ark.wiki.gg/wiki/Spawn_Map/Genesis:_Part_2)
- [The Center Spawn Map](https://ark.wiki.gg/wiki/Spawn_Map/The_Center)
- [Ragnarok Spawn Map](https://ark.wiki.gg/wiki/Spawn_Map/Ragnarok)
- [Valguero Spawn Map](https://ark.wiki.gg/wiki/Spawn_Map/Valguero)
- [Crystal Isles Spawn Map](https://ark.wiki.gg/wiki/Spawn_Map/Crystal_Isles)
- [Lost Island Spawn Map](https://ark.wiki.gg/wiki/Spawn_Map/Lost_Island)
- [Fjordur Spawn Map](https://ark.wiki.gg/wiki/Spawn_Map/Fjordur)

By using creatures that you know spawn in an area, the spawn maps can help figure out which spawn point to choose. For example, if you were trying to add wolves to the lighthouse area of Ragnarok, you could check the Ragnarok spawn map for ovis. This will show you `SE_Oasis`, `Snow`, `Grassland`, and `Ragnarok_Scotland`. Using the checkboxes above the map, spawn points can be turned off until we can figure out which is the one for the lighthouse area. In this case, we're looking for `Ragnarok_Scotland`.

**Pay attention to the rectangles on the spawn map.** Each of these rectangles represents a single spawn point node. Each node has its own population limits. See [Understanding Limits](#understanding-limits) for more details.

Armed with this `Ragnarok_Scotland` spawn point, the next step is to find that in Beacon. The wiki, Ark, and Beacon each use their own naming system since spawn points don't officially have names. The wiki's names are based on the spawn point's class string, which Beacon will search. Sometimes it is necessary to drop the first part of the wiki's name, such as `SE` in the case of the Scorched Earth spawn points. In this case, searching for `Ragnarok_Scotland` shows the "Lighthouse" point in Beacon. That's the one we're looking for.

{% include image.html file="scotland.png" file2x="scotland@2x.png" caption="The Ragnarok_Scotland point from the wiki is the Lighthouse point in Beacon." %}

Another option is to set the search field to _Creatures_ instead and search for the creature you're looking for. This will give you the same results as the wiki's spawn maps, but without the visuals of course.

{% include image.html file="ovis.png" file2x="ovis@2x.png" caption="Searching for spawn points based on creature." %}

{% include affectedkeys.html %}
