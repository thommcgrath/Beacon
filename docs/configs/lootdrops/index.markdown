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

In Ark, anything not edited remains default, so Beacon works the same way. The **Loot Drops**{:.ui-keyword} column starts out empty because no changes have been made to the loot drops.

Press the **New Drop**{:.ui-keyword} button in the **Loot Drops**{:.ui-keyword} column to open the **Add Loot Drop**{:.ui-keyword} wizard. Or hold the button to show a menu and add a loot drop quickly.

The **Add Loot Drop**{:.ui-keyword} wizard shows you any and all loot drops available to the selected map or maps. This means if you see a drop in the list, a selected map uses it in some way.

At the bottom of the **Add Loot Drop**{:.ui-keyword} window there are two additional options:
- **Load Default Contents When Available**{:.ui-keyword}: This option will add the drop setup exactly as if they were not changed at all. This is a great starting to point to making minor changes to loot, or learn about how the drops are originally designed. This option works with nearly all loot drops, but Genesis loot crates and mod drops may not have any defaults. When this option is checked, the next step is skipped.
- **Show Experimental Loot Drops**{:.ui-keyword}: Shows many additional drops that Ark does not officially support editing. Some have unusual requirements or do not work like normal drops. Fishing, quakes, and orbital drops are the most notable "unusual" drops.

