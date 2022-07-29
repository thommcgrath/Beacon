---
title: Using Beacon with Ark Single Player
parent: Server Management
nav_order: 3
---
# {{page.title}}
Beacon is fully able to work with the `Game.ini` and `GameUserSettings.ini` files on the three PC versions of the game, but the console versions of the game provide no access to the single player ini files. The only difficulty is finding the ini files on the system.

## Import the INI Files
Start by following [these instructions](/servers/importing/) to import the current ini files into Beacon. Use the "Single Player, Local Files, or Copy + Paste" option and choose the INI files according to the instructions below.
These instructions will help users find the `Game.ini` file. In all cases, the `GameUserSettings.ini` file can be found next to the `Game.ini` file.

### Steam on Windows
The most common location of the ini files is <code>C:\<wbr>Program Files (x86)\<wbr>Steam\<wbr>steamapps\<wbr>ARK\<wbr>ShooterGame\<wbr>Saved\<wbr>Config\<wbr>WindowsNoEditor\<wbr>Game.ini</code> However, users who have installed Steam onto a different drive, have multiple Steam library folders, or are using a 32-bit system will find some differences. The easiest way to find Ark's files is to select Steam in the library, use the gear icon at the right edge of the screen, choose the "Manage" option, can choose "Browse local files." This will open Windows Explorer to Ark's folder inside its Steam library folder. Navigate to <code>ShooterGame\<wbr>Saved\<wbr>Config\<wbr>WindowsNoEditor\<wbr>Game.ini</code>

{% include image.html file="steam.png" caption="Revealing the Ark game files on Steam" %}

### Steam on Mac
The Mac version of Ark through Steam always keeps its `Game.ini` file at `~/Library/Preferences/ShooterGame/MacNoEditor/Game.ini`. The easiest way to find this folder is to use the "Go to Folder" option inside Finder's "Go" menu, and entering `~/Library/Preferences/ShooterGame/MacNoEditor`.

### Windows Store
The Windows Store version of `Game.ini` is always <code>%LocalAppData%\<wbr>Packages\<wbr>StudioWildcard.4558480580BB9_1w2mm55455e38\<wbr>LocalState\<wbr>Saved\<wbr>UWPConfig\<wbr>UWP\<wbr>Game.ini</code>. The easiest way to get to this folder is to open a new file browser, click the path bar at the top of the window, and enter <code>%LocalAppData%\<wbr>Packages\<wbr>StudioWildcard.4558480580BB9_1w2mm55455e38\<wbr>LocalState\<wbr>Saved\<wbr>UWPConfig\<wbr>UWP</code>. Users may also simply enter `%LocalAppData%` and navigate through the rest of the folders manually.

The Windows Store version of the game uses the `[ShooterGameMode_Options]` header in `Game.ini` instead of the traditional `[/script/shootergame.shootergamemode]` header used by other versions of the game. Beacon will handle this for you automatically, but you can override this behavior using the "Windows Store Compatibility" option in [Project Settings](/configs/metadata/).

### Epic Games Store
The default location for `Game.ini` for the Epic Games Store version of Ark is <code>C:\<wbr>Epic Games\<wbr>ARKSurvivalEvolved\<wbr>ShooterGame\<wbr>Saved\<wbr>Config\<wbr>WindowsNoEditor\<wbr>Game.ini</code>. However, users who have installed Epic to a different location will need to adjust this path accordingly.

## Deploy
When finished making changes, Beacon's deploy button should be used to near-instantly update both ini files. Be sure to do this with the game stopped. Be aware that any changes to the setup sliders when starting the server will change the ini files, though Ark should only change the settings actually changed, leaving the rest of the settings alone.

## A Warning About Single Player Settings
Ark uses adjusted multipliers in single player mode. See [https://ark.gamepedia.com/Single_Player](https://ark.gamepedia.com/Single_Player) for the specific changes. **Beacon computes values for multiplayer servers**, so certain calculations such as breeding times and stat multipliers will be wrong. Users can try setting "Use Single Player Settings" to off in Beacon's General Settings, however Ark usually turns the setting back on.