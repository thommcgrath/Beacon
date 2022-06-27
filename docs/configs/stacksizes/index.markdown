---
title: Stack Sizes
parent: Config Editors
configkeys:
  - ConfigOverrideItemMaxQuantity
  - ItemStackSizeMultiplier
---
{% include editortitle.markdown %}

Some Ark server admins find it necessary to change the maximum stack size of items on their servers.

{% include omninotice.markdown %}

## Global Stack Size Multiplier

To increase all stack sizes, use the _Global Stack Size Multiplier_ at the top of the editor. This applies to every item not explicitly overridden in the list below it. Values greater than 1 will increase stack sizes, so of course values less than 1 will decrease stack sizes.

For example, Raw Meat usually stacks to 20, so setting the Global Stack Size Multiplier to 2.0 will cause Raw Meat to stack to 40.

## Per-Item Stack Size Overrides

That is, unless Raw Meat is overridden with a different stack size. First, click the _New Override_ button at the top of the _Stack Sizes_ editor. When presented with a list of engrams, the search field can be used to quickly find an item, and the tag picker below the search field helps filter the list. {% include tags.markdown %} Find Raw Meat, select it, and press the _Select_ button.

When adding an engram to the list, the official stack size will be loaded, if known. Otherwise Beacon will choose 100 if the official stack size is not known. The _Global Stack Size Multiplier_ does not affect items in this list, so even if the multiplier is set to 2.0, the stack size would still be exactly as listed.

The stack size in the list can be clicked to be edited.

## Duplicating Overrides

To make life easier, such as when updating the stack sizes of each type of bullet, selecting an engram in the override list will cause the _Duplicate_ button to light up.

This will show a selection dialog similar to before, but this time there is a list on the right. This dialog allows you to select multiple engrams. Just find as many as you like in the list and press the `>>` button to add them to the list on the right. The `<<` button will remove them from the "Selected Engrams" list. Pressing the `Select` button will duplicate the original stack size override into each of the newly selected engrams.

## Tips

- The _Global Stack Size Multiplier_ will not be applied to items that do not normally stack, such as Fertilizer and Raw Prime Meat. You can add overrides for these items, but this doesn't always have the intended effect. For example, crop plots will consume entire stacks of fertilizer as if it was still a single item. Be prepared for strange side effects when forcing unstackable items to becoming stackable.

{% include affectedkeys.html %}