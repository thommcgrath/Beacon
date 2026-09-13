---
title: How to Stop Using the Custom Config Editor
parent: Other Guides
redirect_from:
  - /how_to_stop_using_custom_content
---
# {{page.title}}

> **Follow this guide carefully**. Failure to do so could result in Beacon clearing your server's ini files. While Beacon does make a backup of config files before deployment, it would be better not to need them.

### 1. Restore "Custom Config" to Default

Right click the **Custom Config**{:.ui-keyword} item in the editors list of your Beacon project file, then choose **Restore "Custom Config" to Default**{:.ui-keyword}. Beacon will ask you to confirm, which you should accept. Save your project.

### 2. Remove [Beacon] Groups from Config Files.

Beacon adds a `[Beacon]` group to both **Game.ini** and **GameUserSettings.ini** files. The group informs Beacon which changes it previously made so it can make the correct changes during the next deployment.

You must remove the group and its contents from both config files on your server.

For example, an example GameUserSettings.ini might look like:

```ini
[Beacon]
ManagedKeys['ServerSettings']=(DifficultyOffset,OverrideOfficialDifficulty,XPMultiplier)
ManagedKeys['SessionSettings']=(SessionName)
Version=1.1.1

[ServerSettings]
DifficultyOffset=1
OverrideOfficialDifficulty=5
XPMultiplier=1.0

[SessionSettings]
SessionName=My Sample Server
```

After removing the `[Beacon]` group, the GameUserSettings.ini would look like:

```ini
[ServerSettings]
DifficultyOffset=1
OverrideOfficialDifficulty=5
XPMultiplier=1.0

[SessionSettings]
SessionName=My Sample Server
```

## Finished

When you deploy again, Beacon will only make changes to the config editors you're using in Beacon. Your other ini lines will be left alone.

Beacon will add a new `[Beacon]` group to each of your files, this is normal and ok.
