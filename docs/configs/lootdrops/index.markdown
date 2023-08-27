---
title: Loot Drops
parent: Config Editors
configkeys:
  - ConfigOverrideSupplyCrateItems
supportedgames:
  - "Ark: Survival Evolved"
---
{% include editortitle.markdown %}

Ark server admins have a great deal of control over the items players can find in their server's loot drops, beaver dams, bosses, and creature inventories. This guide will help admins understand the large number of settings and how they all work together.

> Loot drop design is a complex topic. See the [Welcome to Beacon](/videos/welcome_to_beacon) video for a more visual explanation of the topic.

## Loot Drops

In Ark, anything unedited remains default, so Beacon works the same way. The **Loot Drops**{:.ui-keyword} column starts out empty because no changes have been made to the loot drops.

Press the **New Drop**{:.ui-keyword} button in the **Loot Drops**{:.ui-keyword} column to open the **Add Loot Drop**{:.ui-keyword} wizard. Or hold the button down to display a menu and quickly add a loot drop.

The **Add Loot Drop**{:.ui-keyword} wizard shows you all the loot drops available for the selected map(s). This means that if you see a drop in the list, a selected map uses it in some way.

There are two additional options at the bottom of the **Add Loot Drop**{:.ui-keyword} window:
- **Load Default Contents When Available**{:.ui-keyword}: This option will add the drop setup exactly as if it had not been changed at all. This is a good place to start if you want to make minor changes to loot, or learn how the drops were originally designed. This option works with almost all loot drops, but Genesis loot crates and mod drops may not have defaults. Checking this option will skip the next step.
- **Show Experimental Loot Drops**{:.ui-keyword}: Shows many additional drops that Ark does not officially support editing. Some have unusual requirements or do not work like normal drops. Fishing, quakes, and orbital drops are the most notable "unusual" drops.

