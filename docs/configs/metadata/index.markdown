---
title: Project Settings
parent: Config Editors
---
{% include editortitle.markdown %}

The Project Settings editor has only a few properties, but they can have a big impact on your project.

{% include image.html file="projectsettings.png" file2x="projectsettings@2x.png" caption="Beacon Project Settings: a simple editor will more advanced options." %}

- **Title**{:.ui-keyword}: This is your project's title, as it would appear in the project lists. This is not an Ark server's name, though it's ok if they match.
- **Description**{:.ui-keyword}: If a project is to be shared in the Community Projects section, a detailed and unique description is required. Give users a reason to look at your project. For most projects though, this description has no impact.
- **Force Console Compatibility**{:.ui-keyword}: When enabled, Beacon will turn off any enabled mods listed in the **Steam Only**{:.ui-keyword} section of the mods picker. Custom mods created within the **Blueprints**{:.ui-keyword} section are **not** affected by this setting.
- **Windows Store Compatibility**{:.ui-keyword}: The Windows Store version of Ark uses a different section header in its `Game.ini` file.
    - *Automatic*: In most cases, Beacon will detect and use the correct header automatically.
    - *Never*: Always use the `[/script/shootergame.shootergamemode]` header used by most versions of Ark.
    - *Always*: Always use the `[ShooterGameMode_Options]` used by the Windows Store version of Ark.
- **Compress Project**{:.ui-keyword}: Beacon projects can get pretty large, so this option will compress the project to save disk space and make project sharing easier. *This setting has no effect on cloud projects*. When turned off, the Beacon project will be saved as a plain text JSON file.
- **Allow USC-2 Files**{:.ui-keyword}: If you use certain characters or symbols in your server name or message of the day, the `GameUserSettings.ini` must be saved with an encoding called UCS-2. The problem with UCS-2 is that most text editors do not understand it, so making changes to the file will usually break the file, which then causes a server reset. By default, Beacon will remove characters that would require this UCS-2 encoding. Turning this option on will allow Beacon to produce UCS-2 encoded files *only when necessary*.

### UCS-2 Technical Details

UCS-2 is essentially an obsolete form of UTF-16. UCS-2 uses 2 bytes for every character, while UTF-16 uses at least 2 bytes for every character, up to 4 bytes when necessary.

Beacon's UCS-2 files are little-endian, with a byte order mark of 0xFFFE, though Beacon can correctly understand UCS-2BE, UTF-16LE, and UTF-16BE files as well.

{% include affectedkeys.html %}