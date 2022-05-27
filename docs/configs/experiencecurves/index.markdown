---
title: Levels and XP
parent: Config Editors
configkeys:
  - LevelExperienceRampOverrides
  - OverrideMaxExperiencePointsDino
  - OverrideMaxExperiencePointsPlayer
---
{% include editortitle.markdown %}

Ark allows server admins to change the amount of experience players and tamed dinos need for each level, as well as the number of levels they are able to earn.

{% include omninotice.markdown %}

## The Basics

Leveling is always sequential. Since players start at level 1, pressing the _New Level_ button will bring up an editor to edit the next level, which would be 2.

{% include image.html file="xpforlevel.png" file2x="xpforlevel@2x.png" caption="This dialog is used for defining the next level in the chain." %}

The _Set Experience for Level_ dialog will show you which level you are defining, the XP amount of the last level as _Min XP_ and the maximum XP as _Max XP_. Ark has a limit of 2,147,483,647 XP. Bad things happen if you try to use a greater value, so Beacon will prevent you from doing so.

Setting _XP For Level_ to 5 and pressing _OK_ will put the level into the list. Clicking the _New Level_ button again will allow you to define level 3.

## Ascension

At the time of this writing, Ark reserves the final 75 levels for ascension: 70 earned by defeating bosses and 5 chibi levels. Beacon will show you which levels are locked by ascension in the _Ascension Required_ column. You will not be able to export or deploy until enough levels have been defined to cover ascension. It is not possible to remove the ascension requirement.

## Using the Wizard

Clicking the _Auto Levels_ will bring up the _Experience Wizard_ which allows you to define a number of levels at once.

{% include image.html file="xpwizard.png" file2x="xpwizard@2x.png" caption="This dialog allows you to define many levels at the same time." %}

Similar to the _Set Experience for Level_ dialog, this dialog will show you which level you'll be defining next as the _Starting Level_ field. In _Additional Levels_ you would decide how many additional levels you want to be adding. When doing so, the _Ending Level_ field will update. And _Additional XP_ is the amount of experience **in addition to the previous experience**. The list below will show exactly how much experience will be assigned to each level.

The curve editor on the right allows you to adjust how the experience is distributed. By default, the line is linear. This means adding 100 XP over 10 levels would increment each by 10.

By dragging the blue circles, you can influence how the value in _Additional XP_ is distributed to the levels in _Additional Levels_. Use the values in the list to preview the outcome.

{% include image.html file="xpwizard_curve.png" file2x="xpwizard_curve@2x.png" caption="Dragging the blue circle in the lower left all the way to the right changes the curve to make it easier to start, and require more experience at higher levels." %}

## Tweaking the Defaults

Pressing the _Load Defaults_ button will load Ark's default experience values. If you've already defined levels, Beacon will ask if you want to replace what you've already done with the defaults.

This way, you can add additional levels to the defaults, or make adjustments.

## Tamed Creatures

Click the _Tames_ tab up top switches the editor to tamed creatures. Tamed creatures have no ascension, and the values chosen decide the number of levels after taming they are able to earn.

{% include affectedkeys.html %}