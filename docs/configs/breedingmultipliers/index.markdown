---
title: Breeding Multipliers
parent: Config Editors
configkeys:
  - AllowAnyoneBabyImprintCuddle
  - BabyCuddleGracePeriodMultiplier
  - BabyCuddleIntervalMultiplier
  - BabyCuddleLoseImprintQualitySpeedMultiplier
  - BabyFoodConsumptionSpeedMultiplier
  - BabyImprintAmountMultiplier
  - BabyImprintingStatScaleMultiplier
  - BabyMatureSpeedMultiplier
  - DisableImprintDinoBuff
  - EggHatchSpeedMultiplier
  - LayEggIntervalMultiplier
  - MatingIntervalMultiplier
  - MatingSpeedMultiplier
---
{% include editortitle.markdown %}

{% include image.html file="multipliers.png" file2x="multipliers@2x.png" caption="The Breeding Multipliers editor has lots of settings to control dino breeding." %}

> Because this editor has descriptions beneath each of the multipliers, this guide will cover only the major multipliers.

### Mature and Incubation Speed Multipliers

Increasing the _Incubation Speed Multiplier_ causes fertilized eggs to hatch faster. See the _Incubation Time_ column in the list at the bottom to see how the multiplier affects the incubation time of the game's creatures.

Increasing the _Mature Speed Multiplier_ causes hatched babies to grow faster. The time to become an adult affects imprint parameters, so see the _Mature Time_, _% Per Imprint_, and _Max Imprint %_ columns of the list for how changing this value affects the game's creatures.

### Imprint Times

The _Imprint Period Multiplier_ adjusts how often a creature wants imprinting. The standard 8 hour imprint period is multiplied by this value, so for example if the _Imprint Period Multiplier_ is 0.5, the formula would be `8 hours x 0.5 = 4 hours`.

To find the amount of imprint to gain per cuddle, the first step is to find the maximum number of cuddles. This is done by rounding down the result of `mature time ÷ imprint period`. So a creature that matures in 12 hours would have 1 possible cuddle at the standard 8 hour mature time. Then the amount per cuddle is computed as `100% / max cuddles`, in this case, 100% per cuddle. This means as long as a creature can cuddle at all, it is capable of reaching 100% imprinting.

Finding a good _Imprint Period Multiplier_ is as simple as finding a value just slightly below the fastest maturing creature that you want imprintable.

{% include image.html file="wizard.png" file2x="wizard@2x.png" caption="The Auto Creature wizard is a quick way to find the perfect multiplier." %}

Beacon includes a wizard for finding the right _Imprint Period Multiplier_ based on your server's _Mature Speed Multiplier_ and creatures you decide are important to imprint. Press the _Auto Imprint_ button, choose the creatures you require to be imprintable, and press OK. You can then review the list to see its effect on the game's creatures.

The _Imprint Amount Multiplier_ can be used to further adjust the rate that creatures imprint. This multiplier affects the amount gained per cuddle. If that amount would normally be 10%, a multiplier of 0.5 would reduce that to 5% per cuddle, while a multiplier of 2.0 would increase that amount to 20% per cuddle.

> A low _Imprint Period Multiplier_ with a high _Imprint Amount Multiplier_ will allow easy instant imprinting.

### Rates

Single player uses different baseline rates than multi player servers. Using the _Rates_ button in the toolbar allows switching Beacon's baselines rates to match. This button has no effect on the server itself, it only changes how Beacon does its math. **It will not turn on single player settings or event rates**.

{% include affectedkeys.html %}