Select one or more loot drops and press **Next**{:.ui-keyword}/**Done**{:.ui-keyword} or double-click a loot drop. If default contents have not been loaded, the **Customize Loot Drop**{:.ui-keyword} page will be shown with the following options:
- **Min Item Sets**{:.ui-keyword} and **Max Item Sets**{:.ui-keyword}: A loot drop contains one or more item sets. The **Min Item Sets**{:.ui-keyword} and **Max Item Sets**{:.ui-keyword} fields are used to determine how many of the item sets to select when the game generates loot.
- **Prevent Duplicates**{:.ui-keyword}: When checked, Ark can only select an item set once. This does not affect the contents of each set. So if there is a metal sword in two sets for example, it would still be possible for two metal swords to be included.

  When not checked, Ark can select the same item set multiple times until the chosen number of item sets is fulfilled. For example, setting both **Min Item Sets**{:.ui-keyword} and **Max Item Sets**{:.ui-keyword} to ten and including only one item set in the loot source will cause that same item set to be selected ten times.

- **Templates**{:.ui-keyword}: Templates are a set of instructions to build an item set. Checking templates in the list will include the item sets when finished. Templates can be added to a loot source later too. Read more about templates in [Using Templates to Automate Item Set Creation](/core/templates/).

### Additional Settings
After pressing **Done**{:.ui-keyword} to add your loot drop(s) they will be selected in the **Loot Drops**{:.ui-keyword} column. In the middle column labeled **Item Sets**{:.ui-keyword} there is a **Settings**{:.ui-keyword} section. Click the little arrows on the left to expand the settings. The **Add Item Sets to Default**{:.ui-keyword} setting, when checked, adds the source's item sets to the default loot pool instead of replacing them. This setting is tricky to master though, and your item sets will need to use weight values that play nicely with the default weights, which are always between 0 and 1. **It is strongly recommended to load the default contents and edit them instead of using this option**.

## Item Sets

Item sets have very similar settings and behaviors as loot drops. An item set is made up of one or more item set entries, or just entries for short. Each item set has **Min Entries**{:.ui-keyword}, **Max Entries**{:.ui-keyword}, and **Prevent Duplicates**{:.ui-keyword} settings that behave exactly the same as a loot drop.

Press the **New Item Set**{:.ui-keyword} button in the **Item Sets**{:.ui-keyword} column to add an empty item set. Hold the button to show a menu to add an item set based on one of your templates. The new item set will be selected.

The **Item Set Entries**{:.ui-keyword} column has a **Settings**{:.ui-keyword} section just like the **Item Sets**{:.ui-keyword} column.

### Item Set Weight

The **Weight**{:.ui-keyword} field is used to influence Ark's loot selection. The chance of an item set being selected is computed as `Weight / SUM(All Weights in Drop)`. What this means is two item sets with the same weight will have the same chance of selection. The weight values of each could be 1, 10, 100, or 1000 and the outcome would be the same. If "Item Set A" has a weight of 100, and "Item Set B" has a weight of 100, the formula for "Item Set A" would be `100 / (100 + 100)` or `0.5` or `50%`. If the weight of "Item Set A" changes to 150, the formula for "Item Set A" becomes `150 / (150 + 100)` or `0.6` or `60%`. The formula for "Item Set B" would become `100 / (150 + 100)` or `0.4` or `40%`.

This means it is mathematically impossible to guarantee one item set is always chosen unless the **Min Item Sets**{:.ui-keyword} is equal to the number of item sets in the loot drop. However, the weights of three item sets could be set to 1, and a fourth set to 1,000,000 and that would effectively guarantee the fourth set would always be selected.

## Item Set Contents

Finally, the meat of the loot drops. Press the **New Entry**{:.ui-keyword} button in the **Item Set Entries**{:.ui-keyword} column to begin adding something to the item set.

In the **Possible Items**{:.ui-keyword} group you can search for items and click the checkbox next to items you'd like to add. Each checked item has a value in the **Weight**{:.ui-keyword} column that works exactly like the item set weight. At the top of the group is a search field for quickly finding items, and below that is the tag picker. {% include tags.markdown %}

Enter "Shotgun" into the search field in **Possible Items**{:.ui-keyword} and press the checkbox next to "Simple Shotgun Ammo". Set both **Min Quantity**{:.ui-keyword} and **Max Quantity**{:.ui-keyword} to 100 so this row will always contain a full stack of shotgun shells. Quality does not matter for ammo. Set **Chance To Be Blueprint**{:.ui-keyword} to 0%, and **Weight**{:.ui-keyword} to 10000. You'll see why in a moment. Press **OK**{:.ui-keyword} to add the row.

Now, our goal is to add both a Shotgun and a Pump-Action Shotgun to the drop, but only one should be included at a time. There are two ways to accomplish this.

### Method 1
Press the add button again and filter to "Shotgun" like before. Then check both Shotgun and Pump-Action Shotgun. Set quantities to 1, qualities to Primitive, blueprint chance to 0%, and weight to 1. Press **OK**{:.ui-keyword} and one row for each item will be added to the list.

Expand the **Settings**{:.ui-keyword} group in the **Item Set Entries**{:.ui-keyword} column and set both **Min Entries**{:.ui-keyword} and **Max Entries**{:.ui-keyword} to 2. Make sure **Prevent Duplicates**{:.ui-keyword} is checked.

![ShotgunMethod1](2dd3575c-8a6e-4425-a650-4257f4ee7fdc)

Because the shotgun shells have a weight of 10,000 and the shotguns have a weight of 1, the shells will be selected for the first entry nearly every time. Since **Prevent Duplicates**{:.ui-keyword} is turned on, the row cannot be selected twice. So the second selected entry will be either the Shotgun or Pump-Action Shotgun entries. They will have equal chances of selection because they have equal weights.

Press the **Simulator**{:.ui-keyword} button in the **Item Sets**{:.ui-keyword} column to open the simulator. The simulator will show you an example of the contents you could find when opening the loot source. Press the **Reroll**{:.ui-keyword} button to re-run the simulation, and press the **Simulator**{:.ui-keyword} button again if you'd like to close it.

### Method 2
While the first method works perfectly fine, it can become complicated using weights when there are more items in the set. Luckily, Ark gives us another option. First, delete the Shotgun and Pump-Action Shotgun rows from the **Item Set Entries**{:.ui-keyword} column. Press the **New Entry**{:.ui-keyword} button again and just like before select both shotguns, and reduce their blueprint chance to 0%. This time though, the weight does not matter, and you will need to click the **Merge selections into one entry**{:.ui-keyword} at the bottom of the **Possible Items**{:.ui-keyword} list. When you press **OK**{:.ui-keyword}, Beacon will add only one row to the list.

![ShotgunMethod2](e671e7db-01e3-48ab-ad46-c5da000c14ea)

When setup this way, we can be 100% certain that each entry will be selected only once because we have still have **Min Entries**{:.ui-keyword} and **Max Entries**{:.ui-keyword} set to 2, and **Prevent Duplicates**{:.ui-keyword} turned on. But when the Pump-Action Shotgun or Shotgun entry is selected, Ark will choose one of the two items instead.

Check the simulator again, and the behavior should be the same as before: a pump action shotgun or shotgun with 100 shells.

### More Entry Settings

There are some additional features in the item set entries to be aware of.
- **Choose only one item**{:.ui-keyword}: When **Merge selections into one entry**{:.ui-keyword} is turned on, Ark will normally re-run loot selection of every unit of quantity. For example, if the minimum and maximum quantity are both set to 100 and the entry contains both arrows and tranq arrows, the 100 arrows will be split depending on weight. With equal weight, that would be roughly 50 of each arrow. For large quantities, this is very taxing on the server and will cause lag as loot drops spawn. Turning on the **Choose only one item**{:.ui-keyword} option will have Ark choose an item first, then give the full quantity to that item. Beacon automatically uses this setting when there is only one item in an item set entry.
- **Stat Limits Multiplier**{:.ui-keyword}: If [Item Stat Limits](/configs/statlimits/) are enabled for the server, the limits for loot selected by this entry can be tuned. Values over 1.0 will increase the limit, while values under 1.0 will decrease the limit.
- **Prevent Grinding**{:.ui-keyword}: Turning this option on will generate loot that can not be fed to the industrial grinder.

## More Tips

It's not uncommon to want one loot source setup just like another. Beacon has a few ways to help with that.

First, the **Duplicate**{:.ui-keyword} button in the **Loot Drops**{:.ui-keyword} list allows you to copy one loot source into one or more loot drops. In the **Add Loot Drop**{:.ui-keyword} wizard that appears, you can shift-click drops to select a range. Or use ctrl/command-click to select non-sequential drops.

Second, using the same clicking techniques, you can select multiple loot drops and edit them at the same time. You'll only see item sets that are identical between all selected loot drops though. You can also select multiple item sets.

Third, Beacon supports copy and paste. So you can copy loot drops between documents, or item sets between loot sources. You can even copy a loot drop and paste its config line directly into your ini if you like.

{% include affectedkeys.html %}