Select one or more loot drops and press **Next**{:.ui keyword}/**Done**{:.ui keyword} or double-click a loot drop. If the **Load Default Contents When Available**{:.ui-keyword} option is unchecked, the **Customize Loot Drop**{:.ui-keyword} page will be displayed with the following options:
- **Min Item Sets**{:.ui-keyword} and Max Item Sets**{:.ui-keyword}: A loot drop will contain one or more item sets. The **Min Item Sets**{:.ui-keyword} and **Max Item Sets**{:.ui-keyword} fields are used to determine how many of the item sets to select when the game generates loot.
- **Prevent Duplicates**{:.ui-keyword}: When checked, Ark can only select an item set once. This does not affect the contents of each set. For example, if two sets contain a metal sword, it is still possible for two metal swords to be included.
  
  If this option is unchecked, Ark will be able to select the same item set multiple times until the number of item sets is reached. For example, if both **Min Item Sets**{:.ui-keyword} and **Max Item Sets**{:.ui-keyword} are set to ten and only one item set is included in the loot drop, the same item set will be selected ten times.

- **Templates**{:.ui-keyword}: Templates are a set of instructions to build an item set. Checking templates in the list will include the item sets when finished. Templates can also be added to a loot drop later. Read more about templates in [Using Templates to Automate Item Set Creation](/core/templates/).

### Additional Settings
After pressing **Done**{:.ui keyword} to add your loot drop(s), they will be selected in the **Loot Drops**{:.ui keyword} column. In the middle column labeled **Item Sets**{:.ui-keyword} there is a **Settings**{:.ui-keyword} section. The **Add Item Sets to Default**{:.ui-keyword} setting, when checked, will add the drop's item sets to the default loot pool instead of replacing them. This setting is tricky to master, however, and your item sets must use weight values that play nicely with the default weights, which are always between 0 and 1. **It is strongly recommended that you load and edit the default content instead of using this option**.

## Item Sets

Item sets have very similar settings and behavior to loot drops. An item set consists of one or more item set entries, or just entries for short. Each item set has **Min Entries**{:.ui keyword}, **Max Entries**{:.ui keyword}, and **Prevent Duplicates**{:.ui keyword} settings that behave exactly like a loot drop.

Press the **New Item Set**{:.ui keyword} button in the **Item Sets**{:.ui keyword} column to add an empty item set. Hold down the button to display a menu to add an item set based on one of your templates. The new item set is selected.

The **Item Set Entries**{:.ui keyword} column has a **Settings**{:.ui keyword} section, just like the **Item Sets**{:.ui keyword} column.

### Item Set Weight

The **Weight**{:.ui-keyword} field is used to influence Ark's loot selection. The chance of an item set being selected is calculated as `Weight / SUM(All weights in drop)`. This means that two item sets with the same weight have the same chance of being selected. The weight values of each could be `1`, `10`, `100`, or `1,000` and the result would be the same. If Item Set A has a weight of 100 and Item Set B has a weight of `100`, the formula for Item Set A would be `100 / (100 + 100)` or `0.5` or `50%`. If the weight of "Item Set A" changes to `150`, the formula for "Item Set A" will be `150 / (150 + 100)` or `0.6` or `60%`. The formula for Item Set B would become `100 / (150 + 100)` or `0.4` or `40%`.

This means that it is mathematically impossible to guarantee that one item set will always be chosen unless the **Min Item Sets**{:.ui-keyword} is equal to the number of item sets in the loot drop. However, you could set the weights of three item sets to `1` and a fourth set to `1,000,000`, effectively guaranteeing that the fourth set will always be selected.

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

Press the **Simulator**{:.ui-keyword} button in the **Item Sets**{:.ui-keyword} column to open the simulator. The simulator will show you an example of the contents you could find when opening the loot drop. Press the **Reroll**{:.ui-keyword} button to re-run the simulation, and press the **Simulator**{:.ui-keyword} button again if you'd like to close it.

### Method 2
While the first method works perfectly fine, it can become complicated using weights when there are more items in the set. Luckily, Ark gives us another option. First, delete the Shotgun and Pump-Action Shotgun rows from the **Item Set Entries**{:.ui-keyword} column. Press the **New Entry**{:.ui-keyword} button again and just like before select both shotguns, and reduce their blueprint chance to 0%. This time though, the weight does not matter, and you will need to click the **Merge selections into one entry**{:.ui-keyword} at the bottom of the **Possible Items**{:.ui-keyword} list. When you press **OK**{:.ui-keyword}, Beacon will add only one row to the list.

![ShotgunMethod2](e671e7db-01e3-48ab-ad46-c5da000c14ea)

When setup this way, we can be 100% certain that each entry will be selected only once because we have still have **Min Entries**{:.ui-keyword} and **Max Entries**{:.ui-keyword} set to 2, and **Prevent Duplicates**{:.ui-keyword} turned on. But when the Pump-Action Shotgun or Shotgun entry is selected, Ark will choose one of the two items instead.

Check the simulator again, and the behavior should be the same as before: a pump action shotgun or shotgun with 100 shells.

### More Entry Settings

There are some additional features in the item set entries to note.
- **Choose only one item**{:.ui-keyword}: When **Merge selections into one entry**{:.ui-keyword} is turned on, Ark will normally re-run the loot selection for each unit of quantity. For example, if the minimum and maximum quantities are both set to 100, and the item set entry contains both arrows and tranq arrows, the 100 arrows will be split based on weight. With equal weight this would be about 50 of each arrow. For large amounts, this is very taxing on the server and will cause lag when loot drops spawn. If you enable the **Choose only one item**{:.ui-keyword} option, Ark will choose one item first and then give the full amount to that item. Beacon will automatically use this setting when there is only one item in an item set entry.
- **Stat Limits Multiplier**{:.ui-keyword}: If [Item Stat Limits](/configs/statlimits/) are enabled for the server, the limits for loot selected by this entry can be adjusted. Values greater than 1.0 increase the limit, while values less than 1.0 decrease the limit.
- **Prevent Grinding**{:.ui-keyword}: Enabling this option will generate loot that cannot be fed to the industrial grinder.

## More Tips

It's not uncommon to want one loot drop to be the same as another. Beacon has a few ways to help with this.

First, the **Duplicate**{:.ui-keyword} button in the **Loot Drops**{:.ui-keyword} list allows you to copy a loot drop into one or more loot drops. In the **Add Loot Drop**{:.ui-keyword} wizard that appears, you can shift-click on the drops to select a range. Or hold the Control key (Command on MacOS) while clicking to select non-sequential drops.

Second, you can use the same clicking techniques to select multiple loot drops and edit them at the same time. However, you'll only see item sets that are identical between all selected loot drops. You can also select multiple item sets.

Third, Beacon supports copy and paste. So you can copy loot drops between documents, or item sets between loot drops. You can even copy a loot drop and paste its config line directly into your ini if you like.

{% include affectedkeys.html %}