---
title: Crafting Costs
parent: Config Editors
configkeys:
  - ConfigOverrideItemCraftingCosts
---
{% include editortitle.markdown %}

In this tutorial we're going to change the crafting cost for narcotics.

{% include omninotice.markdown %}

### Step 1: Choose an Engram

{% include image.html file="selecttarget.png" file2x="selecttarget@2x.png" caption="For this tutorial, we will be editing the Narcotic recipe." %}

First, use the **New Recipe**{:.ui-keyword} button at the top of the **Crafting Costs**{:.ui-keyword} list to select an engram whose crafting cost you would like to replace. In this window, the search field at the top allows for quickly finding items. Below that is the tag picker. {% include tags.markdown %} For this example, select _Narcotic_ and press **Select**{:.ui-keyword} or double-click the row. By default the **Load Official Values When Available**{:.ui-keyword} box will be checked, which means the recipe will be pre-loaded with the normal ingredients. For the sake of this tutorial, uncheck the box. Click the _Narcotic_ row, then click the **Select**{:.ui-keyword} button. This will create a _Narcotic_ row in the **Crafting Costs**{:.ui-keyword} list, but because we chose not to load the default recipe, it has no ingredients. Next, some ingredients will be added.

### Step 2: Choose Some Ingredients

{% include image.html file="chooseingredients.png" file2x="chooseingredients@2x.png" caption="Adding Narcoberries and Spoiled Meat to the recipe." %}

In the **Ingredients**{:.ui-keyword} list on the right, press the **Add Ingredient**{:.ui-keyword} button. This time you'll be presented with a similar window, except there is a new section on the right. This window allows you to add multiple items at the same time. Find _Narcoberry_ and either select it and press the **>>**{:.ui-keyword} button to move it to the right list, or double-click it. Next find _Spoiled Meat_ and do the same. The **Selected Engrams**{:.ui-keyword} list should show the two ingredients. Press the **Select**{:.ui-keyword} button to add them to the **Ingredients**{:.ui-keyword} list.

### Step 3: Change the Ingredient Quantities

{% include image.html file="changequantities.png" file2x="changequantities@2x.png" caption="The quantity column can be edited." %}

On the right side of each ingredient is a **Quantity**{:.ui-keyword} column and a **Prevent Substitutions**{:.ui-keyword} column. Click the quantity for _Narcoberry_, then after the row is selected, click the quantity again. This will allow you to edit the value. Increase it to 2. At this point the recipe is now a cheaper version of the default recipe.

The **Prevent Substitutions**{:.ui-keyword} column, when checked, will not allow ingredient substitutions. In this case, leaving it unchecked allows _Ascerbic Mushrooms_ to be used in the place of _Narcoberry_, since the two are interchangeable. When checked, only _Narcoberry_ would be allowed.

## The Adjust Crafting Costs Tool

{% include image.html file="bulk.png" file2x="bulk@2x.png" caption="The Adjust Crafting Costs tool allows quick changes to many recipes and ingredients." %}

At the top of the project inside the **Tools**{:.ui-keyword} menu is an **Adjust Crafting Costs**{:.ui-keyword} option. This will option a tool that allows you to make quick changes to many recipes and ingredients.

The menu next to **Target Recipes**{:.ui-keyword} allows you to choose between changing **All recipes**{:.ui-keyword}, **Selected recipes**{:.ui-keyword}, and **Tagged recipes**{:.ui-keyword}. The **Selected recipes**{:.ui-keyword} option will show a **Choose…**{:.ui-keyword} button allowing you to select one or more recipes that can be changed. The **Tagged recipes**{:.ui-keyword} option will show a tag picker allowing you to include or exclude recipes based on your chosen tags. Blue tags will be required, red tags will be excluded. If no tags are chosen, this option will behave the same as **All recipes**{:.ui-keyword}.

The menu next to **Target Ingredients**{:.ui-keyword} behaves exactly the same as the menu next to **Target Recipes**{:.ui-keyword}.

{:.glossary .titled}
> Glossary
> 
> Recipes are engrams that can be crafted, and ingredients are the engrams required to craft a recipe.

The menu next to **Replacement Ingredient**{:.ui-keyword} allows you to optionally replace the targeted ingredients with another ingredient. For example, you could target red and blue gems and have them replaced with green gems.

The **Cost Multiplier**{:.ui-keyword} field allows changing the quantity of the targeted ingredients. Since this is a multiplier, values below 1 will reduce quantities, values above 1 will increase quantities, and 0 will set the quantity to 0.

When using a multiplier, the quantities may not be whole numbers. For example, a stone pick requires 1 stone by default. A 0.5 multiplier will result in a quantity of 0.5 stone. Since there is no such thing as half a stone, the **Rounding**{:.ui-keyword} menu allows you to decide how to handle this.

| Multiplied Quantity | Round Naturally | Round Up | Round Down |
| -- | -- | -- | -- |
| 0.25 | 0 | 1 | 0 |
| 0.75 | 1 | 1 | 0 |
| 1 | 1 | 1 | 1 |
| 1.4 | 1 | 2 | 1 |
| 1.5 | 2 | 2 | 1 |

If your goal is to remove ingredients from recipes, the **Remove 0-quantity ingredients**{:.ui-keyword} option can be turned on. This will, after rounding, remove any ingredient whose quantity is 0. 0 quantities may be desirable, since Ark will treat them as 1 quantity for every blueprint quality.

When clicking **OK**{:.ui-keyword}, for each of the targeted recipes Beacon will make changes to each of the targeted ingredients. This may take a few seconds, so a progress window will appear.

### Setup Fibercraft Server

{% include image.html file="fibercraft.png" file2x="fibercraft@2x.png" caption="The tool can also be used to quickly setup a fibercraft server." %}

Also in the **Tools**{:.ui-keyword} menu you'll find a **Setup Fibercraft Server**{:.ui-keyword} item. This will open the **Adjust Crafting Costs**{:.ui-keyword} tool pre-filled with the settings needed for a fibercraft server.

To setup an easy craft server, use the same **Setup Fibercraft Server**{:.ui-keyword} tool, but change the **Cost Multiplier**{:.ui-keyword} field to zero. This will make everything cost 1 fiber, no matter the blueprint quality.

## The Setup Transferrable Element Tool

The **Setup Transferrable Element**{:.ui-keyword} tool will automatically setup recipes to make it easier to transfer element between servers. The recommended choices will be chosen automatically, but you are welcome to make changes.

The **Intermediate Ingredient**{:.ui-keyword} is the recipe that will be used to make element transferrable. Pick something that players rarely use. _Soap_ and _Compass_ are common choices.

With the **Intermediate crafts into 100 shards**{:.ui-keyword} option, the intermediate will be crafted from 1 _Element_, and 100 _Element Shards_ will be crafted from 1 intermediate. The default recipe of crafting 1 _Element_ from 100 _Element Shards_ will be unchanged.

With the **Intermediate crafts into 1 element**{:.ui-keyword} option, the intermediate will be crafted from 1 _Element_, and 1 _Element_ will be crafted from 1 intermediate. This means it will be impossible to convert shards into element.

## Tips and Tricks

- The **Crafting Costs**{:.ui-keyword} editor supports copy and paste. You can copy ingredients from one recipe to another.
- You can also duplicate recipes. Select a finished recipe, press the **Duplicate**{:.ui-keyword} button in the **Crafting Costs**{:.ui-keyword} list, and you'll be presented with the same multiple engram selection window. Select as many engrams as you want, and Beacon will clone the original recipe into all of them.

{% include affectedkeys.html %}