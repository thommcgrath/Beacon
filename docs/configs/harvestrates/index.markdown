---
title: Harvest Rates
parent: Config Editors
configkeys:
  - ClampResourceHarvestDamage
  - DinoHarvestingDamageMultiplier
  - HarvestAmountMultiplier
  - HarvestHealthMultiplier
  - HarvestResourceItemAmountClassMultipliers
  - PlayerHarvestingDamageMultiplier
  - UseOptimizedHarvestingHealth
---
{% include editortitle.markdown %}

Ever feel like players don't get enough wood from a tree? Ark server admins can control the amount of resources obtained from resource nodes, such as trees, rocks, and crystals. Admins can choose to boost all resources, or just the resources for individual items.

{% include omninotice.markdown %}

{% include image.html file="harvestrates.png" file2x="harvestrates@2x.png" caption="The default empty Harvest Rates editor." %}

## Harvest Rate

### Method 1: Global Harvest Rate Multiplier

By far the easiest and most natural option is to adjust the _Global Harvest Rate Multiplier_. Setting this to 2.0 would double the amount of resources given at each resource node.

The problem with this setting is how Ark handles it behind the scenes. Every time you harvest something, the game creates a harvest event to determine what resources to reward the player. Increasing the multiplier creates more harvest events per action, and that means more work the server has to do. For this reason, setting this multiplier very high can easily cause the server to lag while players are harvesting.

### Method 2: Clamping Harvest Amounts

Beacon has a setting called _Use Optimized Harvest Rates_ that is designed to combat this. Instead of creating multiple harvest events, the client and server exchange a single harvest event, and simply multiplies the rewards by the _Global Harvest Rate Multiplier_. This is a pretty reasonable solution, but it has the side effect of reducing the number of rare resources rewarded.

Imagine the _Global Harvest Rate Multiplier_ is set to 50. With _Use Optimized Harvest Rates_ turned off, it is as if you are flipping a coin 50 times. It takes a bit of time per flip, but you'll get roughly 50% heads and 50% tails. With _Use Optimized Harvest Rates_ turned on, the coin is flipped only once and the result is multiplied by 50. So rather than the 50%/50% split that would be normal, you'd get either 100% heads or 100% tails.

### Method 3: Overriding Each Resource

The third option is to set the global harvest rate multiplier to 1.0 and override every resource type. This of course takes some time to setup, and still has the side effect of reducing rare resources, but allows adjusting rates on a per-resource basis.

Overriding individual resource rates is not mutually exclusive to the other two options either.

To override a resource harvest rate, click the _New Rate_ button  to bring up the resource picker.

{% include image.html file="engrampicker.png" file2x="engrampicker@2x.png" caption="The resource picker allows you to select a resource to override." %}

Use the field at the top to search for an item, and the tags picker below it to filter the list to only the types of engrams you're interested in. {% include tags.markdown %} By default, Beacon filters to only harvestable items. Select an item and press _Select_ or simply double-click an item.

Once the item is added to the list, there will be two columns to the right: _Rate Multiplier_ and _Effective Multiplier_. Click the value in the _Rate Multiplier_ column to adjust it. The _Effective Multiplier_ cannot be edited, because it is the result of multiplying the resource's _Rate Multiplier_ by the _Global Harvest Rate Multiplier_. It is there for reference only.

{% include image.html file="global1x.png" file2x="global1x@2x.png" caption="The Human Hair rate multiplier set to 6 and global rate multiplier set to 1 means the Human Hair effective rate multiplier is 6." %}

Setting the _Global Harvest Rate Multiplier_ to 2.0 increases the _Effective Rate_ column accordingly.

{% include image.html file="global2x.png" file2x="global2x@2x.png" caption="The Human Hair Effective Multiplier increases according to the Global Harvest Rate Multiplier." %}

## Other Settings

### Global Harvest Health Multiplier

This setting increases the amount of damage required to fully harvest a resource. Increasing resource health does not allow for more resources to be harvested though. It only requires more hits to obtain the same amount of resources. Higher numbers increase health.

### Player and Creature Harvest Damage Multiplier

These two settings change the amount of damage done by players and creatures. Higher numbers increase damage.

### Clamp Harvest Damage

Turning this setting on limits the amount of damage that can be done by players and creatures.

## Tips

- Due to how Ark rounds these multipliers, it is not possible to reduce the harvest rate of an individual resource below the global harvest rate. Pay attention to the _Effective Rate_ column in this case. Setting a resource to 0.5 will act like 1.0, while setting it to 0.4 would act like 0.0, effectively making the resource not harvestable. The solution is to reduce the global rate and increase the individual rates for every item. Beacon can do this for you using the _Tools_ button in the project toolbar with the _Convert Global Harvest Rate to Individual Rates_ tool.
- Individual rates can be duplicated using the _Duplicate_ button. First setup one rate, then duplicate it into many additional rates to save time.

{% include affectedkeys.html %}