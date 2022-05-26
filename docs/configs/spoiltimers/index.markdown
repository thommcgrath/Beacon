---
title: Decay and Spoil
parent: Config Editors
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
---
{% include editortitle.markdown %}

Decay is a behavior built into Ark to control abandoned structures on public servers. While there are lots of settings to allow a great deal of control, they can be overwhelming, so this guide will attempt to break down exactly what each one does.

## Decay Settings

{% include image.html file="decaysettings.png" file2x="decaysettings@2x.png" caption="Beacon's Decay tab with Ark's default settings." %}

Starting at the top left, four switches control decay for structures and creatures in both PvE and PvP mode. PvE decay must be enabled if PvP decay is enabled.

The next two fields, _Structure Decay Multiplier_ and _Creature Decay Multiplier_, control the rate at which structures and creatures decay. Greater numbers will take longer to decay. Refer to the chart in the _Times_ group for the effects of changing the multipliers. _Crop Decay Speed Multiplier_ works exactly the same as the previous two multipliers, but controls the speed at which crops die if not watered.

### Unsnapped and Core Structures

The next couple settings require understanding what is an unsnapped structure and what is a core structure. An unsnapped structure is any structure that doesn't have another structure snapped to it. A core structure is a foundation, pillar, platform, or other structure that could be built on.

Therefore _Only Decay Unsnapped Core Structures_ means that although decay is turned on, only foundations and pillars that have nothing attached to them will be decayed. This allows bases to remain intact, but pillar/foundation spam is controlled.

_Fast Decay Unsnapped Core Structures_ is another potential solution to the pillar spam problem. With this option turned on, unsnapped core structures will decay at their own rate, as defined with the _Fast Decay Period_ setting. Turning this on with _Only Decay Unsnapped Core Structures_ turned off allows the regular decay times for most structures while still fighting pillar spam.

### Auto Destroy

With _Auto Destroy Structures_ turned on, structures will be destroyed after a certain amount time since a tribe member has been nearby. By default, the destroy time will match the **unmultiplied** decay time, so that structures will be destroyed as soon as they decay, when using official settings. _Auto Destroy Structures Multiplier_ can be used to adjust the destroy time.

> **Warning**: Setting _Auto Destroy Structures Multiplier_ lower than _Structure Decay Multiplier_ will cause structures to be destroyed before they finish decaying.

_Only Auto Destroy Core Structures_ can be turned on to destroy only core structures. This means structures placed directly on the ground will not be automatically destroyed. Technically a structure placed on a foundation would not be destroyed, but would still collapse when the foundation is destroyed.

_Auto Destroy Creatures_ works the same way, but there is no way to control the destroy time. It is always equal to the decay time.

## Spoil Settings

{% include image.html file="spoilsettings.png" file2x="spoilsettings@2x.png" caption="Beacon's spoil tab with default settings." %}

_Spoil Time Multiplier_ is used to control the speed at which items spoil. Greater numbers will take longer to spoil. Use the chart to see the effects of the multiplier.

_Corpse Decomposition Time Multiplier_ defines the amount of time that a body will remain on the map. The field to the right of the multiplier will show decompose time, but can also be edited. Use a simple format, such as "X days Y hours Z minutes" or "XdYhZm" and Beacon will compute the desired multiplier automatically. _Item Decomposition Time Multiplier_ works exactly the same way, but for dropped items and bags instead.

_Clamp Item Spoil Times_, when turned on, will prevent spoil times from ever reaching Ark's maximum.

{% include affectedkeys.html %}