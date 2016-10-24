# Beacon For Ark
An editor for the loot sources in Ark: Survival Evolved.

## Supporting
I don't normally like accept donations, however there will be out-of-pocket costs before the project is finished, such as purchasing signing certificates. So if you'd like to contribute monetarily, you can so do via [PayPal](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=ZX4EE4YTSP9LS).

## Introduction
Ark players know too well the feeling of rushing to grab a red loot drop only to find it filled with a hide hat and a water jar. Beacon is a tool designed to allow server admins to fix that.

Wildcard gave admins this ability ages ago, but actually doing so is a frustrating experience in madness. The phrase "wall of text" could not be more appropriate. So many admins either wouldn't customize, or would use a config they found on pastebin, for example.

Beacon makes it simple. Beacon makes it human.

## Getting Started
There are lots of different loot sources in the game, and Beacon lets admins customize them all. When creating a new document, there will be no loot sources listed. This essentially means "no changes" and this is important. If a loot source is not defined in a document, it will be left as standard.

To start, add a loot source. This can be done using the "Add Loot Source…" menu option from the "Document" menu or using the small plus button in the lower left of the window. This opens the loot source wizard. Start simple and select "Island White (Level 3)" and press the "Next" button. In the next screen, the minimum and maximum number of item sets can be specified. Leave this alone for now. Under the "Presets" list, check "Cloth Clothing", "Small Saddles", and "Primitive Tools" before pressing the "Done" button.

That's it! Well, there's plenty more that can be done, but at the most basic level, white loot drops on The Island and The Center will now contain one or all of the sets listed.

The new loot source will be selected automatically. In the second column is the list of possible sets the loot source can select from. Remember the "Min Sets" and "Max Sets" values from a moment ago? That specifies how many of these sets can be chosen when filling a loot source.

Selecting any of the item sets will list the possible contents. Just like a loot source, an item set has a minimum and maximum number of items to select. The "Cloth Clothing" set defaults to selecting between 1 and 5 items, so a drop could contain just a hat or a full set of cloth clothing. The "Weight" value of each set specifies its relative likeliness of selection. All three sets will have a weight of 50 by default, and that means they are all equally likely to be selected. The chance for selection is basically "weight / sum of all weights" so increasing the value of one set to 100 would make it 50% likely to be chosen, vs 25% for the other two sets.

Inside each set is the list of possible contents. Item set entries have a minimum quantity, maximum quantity, minimum quality, maximum quality, weight, and blueprint chance. Quantities need no explanation, and weight works the same as with item sets.

Quality ranges are... interesting. The range specified is ideal, but Ark introduces an amount of randomness to quality values, so do not take these as hard limits. The quality values Beacon uses have been extensively tested to produce *the most statistically likely* loot at the desired quality, but it is not guaranteed. This is just how Ark behaves unfortunately.

The blueprint chance is just the chance for an item to be blueprint instead of a usable item. Not all items have a blueprint - like wood for example - so their blueprint chance is always 0%.

The next step is to go to the "File" menu and select "Export" to create a Game.ini file ready for the server.

## Tips & Tricks
- It is possible to select multiple loot sources. Item sets that are identical between all selected loot sources will remain in the item set list and can be edited together.
- Copy & Paste is fully supported, so feel free to copy a set from one loot source to another, or entries between sets.
- It is perfectly acceptable to put Scorched Earth items in loot sources for The Island and The Center, and vice versa. However, certain items don't actually work. For example, Wyvern Eggs can be put into a loot source on The Island, but cannot actually be hatched as they will vanish when placed on the ground for incubating. Other things just don't make sense, such as Oil Pumps on The Island. Just be aware.
- Existing server configs can be imported. However, this isn't very convenient, as item sets won't have names. Don't import a config previous exported by Beacon. The config that Beacon exports is designed to work around some of Ark's oddities and won't appear the same as the original document.
- Save your Beacon document. When new items are added, it'll be easier to add them to your loot sources next time.
- Beacon updates its database of loot sources, engrams, and presets automatically. A new version of Beacon will not be needed when new items are added to Ark.
- An item set entry can contain multiple items. This is different from having multiple single-engram set entries. For example, having an entry with both the Quetzal Saddle and Quetzal Platform Saddle guarantees one or the other. However, having one entry for each allows the possibility for both saddles to be selected.