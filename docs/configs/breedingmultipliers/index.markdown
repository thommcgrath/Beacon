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
supportedgames:
  - "Ark: Survival Evolved"
---
{% include editortitle.markdown %}

Ark has a lot of breeding settings allowing admins to control things like baby mature speed, imprint frequency, and mating cooldown. This guide will help Ark server admins understand how these settings work together and find just the right values for each.

{% include image.html file="multipliers.png" file2x="multipliers@2x.png" caption="The Breeding Multipliers editor has lots of settings to control dino breeding." %}

{:.blue .titled}
> Heads Up
> 
> Because this editor has descriptions beneath each of the multipliers, this guide will cover only the major multipliers.

## Mature and Incubation Speed Multipliers

Increasing the **Incubation Speed Multiplier**{:.ui-keyword} causes fertilized eggs to hatch faster. See the **Incubation Time**{:.ui-keyword} column in the list at the bottom to see how the multiplier affects the incubation time of the game's creatures.

Increasing the **Mature Speed Multiplier**{:.ui-keyword} causes hatched babies to grow faster. The time to become an adult affects imprint parameters, so see the **Mature Time**{:.ui-keyword}, **% Per Imprint**{:.ui-keyword}, and **Max Imprint %**{:.ui-keyword} columns of the list for how changing this value affects the game's creatures.

## Imprinting

The **Imprint Period Multiplier**{:.ui-keyword} adjusts how often a creature wants imprinting. The standard 8 hour imprint period is multiplied by this value, so for example if the **Imprint Period Multiplier**{:.ui-keyword} is 0.5, the formula would be `8 hours x 0.5 = 4 hours`.

To find the amount of imprinting to gain per imprint, the first step is to find the maximum number of imprints. This is done by rounding down the result of `mature time ÷ imprint period`. So a creature that matures in 12 hours would have 1 possible imprint at the standard 8 hour mature time. Then the amount per imprint is computed as `100% / max imprints`, in this case, 100% per imprint. This means as long as a creature can imprint at all, it is capable of reaching 100% imprinting.

Finding a good **Imprint Period Multiplier**{:.ui-keyword} could be done by finding a value just slightly below the fastest maturing creature that you want imprintable.

The **Imprint Amount Multiplier**{:.ui-keyword} adjusts the amount of imprinting each imprint provides. If one imprint would normally be worth 10%, a 2.0 multiplier would give 20% instead.

{:.tip .titled}
> Tip
> 
> A low **Imprint Period Multiplier**{:.ui-keyword} with a high **Imprint Amount Multiplier**{:.ui-keyword} will allow easy instant imprinting.

### Auto Imprint

{% include image.html file="wizard.png" file2x="wizard@2x.png" caption="The Auto Creature wizard is a quick way to find the perfect multiplier." %}

Beacon includes a wizard for finding the right **Imprint Period Multiplier**{:.ui-keyword} based on your server's **Mature Speed Multiplier**{:.ui-keyword} and creatures you decide are important to imprint. Press the **Auto Imprint**{:.ui-keyword} button, choose the creatures you require to be imprintable, and press OK. You can then review the list to see its effect on the game's creatures.

## Rates

Single player uses different baseline rates than multi player servers. Using the **Rates**{:.ui-keyword} button in the toolbar allows switching Beacon's baselines rates to match. This button has no effect on the server itself, it only changes how Beacon does its math. **It will not turn on single player settings or event rates**.

{% include affectedkeys.html %}