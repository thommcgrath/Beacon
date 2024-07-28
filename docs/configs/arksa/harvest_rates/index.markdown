---
title: Harvest Rates
parent: "Ark: Survival Ascended"
grand_parent: Config Editors
configkeys:
  - ClampResourceHarvestDamage
  - DinoHarvestingDamageMultiplier
  - HarvestAmountMultiplier
  - HarvestHealthMultiplier
  - HarvestResourceItemAmountClassMultipliers
  - PlayerHarvestingDamageMultiplier
  - UseOptimizedHarvestingHealth
supportedgames:
  - "Ark: Survival Ascended"
requiresomni: true
---
{% include editortitle.markdown %}

Ever feel like players don't get enough wood from a tree? Ark server admins can control the amount of resources obtained from resource nodes, such as trees, rocks, and crystals. Admins can choose to boost all resources, or just the resources for individual items.

{% include image.html file="harvestrates.png" file2x="harvestrates@2x.png" caption="The default empty Harvest Rates editor." %}

## Harvest Rate

### Method 1: Global Harvest Rate Multiplier
By far the most natural option is to adjust the **Global Harvest Rate Multiplier**{:.ui-keyword}. Setting this to 2.0 would double the amount of resources given at each resource node.

The problem with this setting is how Ark handles it behind the scenes. Every time you harvest something, the game creates a harvest event to determine what resources to reward the player. Increasing the multiplier creates more harvest events per action, and that means more work the server has to do. Setting this multiplier very high can cause the server to lag while players are harvesting.

### Method 2: Clamping Harvest Amounts
Beacon has a setting called **Use Optimized Harvest Rates**{:.ui-keyword} that is designed to combat this. Instead of creating multiple harvest events, the client and server exchange a single harvest event and multiplies the rewards by the **Global Harvest Rate Multiplier**{:.ui-keyword}. This is a pretty reasonable solution, but it has the side effect of reducing the number of rare resources rewarded.

Imagine the **Global Harvest Rate Multiplier**{:.ui-keyword} is set to 50. With **Use Optimized Harvest Rates**{:.ui-keyword} turned off, it is as if you are flipping a coin 50 times. It takes a bit of time per flip, but you'll get roughly 50% heads and 50% tails. With **Use Optimized Harvest Rates**{:.ui-keyword} turned on, the coin is flipped only once and the result is multiplied by 50. So rather than the 50%/50% split that would be normal, you'd get either 100% heads or 100% tails.

### Method 3: Overriding Each Resource
The third option is to set the global harvest rate multiplier to 1.0 and override every resource type. This of course takes some time to setup, and still has the side effect of reducing rare resources, but allows adjusting rates on a per-resource basis.

Overriding individual resource rates is not mutually exclusive to the other two options either.

To override a resource harvest rate, click the **New Rate**{:.ui-keyword} button to bring up the resource picker.

{% include image.html file="engrampicker.png" file2x="engrampicker@2x.png" caption="The resource picker allows you to select a resource to override." %}

Use the field at the top to search for an item, and the tags picker below it to filter the list to only the types of engrams you're interested in. {% include tags.markdown %} By default, Beacon filters to only harvestable items. Select an item and press **Select**{:.ui-keyword} or double-click an item.

Once the item is added to the list, there will be two columns to the right: **Rate Multiplier**{:.ui-keyword} and **Effective Multiplier**{:.ui-keyword}. Click the value in the **Rate Multiplier**{:.ui-keyword} column to adjust it. The **Effective Multiplier**{:.ui-keyword} cannot be edited, because it is the result of multiplying the resource's **Rate Multiplier**{:.ui-keyword} by the **Global Harvest Rate Multiplier**{:.ui-keyword}. It is there for reference only.

{% include image.html file="global1x.png" file2x="global1x@2x.png" caption="The Human Hair rate multiplier set to 6 and global rate multiplier set to 1 means the Human Hair effective rate multiplier is 6." %}

Setting the **Global Harvest Rate Multiplier**{:.ui-keyword} to 2.0 increases the **Effective Rate**{:.ui-keyword} column accordingly.

{% include image.html file="global2x.png" file2x="global2x@2x.png" caption="The Human Hair Effective Multiplier increases according to the Global Harvest Rate Multiplier." %}

{:.caution .titled}
> Minimum Harvest Rate
> 
> Due to how Ark rounds these multipliers, it is not possible to reduce the harvest rate of an individual resource below the global harvest rate. Pay attention to the **Effective Rate**{:.ui-keyword} column in this case. Setting a resource to 0.5 will act like 1.0, while setting it to 0.4 would act like 0.0, effectively making the resource not harvestable. The solution is to reduce the global rate and increase the individual rates for every item. Beacon can do this for you using the **Tools**{:.ui-keyword} button in the project toolbar with the **Convert Global Harvest Rate to Individual Rates**{:.ui-keyword} tool.

{:.tip .titled}
> Tip
> 
> Individual rates can be duplicated using the **Duplicate**{:.ui-keyword} button. First setup one rate, then duplicate it into many additional rates to save time.

## Other Settings

- **Global Harvest Health Multiplier**{:.ui-keyword}: This setting increases the amount of damage required to fully harvest a resource. Increasing resource health does not allow for more resources to be harvested though. It only requires more hits to obtain the same amount of resources. Higher numbers increase health.
- **Player Harvest Damage Multiplier**{:.ui-keyword} and **Creature Harvest Damage Multiplier**{:.ui-keyword}: These two settings change the amount of damage done by players and creatures. Higher numbers increase damage.
- **Clamp Harvest Damage**{:.ui-keyword}: Turning this setting on limits the amount of damage that can be done by players and creatures.

{% include affectedkeys.html %}