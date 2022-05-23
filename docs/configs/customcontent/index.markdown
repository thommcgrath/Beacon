---
title: Custom Config
parent: Config Editors
---
{% include editortitle.markdown %}

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

> In Beacon 1.5 and later, [config sets](/core/configsets) are an easier way to achieve server-specific values. The features described below still work though.

The _Custom Config_ editor allows admins to create content that is placed on only certain servers. This is an advanced feature that requires using the automated deployment options.

The editor supports blocks surrounded in `#Server` and `#End` tags. For example

```ini
StructureResistanceMultiplier=0.0

#Server abcd1234
ServerCrosshair=True
#End
```

Would place the `StructureResistanceMultiplier` on all servers, but `ServerCrosshair` would only be included for server `abcd1234`.

To find a server's identifier, switch to the [Servers editor](/configs/deployments/) in Beacon. Underneath each server name in the list will be both the server identifier and its address. Right-click a server and choose _Copy Profile ID_ to quickly copy the identifier to be used in your custom config content.

### Getting Advanced

It's possible to specify multiple servers at the same time by separating the identifiers with commas:

```ini
#Server abcd1234, 1234abcd
ServerCrosshair=True
#End
```

The space after the comma is optional. To make life a little easier, a `#Servers` command can be used instead. Both `#Server` and `#Servers` are fully interchangeable, the two commands exist just to assist with user memory.

Speaking of user memory, remembering which server is which can be hard. So the editor now supports comments:

```ini
// This comment isn't particularly helpful
#Servers abcd1234, 1234abcd
ServerCrosshair=True
#End
```

And it's even possible to nest code blocks, and indent if desired:

```ini
#Servers abcd1234, 1234abcd
  ServerCrosshair=True
  #Server 1234abcd
    StructureResistanceMultiplier=0.0
  #End
#End
```

### Group Inheritance

A code block will inherit the active group from its parent, but will not change the parent group if a new group is used inside.

```ini
[ServerSettings]
// Group is now ServerSettings
ServerCrosshair=True

#Server abcd1234
  // Group is still ServerSettings
  [SessionSettings]
  // Group is now SessionSettings
  SessionName=This is the name of my server
#Server

// Group is back to ServerSettings
```

{% include affectedkeys.html %}