---
title: Levels and XP
parent: Config Editors
configkeys:
  - LevelExperienceRampOverrides
  - OverrideMaxExperiencePointsDino
  - OverrideMaxExperiencePointsPlayer
supportedgames:
  - "Ark: Survival Evolved"
---
{% include editortitle.markdown %}

Ark allows server admins to change the amount of experience players and tamed creatures need for each level, as well as the number of levels they are able to earn.

## The Basics

Press the **New Level**{:.ui-keyword} button in the editor toolbar to add the next level. Leveling is always sequential, and players start at level 1, so the next level will be level 2.

{% include image.html file="xpforlevel.png" file2x="xpforlevel@2x.png" caption="This dialog is used for defining the next level in the chain." %}

The window will show you which level you are defining, the experience amount of the last level as **Min XP**{:.ui-keyword} and the maximum experience as **Max XP**{:.ui-keyword}. Ark has a limit of 4,294,967,295 experience. Bad things happen if you try to use a greater value, so Beacon will prevent you from doing so.

Set **XP For Level**{:.ui-keyword} to 5 and press **OK**{:.ui-keyword} to put the level into the list. Clicking the **New Level**{:.ui-keyword} button again will allow you to define level 3.

## Ascension

At the time of this writing, Ark reserves the final 100 levels for [ascension](https://ark.wiki.gg/wiki/Ascension): 75 earned by defeating bosses, 5 chibi levels, 10 for explorer notes, and 10 for Fjordur runes. Beacon will show you which levels are locked by ascension in the **Ascension Required**{:.ui-keyword} column. You will not be able to export or deploy until enough levels have been defined to cover ascension. It is not possible to remove the ascension requirement.

## Using the Wizard

Clicking the **Auto Levels**{:.ui-keyword} will bring up the **Experience Wizard**{:.ui-keyword} which allows you to define a number of levels at once.

{% include image.html file="xpwizard.png" file2x="xpwizard@2x.png" caption="This dialog allows you to define many levels at the same time." %}

Similar to the **New Level**{:.ui-keyword} window, this wizard will show you which level you'll be defining next as the **Starting Level**{:.ui-keyword} field. In **Additional Levels**{:.ui-keyword} you would decide how many additional levels you want to be adding. When doing so, the **Ending Level**{:.ui-keyword} field will update. **Additional XP**{:.ui-keyword} is the amount of experience **in addition to the previous experience**. The list below will show exactly how much experience will be assigned to each level.

The curve editor on the right allows you to adjust how the experience is distributed. By default, the line is linear. This means adding 100 XP over 10 levels would increment each by 10.

By dragging the blue circles, you can influence how the value in **Additional XP**{:.ui-keyword} is distributed to the levels in **Additional Levels**{:.ui-keyword}. Use the values in the list to preview the outcome.

{% include image.html file="xpwizard_curve.png" file2x="xpwizard_curve@2x.png" caption="Dragging the blue circle in the lower left all the way to the right changes the curve to make it easier to start, and require more experience at higher levels." %}

## Tweaking the Defaults

Pressing the **Load Defaults**{:.ui-keyword} button in the editor toolbar will load Ark's default experience values. If you've already defined levels, Beacon will ask if you want to replace what you've already done with the defaults.

This way you can add additional levels to the defaults, or make adjustments.

## Tamed Creatures

Click the **Tames**{:.ui-keyword} tab up top to switch the editor to tamed creatures. Tamed creatures have no ascension, and the values chosen decide the number of levels after taming they are able to earn.

{% include affectedkeys.html %}