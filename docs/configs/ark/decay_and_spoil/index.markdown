---
title: Decay and Spoil
parent: "Ark: Survival Evolved"
grand_parent: Config Editors
configkeys:
  - AutoDestroyDecayedDinos
  - AutoDestroyOldStructuresMultiplier
  - AutoDestroyStructures
  - ClampItemSpoilingTimes
  - CropDecaySpeedMultiplier
  - DisableDinoDecayPvE
  - DisableStructureDecayPvE
  - FastDecayInterval
  - FastDecayUnsnappedCoreStructures
  - GlobalCorpseDecompositionTimeMultiplier
  - GlobalItemDecompositionTimeMultiplier
  - GlobalSpoilingTimeMultiplier
  - OnlyAutoDestroyCoreStructures
  - OnlyDecayUnsnappedCoreStructures
  - PvEDinoDecayPeriodMultiplier
  - PvEStructureDecayDestructionPeriod
  - PvEStructureDecayPeriodMultiplier
  - PvPDinoDecay
  - PvPStructureDecay
supportedgames:
  - "Ark: Survival Evolved"
---
{% include editortitle.markdown %}

Decay is a behavior built into Ark to control abandoned structures on public servers. While there are lots of settings to allow a great deal of control, they can be overwhelming, so this guide will attempt to break down exactly what each one does.

## Decay Settings

{% include image.html file="decaysettings.png" file2x="decaysettings@2x.png" caption="Beacon's Decay tab with Ark's default settings." %}

Starting at the top left, four switches control decay for structures and creatures in both PvE and PvP mode. PvE decay must be enabled if PvP decay is enabled.

The next two fields, **Structure Decay Multiplier**{:.ui-keyword} and **Creature Decay Multiplier**{:.ui-keyword}, control the rate at which structures and creatures decay. Greater numbers will take longer to decay. Refer to the chart in the **Times**{:.ui-keyword} group for the effects of changing the multipliers. **Crop Decay Speed Multiplier**{:.ui-keyword} works exactly the same as the previous two multipliers, but controls the speed at which crops die if not watered.

### Unsnapped and Core Structures

An unsnapped structure is any structure that doesn't have another structure snapped to it. A core structure is a foundation, pillar, platform, or other structure that could be built on.

Therefore **Only Decay Unsnapped Core Structures**{:.ui-keyword} means that although decay is turned on, **only** foundations and pillars that have nothing attached to them will be decayed. This allows bases to remain intact, but pillar/foundation spam is controlled.

**Fast Decay Unsnapped Core Structures**{:.ui-keyword} is another potential solution to the pillar spam problem. With this option turned on, unsnapped core structures will decay at their own rate, as defined with the **Fast Decay Period**{:.ui-keyword} setting. Turning this on with **Only Decay Unsnapped Core Structures**{:.ui-keyword} turned off allows the regular decay times for most structures while still fighting pillar spam.

### Auto Destroy

With **Auto Destroy Structures**{:.ui-keyword} turned on, structures will be destroyed after a certain amount time since a tribe member has been nearby. By default, the destroy time will match the **unmultiplied** decay time, so that structures will be destroyed as soon as they decay, when using official settings. **Auto Destroy Structures Multiplier**{:.ui-keyword} can be used to adjust the destroy time.

{:.warning .titled}
> Warning
> 
> Setting **Auto Destroy Structures Multiplier**{:.ui-keyword} lower than **Structure Decay Multiplier**{:.ui-keyword} will cause structures to be destroyed before they finish decaying.

**Only Auto Destroy Core Structures**{:.ui-keyword} can be turned on to destroy only core structures. This means structures placed directly on the ground will not be automatically destroyed. Technically a structure placed on a foundation would not be destroyed, but would still collapse when the foundation is destroyed.

**Auto Destroy Creatures**{:.ui-keyword} works the same way, but there is no way to control the destroy time. It is always equal to the decay time.

## Spoil Settings

{% include image.html file="spoilsettings.png" file2x="spoilsettings@2x.png" caption="Beacon's spoil tab with default settings." %}

**Spoil Time Multiplier**{:.ui-keyword} is used to control the speed at which items spoil. Greater numbers will take longer to spoil. Use the chart to see the effects of the multiplier.

**Corpse Decomposition Time Multiplier**{:.ui-keyword} controls the amount of time that a body will remain on the map. The field to the right of the multiplier will show decompose time, but can also be edited. Use a format such as "X days Y hours Z minutes" or "XdYhZm" and Beacon will compute the desired multiplier automatically. **Item Decomposition Time Multiplier**{:.ui-keyword} works exactly the same way, but for dropped items and bags instead.

**Clamp Item Spoil Times**{:.ui-keyword}, when turned on, will prevent spoil times from ever reaching Ark's maximum.

{% include affectedkeys.html %}