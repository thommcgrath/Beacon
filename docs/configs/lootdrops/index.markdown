---
title: Loot Drops
parent: Config Editors
configkeys:
  - ConfigOverrideSupplyCrateItems
---
{% include editortitle.markdown %}

Ark server admins have great control over the items players can found in their server's loot drops, beaver dams, bosses, and creature inventories. This guide will help admins understand the large number of settings and how they all work together.

> Designing loot drops is a complex topic. See the [Welcome to Beacon](/videos/welcome_to_beacon) video for a more visual explanation of the topic.

## Loot Drops

In Ark, anything not edited remains default, so Beacon works the same way. The _Loot Drops_ column starts out empty because no changes have been made to the loot drops.

Press the _New Drop_ button in the _Loot Drops_ column to open the _Add Loot Drop_ wizard. Or hold the button to show a menu and add a loot drop quickly.

The _Add Loot Drop_ wizard shows you any and all loot drops available to the selected map or maps. This means if you see a drop in the list, a selected map uses it in some way. Select one or more loot drops and press _Next_ or double-click a loot drop.

### Minimum and Maximum Item Sets
A loot drop contains one or more item sets. The _Min Item Sets_ and _Max Item Sets_ fields are used to determine how many of the item sets to select when the game generates loot.

### Prevent Duplicates
When checked, Ark can only select an item set once. This does not affect the contents of each set. So if there is a metal sword in two sets for example, it would still be possible for two metal swords to be included.

When not checked, Ark can select the same item set multiple times until the chosen number of item sets is fulfilled. For example, setting both _Min Item Sets_ and _Max Item Sets_ to ten and including only one item set in the loot source will cause that same item set to be selected ten times.

### Templates
Templates are a set of instructions to build an item set. Checking templates in the list will include the item sets when finished. Templates can be added to a loot source later too. Read more about templates in [Using Templates to Automate Item Set Creation](/core/templates/).

### Additional Settings
After pressing _Done_ to add your loot drop(s) they will be selected in the _Loot Drops_ column. In the middle column labeled _Item Sets_ there is a _Settings_ section. Click the little arrows on the left to expand the settings. The _Add Item Sets to Default_ setting, when checked, adds the source's item sets to the default loot pool instead of replacing them. This setting is tricky to master though, and your item sets will need to use weight values that play nicely with the default weights, which are always between 0 and 1.

## Item Sets

Item sets have very similar settings and behaviors as loot drops. An item set is made up of one or more item set entries, or just entries for short. Each item set has _Min Entries_, _Max Entries_, and _Prevent Duplicates_ settings that behave exactly the same as a loot drop.

Press the _New Item Set_ button in the _Item Sets_ column to add an empty item set. Hold the button to show a menu to add an item set based on one of your presets. The new item set will be selected.

The _Item Set Entries_ column has a _Settings_ section just like the _Item Sets_ column.

### Item Set Weight

The _Weight_ field is used to influence Ark's loot selection. The chance of an item set being selected is computed as `Weight / SUM(All Weights in Drop)`. What this means is two item sets with the same weight will have the same chance of selection. The weight values of each could be 1, 10, 100, or 1000 and the outcome would be the same. If _Item Set 1_ has a weight of 100, and _Item Set 2_ has a weight of 100, the formula for _Item Set 1_ would be `100 / (100 + 100)` or `0.5` or `50%`. If _Item Set 1_'s weight changes to 150, the formula for _Item Set 1_ becomes `150 / (150 + 100)` or `0.6` or `60%`. The formula for _Item Set 2_ would become `100 / (150 + 100)` or `0.4` or `40%`.

This means it is mathematically impossible to guarantee one item set is always chosen unless the _Min Item Sets_ is equal to the number of item sets in the loot source. However, the weights of three item sets could be set to 1, and a fourth set to 1,000,000 and that would effectively guarantee the fourth set would always be selected.

## Item Set Contents

Finally, the meat of the loot drops. Press the _New Entry_ button in the _Item Set Entries_ column to begin adding something to the item set.

