---
title: Crafting Costs
parent: Config Editors
configkeys:
  - ConfigOverrideItemCraftingCosts
---
{% include editortitle.markdown %}

### Step 1: Choose an Engram

{% include image.html file="selecttarget.png" file2x="selecttarget@2x.png" caption="For this tutorial, we will be editing the Narcotic recipe." %}

First, use the _New Recipe_ button in the _Crafting Costs_ list to select an engram whose crafting cost you would like to replace. In this window, the search field at the top allows for quickly finding items. Below that is the tag picker. {% include tags.markdown %} For this example, select _Narcotics_ and press _Select_ or simply double-click the row. By default the _Load Official Values When Available_ box will be checked, which means the recipe will be pre-loaded with the normal ingredients. For the sake of this tutorial, uncheck the box. Click the _Narcotic_ row, then click the _Select_ button. This will create a _Narcotics_ row in the _Crafting Costs_ list, but because we chose not to load the default recipe, it has no ingredients. Next, some ingredients will be added.

### Step 2: Choose Some Ingredients

{% include image.html file="chooseingredients.png" file2x="chooseingredients@2x.png" caption="Adding Narcoberries and Spoiled Meat to the recipe." %}

In the _Ingredients_ list, press the _Add Ingredient_ button. This time you'll be presented with a similar dialog, except there is a new section on the right. This dialog allows you to add multiple items at the same time. Find _Narcoberry_ and either select it and press the _>>_ button to move it to the right list, or double-click it. Next find _Spoiled Meat_ and do the same. The _Selected Engrams_ list should show the two ingredients. Press the _Select_ button to add them. This adds two rows to the _Ingredients_ list.

### Step 3: Change the Ingredient Quantities

{% include image.html file="finishedrecipe.png" file2x="finishedrecipe@2x.png" caption="After adjusting the quantities, the recipe changes will be completed." %}

On the right side of each ingredient is a _Quantity_ column and a _Prevent Substitutions_ column. Click the quantity for _Narcoberry_, then after the row is selected, click the quantity again. This will allow you to edit the value. Increase it to 2. At this point the recipe is now a cheaper version of the default recipe.

The _Prevent Substitutions_ column, when checked, will not allow ingredient substitutions. In this case, leaving it unchecked allows _Ascerbic Mushrooms_ to be used in the place of _Narcoberries_, since the two are interchangeable. When checked, only _Narcoberries_ would be allowed.

## Tips and Tricks

- The _Crafting Costs_ editor supports copy and paste. You can copy ingredients from one recipe to another.
- You can also duplicate recipes. Simply select a finished recipe, press the _Duplicate_ button in the _Crafting Costs_ list, and you'll be presented with the same multiple engram selection dialog. Select as many engrams as you want, and Beacon will clone the original recipe into all of them.
- There are three tools for the _Crafting Costs_ editor in the _Tools_ menu:
    - _Adjust All Crafting Costs_ will ask for a multiplier and automatically add or update every known recipe. Setting this to 2.0 would double the cost of everything. 0.5 would cut the costs in half.
    - _Setup Fibercraft Server_ will add or change every recipe so that every item costs 1 fiber.
    - _Setup Transferrable Element_ will quickly setup a means to convert element into something transferrable, such as soap.

{% include affectedkeys.html %}