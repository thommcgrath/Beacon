---
title: Project Settings
parent: "Ark: Survival Ascended"
grand_parent: Config Editors
supportedgames:
  - "Ark: Survival Ascended"
---
{% include editortitle.markdown %}

The Project Settings editor has only a few properties, but they can have a big impact on your project.

{% include image.html file="projectsettings.png" file2x="projectsettings@2x.png" caption="Beacon Project Settings: an editor will more advanced options." %}

## Common Settings
This settings are available to all project types.

- **Title**{:.ui-keyword}: This is the title of your project, as it would appear in the project lists. This is not the name of an Ark server, though it's fine if they match.
- **Description**{:.ui-keyword}: If a project is to be shared in the Community Projects section, a detailed and unique description is required. Give users a reason to check out your project. For most projects, however, this description is not required.
- **Force Console Compatibility**{:.ui-keyword}: When enabled, Beacon will disable any enabled mods listed in the **Steam Only**{:.ui-keyword} section of the mod picker. Custom mods created in the **Mods**{:.ui-keyword} section are **not** affected by this setting.
- **Compress Project**{:.ui-keyword}: Beacon projects can get quite large, so this option compresses the project to save disk space and make it easier to share the project. *This setting does not affect cloud projects*. If unchecked, the Beacon project is saved as a plain text JSON file.

## Ark: Survival Ascended Settings
These settings are available to Ark: Survival Ascended projects.

- **Windows Store Compatibility**{:.ui-keyword}: The Windows Store version of Ark uses a different section header in its `Game.ini` file.
    - *Automatic*: In most cases, Beacon will detect and use the correct header automatically.
    - *Never*: Always use the `[/script/shootergame.shootergamemode]` header used by most versions of Ark.
    - *Always*: Always use the `[ShooterGameMode_Options]` used by the Windows Store version of Ark.
- **Allow USC-2 Files**{:.ui-keyword}: If you use certain characters or symbols in your server name or message of the day, the `GameUserSettings.ini` file must be saved with an encoding called UCS-2. The problem with UCS-2 is that most text editors do not understand it, so making changes to the file will usually corrupt it, causing a server reset. By default, Beacon removes characters that would require this UCS-2 encoding. Enabling this option will allow Beacon to create UCS-2 encoded files *only when necessary*.

### UCS-2 Technical Details

UCS-2 is basically an obsolete form of UTF-16. UCS-2 uses 2 bytes for each character, while UTF-16 uses at least 2 bytes for each character, up to 4 bytes if necessary.

Beacon's UCS-2 files are little-endian, with a byte order marker of 0xFFFE, although Beacon can correctly understand UCS-2BE, UTF-16LE, and UTF-16BE files as well.

## 7 Days to Die Settings
These settings are available to 7 Days to Die projects.

- **Game Version**{:.ui-keyword}: Not all configuration options are compatible with every version. The game will complain about options it does not recognize, so this setting is important to avoid adding incompatible options to your server.

{% include affectedkeys.html %}