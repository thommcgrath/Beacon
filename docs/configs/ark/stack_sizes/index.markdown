---
title: Stack Sizes
parent: "Ark: Survival Evolved"
grand_parent: Config Editors
configkeys:
  - ConfigOverrideItemMaxQuantity
  - ItemStackSizeMultiplier
supportedgames:
  - "Ark: Survival Evolved"
requiresomni: true
---
{% include editortitle.markdown %}

Some Ark server admins find it necessary to change the maximum stack size of items on their servers.

## Global Stack Size Multiplier

To increase all stack sizes, use the **Global Stack Size Multiplier**{:.ui-keyword} at the top of the editor.

{% include image.html file="doublestack.png" file2x="doublestack@2x.png" caption="Set the Global Stack Size Multiplier to 2.0 to double most stack sizes." %}

This applies to most items not explicitly overridden in the list below it. Values greater than 1 will increase stack sizes, so of course values less than 1 will decrease stack sizes.

{:.caution .titled}
> Caution
> 
> Some items that do not normally stack, such as Fertilizer and Owl Pellets, will not be affected by the **Global Stack Size Multiplier**{:.ui-keyword}. These items behave weird when stacked and should be left single-stacked.

For example, raw meat usually stacks to 40, so setting the **Global Stack Size Multiplier**{:.ui-keyword} to 2.0 will cause raw meat to stack to 80.

## Changing The Stack Size of Individual Items

Let's make raw meat stack to 1,000 instead. Press the **New Override**{:.ui-keyword} button, find raw meat in the list, and press **Select**{:.ui-keyword} to add it to the list.

{% include image.html file="choosemeat.png" file2x="choosemeat@2x.png" caption="Select raw meat and add it to the list." %}

When raw meat is added to the override list, it will default to the normal stack size times the global multiplier. In this case the stack size says 80 due to the 2.0x global multiplier.

Double click the raw meat row to edit the **Stack Size**{:.ui-keyword} column to 1000.

{% include image.html file="editmeat.png" file2x="editmeat@2x.png" caption="The Stack Size column can be edited." %}

That's it, most items will stack to twice their normal amounts, and raw meat will stack to 1000. The **Global Stack Size Multiplier**{:.ui-keyword} does not affect items with overrides.

## Duplicating Overrides

To make life easier, such as when updating the stack sizes of each type of bullet, selecting an engram in the override list will cause the **Duplicate**{:.ui-keyword} button to light up.

This will show a selection dialog similar to before, but this time there is a list on the right. This dialog allows you to select multiple items. Find as many as you like in the list and press the **>>**{:.ui-keyword} button to add them to the list on the right. The **<<**{:.ui-keyword} button will remove them from the **Selected Engrams**{:.ui-keyword} list. Pressing the **Select**{:.ui-keyword} button will duplicate the original stack size override into each of the newly selected items.

{% include affectedkeys.html %}