In the _Possible Items_ group you can search for items and click the checkbox next to items you'd like to add. Each checked item has a value in the _Weight_ column that works exactly like the item set weight. At the top of the group is a search field for quickly finding items, and below that is the tag picker. Tags can be clicked to change how the list is filtered. Gray tags are neutral and have no effect on the filtering. Blue tags are required, which means the list will only show items that have all of the blue tags. Red tags are excluded, which means the list will hide items that have any of the red tags.

Enter "Shotgun" into the field in _Possible Items_ and press the checkbox next to _Simple Shotgun Ammo_. Set both _Min Quantity_ and _Max Quantity_ to 100 so this row will always contain a full stack of shotgun shells. Quality does not matter for ammo. Set _Chance To Be Blueprint_ to 0%, and _Weight_ to 10000. You'll see why in a moment. Press _OK_ to add the row.

> These settings are applied for each quantity of an item. So if _Chance To Be Blueprint_ were set to 25% for example, you would get roughly 25 shell blueprints and 75 shells.

Now, our goal is to add both a _Shotgun_ and a _Pump-Action Shotgun_ to the drop, but only one should be included at a time. There are two ways to accomplish this.

### Method 1
Press the add button again and filter to "Shotgun" like before. Then check both _Shotgun_ and _Pump-Action Shotgun_. Set quantities to 1, qualities to _Primitive_, blueprint chance to 0%, and weight to 1. Press _OK_ and one row for each item will be added to the list.

Expand the _Settings_ group in the _Item Set Entries_ column and set both _Min Entries_ and _Max Entries_ to 2. Make sure _Prevent Duplicates_ is checked.

![ShotgunMethod1](2dd3575c-8a6e-4425-a650-4257f4ee7fdc)

Because the shotgun shells have a weight of 10,000 and the shotguns have a weight of 1, the shells will be selected for the first entry nearly every time. Since _Prevent Duplicates_ is true, the row cannot be selected twice. So the second selected entry will be either the _Shotgun_ or _Pump-Action Shotgun_ entries. They will have equal chances of selection because they have equal weights.

Press the _Simulator_ button in the _Item Sets_ column to open the simulator. The simulator will show you an example of the contents you could find when opening the loot source. Press the _Reroll_ button to re-run the simulation, and press the _Simulator_ button again if you'd like to close it.

### Method 2
While the first method works perfectly fine, it can become complicated using weights when there are more items in the set. Luckily, Ark gives us another option. First, delete the _Shotgun_ and _Pump-Action Shotgun_ rows from the _Item Set Entries_ column. Press the _New Entry_ button again and just like before select both shotguns, and reduce their blueprint chance to 0%. This time though, the weight does not matter, and you will need to click the _Merge selections into one entry_ at the bottom of the _Possible Items_ list. When you press _OK_, Beacon will add only one row to the list.

![ShotgunMethod2](e671e7db-01e3-48ab-ad46-c5da000c14ea)

When setup this way, we can be 100% certain that each entry will be selected only once because we have still have _Min Entries_ and _Max Entries_ set to 2, and _Prevent Duplicates_ turned on. But when the _Pump-Action Shotgun or Shotgun_ entry is selected, Ark will choose one of the two items instead.

Check the simulator again, and the behavior should be the same as before: a pump action shotgun or shotgun with 100 shells.

## More Tips

It's not uncommon to want one loot source setup just like another. Beacon has a few ways to help with that.

First, the _Duplicate_ button in the _Loot Drops_ list allows you to copy one loot source into one or more loot drops. In the _Add Loot Drop_ wizard that appears, you can shift-click drops to select a range. Or use ctrl/command-click to select non-sequential drops.

Second, using the same clicking techniques, you can select multiple loot drops and edit them at the same time. You'll only see item sets that are identical between all selected loot drops though. You can also select multiple item sets.

Third, Beacon supports copy and paste. So you can copy loot drops between documents, or item sets between loot sources. You can even copy a loot drop and paste its config line directly into your ini if you like.

{% include affectedkeys.html %}