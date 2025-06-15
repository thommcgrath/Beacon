---
title: Custom Config
parent: "Ark: Survival Evolved"
grand_parent: Config Editors
supportedgames:
  - "Ark: Survival Evolved"
---
{% include editortitle.markdown %}

Ark server admins are able to insert additional lines to their Game.ini and GameUserSettings.ini files that Beacon does not have built-in support for.

## Using the Editor

When using the Custom Config editor, there are two tabs at the top to switch between the GameUserSettings.ini and Game.ini files. You can edit each just like a normal file.

Unlike a normal editor though, the format is much more flexible. It's entirely valid for a field to contain something simple such as:
```ini
StructureResistanceMultiplier=0.0
```
in the GameUserSettings.ini editor, and that line will automatically be added to the `[ServerSettings]` group. If that group already contains a `StructureResistanceMultiplier` line, Beacon will **replace** the line with the one in your editor.

Notice there is no group header? That's ok, Beacon assumes the common group for each file when no header is provided. This is `[ServerSettings]` for GameUserSettings.ini and `[/script/shootergame.shootergamemode]` for Game.ini. It's also possible to have multiple headers, and even duplicates. So the following content is also valid:
```ini
StructureResistanceMultiplier=0.0

[StructuresPlus]
MinWindForTurbine=1

[ServerSettings]
ServerCrosshair=True
```

When building your GameUserSettings.ini file, Beacon would output the previous content as:
```ini
[ServerSettings]
ServerCrosshair=True
StructureResistanceMultiplier=0.0

[StructuresPlus]
MinWindForTurbine=1
```

Beacon's smart rewriter automatically blends and organizes the config content correctly.

## Encrypting Content

When initially importing, Beacon automatically encrypts some keys, such as the `ServerAdminPassword` and `ServerPassword` values. In the editor, they will look like:
```ini
ServerAdminPassword=$$BeaconEncrypted$$slartibartfast$$BeaconEncrypted$$
```

The `$$BeaconEncrypted$$` tags added around the password tells Beacon to store that password with encryption. When exporting or deploying, the value will be treated normally, with no `$$BeaconEncrypted$$` tags. When saved to disk or the cloud, the content in the middle is encrypted with your personal 2048-bit RSA private key. When trying to open the file on a computer that does not have your private key, Beacon will just show the value as blank. The [About User Privacy](/accounts/privacy) page has more information about Beacon's encryption.

You can manually type the `$$BeaconEncryption$$` tags around as much or as little of the content as you like. Or you can select content and press the lock icon _Encrypt_ button to the top left of the editor, and it'll insert the tags for you.

## Launch Options

When Ark is launched on a server, its launch options will take priority over the ini options. Many hosts will include certain settings as launch options, such as `OverrideOfficialDifficulty`. When this happens, the value in GameUserSettings.ini gets updated to match. This means it is important to know which settings the host are going to set through the control panel, and which will work in the ini files.

However, as of Beacon 1.5, the _Custom Config_ editor can automatically update those launch options to match when using a supported host such as Nitrado. For example, performing a wild dino wipe at server startup is done by adding the `-ForceRespawnDinos` launch option. In Beacon, putting `ForceRespawnDinos=True` inside the `[ServerSettings]` group of GameUserSettings.ini will cause Beacon to set the option during deploy. Remember the automatic group headers above.

This works with all the launch options listed in the [Ark Config File Reference](https://ark.fandom.com/wiki/Server_configuration). Remove the `-` or `?` prefix, and add an equals sign with a value if the option does not already have one, such as the `ForceRespawnDinos` example above. Here are some more examples:

| Launch Option | Beacon Equivalent |
| -- | -- |
| ?ExtinctionEventTimeInterval=2592000 | ExtinctionEventTimeInterval=2592000 |
| ?PreventDownloadSurvivors=False | PreventDownloadSurvivors=False |
| -ForceAllowCaveFlyers | ForceAllowCaveFlyers=True |

## Per-Server Config Design

In the [Servers editor](/configs/ark/servers/), select a server, and you will see a **Custom**{:.ui-keyword} tab. This is a miniature Custom Config section that will get merged into `GameUserSettings.ini` only for that specific server. This is most useful for mod configs with server-specific identifiers, such as monitoring tools. Keys in this section take precedence over the same keys in the project's Custom Config editor. If no section header is specified, keys will be placed in `[ServerSettings]`.

For example, if your project Custom Config has the following lines:

```ini
[MyDiscordBot]
TagEveryone=True
ServerKey=DefaultPassword
```

And a server's Custom tab has

```ini
[MyDiscordBot]
ServerKey=ThisIsAPassword
```

The server's `GameUserSettings.ini` will receive

```ini
[MyDiscordBot]
TagEveryone=True
ServerKey=ThisIsAPassword
```

{% include affectedkeys.html %}