---
title: General Settings
parent: "Ark: Survival Ascended"
grand_parent: Config Editors
supportedgames:
  - "Ark: Survival Ascended"
---
{% include editortitle.markdown %}

Beacon's General Settings editor covers nearly every setting not found elsewhere, but it's simplicity can be deceiving.

## Set vs Not Set

Every setting in the General Settings editor can be set **or not set**. When a setting is not set, it has no value and Beacon will leave the setting alone. This allows the setting to be controlled by something else, such as a host control panel, the game itself, or a lower config set.

Beacon represents a setting that has a value by making the label bold. **Settings which are not bold will not be controlled by Beacon**.

{% include image.html file="tristate.png" file2x="tristate@2x.png" caption="The three states of an on or off setting." %}

Using the above image as an example will have the following effects:

| Status | Generated Config | Effect |
| -- | -- | -- |
| Setting is not bold. | No bForceCanRideFliers in GameUserSettings.ini | Map controls the ability to ride flyers. |
| Setting is bold and turned off. | bForceCanRideFliers=False in GameUserSettings.ini | No flying creatures can be ridden. |
| Setting is bold and turned on. | bForceCanRideFliers=True in GameUserSettings.ini | All flying creatures can be ridden. |

## Official Names

{% include image.html file="humanlabels.png" file2x="humanlabels@2x.png" caption="Settings have human-readable labels." %}

Beacon normally shows the settings with nicer labels. However, clicking the **Official Names**{:.ui-keyword} button at the top of the project will tell Beacon to switch to showing the settings with their official name.

{% include image.html file="officiallabels.png" file2x="officiallabels@2x.png" caption="Settings have official labels." %}

{% include affectedkeys.html %}