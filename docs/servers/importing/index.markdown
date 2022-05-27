---
title: Importing an Existing Config
parent: Server Management
nav_order: 0
---
# {{page.title}}
Importing is a very powerful feature of Beacon. For Nitrado and FTP servers, importing provides a way to link a server to a project to enable Beacon's deploy feature. For everybody else, importing is a way to bring existing config data into Beacon so you don't start from scratch.

To start, create a new Beacon project and press the import button in the project toolbar. You'll be asked where you want to import from.

{% include image.html file="importwindow.png" file2x="importwindow@2x.png" caption="Beacon's import window allows you to import from Nitrado, GameServerApp.com, FTP, local files, or other Beacon projects." %}

### Nitrado
This option will prompt for your Nitrado username and password on Nitrado's website and allow you to grant Beacon access to your servers.

> Your username and password are never available to Beacon or its developer.

After you sign in, your Ark servers will be listed. Simply check off the servers you want to import and continue. Cluster servers should often be imported into the same project.

### GameServerApp.com
To connect a Beacon project to GameServerApp.com, you must first generate an API token from [the GameServerApp.com dashboard](https://dash.gameserverapp.com/configure/api). Keep this token safe, it is essentially a password to your GameServerApp.com account. You will not be able to retrieve the token later, only revoke or replace it. Paste your token into the large space, and just for organization, give a name to the token. Most projects will only have one token, but a good name will help should another GameServerApp.com account need to be linked to the project.

> Community member MooseJuice has a video about [linking a GameServerApp.com template to Beacon](https://youtu.be/N35NyETlY6w).

### Single Player, Local Files, or Copy + Paste
If your server does not support FTP - which most console servers do not - then you can manually import your files. The next screen will allow you to input the contents of your Game.ini and GameUserSettings.ini files. You do not need to import both, but Beacon can do a better job with both. When selecting a file or using drag-and-drop, Beacon will automatically look for the sibling file. So if you add Game.ini, Beacon will try to import GameUserSettings.ini too. Unfortunately, if you're using copy and paste.

> Mac users: due to macOS sandboxing, Beacon cannot automatically import the sibling config file. Instead, you'll be prompted to select it yourself. You may cancel the file selection dialog without harm.

### Server With FTP Access
If your server has FTP (File Transfer Protocol) access, Beacon can import the config files from your server directly. Beacon supports password-based plain FTP, FTP with TLS/SSL, and SFTP. After you enter your server details, Beacon will attempt to automatically find your config files. If it cannot find them, you'll be presented with your server's file list where you can find your Game.ini file.

### Other Beacon Project
Beacon can even import config parts from other projects. So if you've setup your project but found a loot drop setup in the project library that you'd like to use, you can just select the "Other Beacon Pocument" and choose to import only loot drops from the other project.

## When Parsing Finishes

Beacon will spend a little time parsing your ini files. Once finished, you will be presented with list of pieces that can be imported into your project.

{% include image.html file="importresults.png" file2x="importresults@2x.png" caption="The import results window has lots of pieces." %}

In this example, 5 servers in a cluster have been imported, so there is a lot of information here. When importing from multiple servers, Beacon will prefix each item name with the server name it came from.

It's a very good idea to review the pieces before accepting the import, so you understand exactly what changes will be made.

The results list is split into three columns:

- **Editor**: The name of a component discovered and the server it was discovered from. When importing only one server, the server name will be omitted. See below for a brief explanation about each component type.
- **Config Set**: If a component is checked to be imported, this menu allows selecting the config set to import it into. Config sets are a way to build groups of changes that can be applied to groups of servers to make it easier to manage the similarities and differences between servers in a cluster. For more detailed information about config sets, see the [Using Config Sets](/core/configsets/) article.
- **Merge**: If a component already exists inside the destination config set, this menu allows you to choose what should happen in the case of a conflict. The default mode, *Merge, new config takes priority*, will use the new settings being imported when resolving conflicts, such as two crafting recipes for the same item. *Merge, current config takes priority* will use skip over anything in the imported settings that already exist in the project. *Replace* will completely remove the component and replace it with the component being imported, potentially discarding project settings. Not all components can be merged, in which case only the merge options *Replace* and *Do not import* will be available.

### Basic Config Groups, Such as Loot Drops and Crafting Costs
Settings in Beacon are grouped together for convenience. The names here match the names in Beacon's editor selector, on the left side of your project.

### Server Link, File Link, or Template Link Items
These items allow Beacon to enable its deploy feature. By linking your server to Beacon, it can automatically put changes back onto your server. Read more about Beacon's deploy feature in [Updating Your Server With Deploy](/servers/deploy/).

### Add/Remove Map Items
When Beacon has figured out which map (or maps in the case of multiple servers) your server uses, it'll offer the ability to change the selected maps.

### Add/Remove Mod Items
Beacon will look at the server's `ActiveMods` setting and when suggest changes to the project's mods picker to improve compatibility with your server.

### Custom Config Items
This group contains all the lines not directly supported by Beacon. This may or may not be what you want, depending on how you intend to use Beacon.

When Beacon updates an ini file, the order of precedence is:

1. Directly supported configs, like loot drops, stack sizes, and crafting costs.
2. Custom config.
3. Content in ini file being updated.

This means that if your whole config is stored in Beacon, then you change or remove a setting outside of Beacon, such as with your host's control panel, Beacon will change that setting back during its next deployment.

Therefore, if you intend to use Beacon as your only config editor, it is generally convenient to import your Custom Config. However, if you want to continue to use your host's control panel or another tool such as ASM, importing Custom Config lines can become a source of confusion and frustration.

> If you import a Custom Config item and later decide you do not want it, see [How to Stop Using Custom Config](../troubleshooting/customconfig.markdown) for instructions.