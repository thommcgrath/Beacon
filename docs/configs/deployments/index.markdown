---
title: Servers
parent: Config Editors
configkeys:
  - ServerPassword
  - SpectatorPassword
  - ServerAdminPassword
  - MessageOfTheDay.Message
  - MessageOfTheDay.Duration
---
{% include editortitle.markdown %}

The servers editor is one of the most important areas of Beacon, having a significant impact on the ini context prepared for a server.

{% include image.html file="full.png" file2x="full@2x.png" caption="This is where you'll edit the details for each server." %}

## The Servers List

The list on the left is every server connected to your project.[^1] There is a **New Server**{:.ui-keyword} button at the top of the list, but that will only create a "local" server. That is, a pair of `Game.ini` and `GameUserSettings.ini` on your computer. For Nitrado, GameServerApp.com, and FTP servers, see [Importing an Existing Config](/servers/importing/) to add them to this list.

This list has a handful of useful information, including the server names and their addresses. Since server names can become very long and repetitive, Beacon has a way to improve this list's readability if you need it.

### View Options

In the **View Options**{:.ui-keyword} menu, the **Use Abbreviated Server Names**{:.ui-keyword} option will look at what is common between all servers in the list, and show only the unique pieces. You can see it in action here:

{% include image.html file="viewmodes_animated.gif" file2x="viewmodes_animated@2x.gif" caption="Turning on abbreviated server names can make the list much more readable for long server names." %}

### Server Colors

Purely for organization, a color can be assigned to each server. For a project with just a few servers, this probably isn't something you'll ever use. But if the cluster grows large the colors can come in handy, such as marking PvP and PvE servers differently.

{% include image.html file="colors.png" file2x="colors@2x.png" caption="The server color picker" %}

The selected color will appear as a strip on the right side of the server in this list and in the [Deploy](/servers/deploy) window. In the **View Options**{:.ui-keyword} menu, the list can be sorted by color to show like-colored servers together.

[^1]: Beacon calls every pair of `Game.ini` and `GameUserSettings.ini` files a server, even single player and non-dedicated sessions.

### Backups

When using the **Back up Game.ini and GameUserSettings.ini before making changes**{:.ui-keyword} option of [Deploy](/servers/deploy/), those backups can be accessed from the server list. Right-click a server and choose the **Show Config Backups**{:.ui-keyword} option to reveal the backups for the server.

{% include image.html file="contextmenu.png" file2x="contextmenu@2x.png" caption="Right-clicking a server allows revealing the backups for the server." %}

## The **General**{:.ui-keyword} Tab

This is where most of the magic happens.

### Basic Settings

- **Server Name**{:.ui-keyword}: This is the name of the server you want to appear in the in-game server browser.
- **Color**{:.ui-keyword}: This is the color picker, explained in the [paragraph above](#server-colors).

### Generator Settings

- **Config Sets**{:.ui-keyword}: When using the [Config Sets](/core/configsets/) feature, this is where you can choose which config sets are used by the server. Change the setting using the **Choose…**{:.ui-keyword} button to the right.
- **Build Config For**{:.ui-keyword}: A project can be set to support multiple maps, but traditionally a server runs only one map. This menu tells Beacon which map to build the file for. The "All Maps" option can be used in the rare case of a single pair of ini files being used for multiple servers.
  
  **Note**: Nitrado servers will not have this menu because Beacon can determine the server's map automatically.

### Message of the Day

In this space, you can edit the server's Message of the Day, or MOTD for short. Ark supports coloring different parts of the message, which can be done in Beacon. The background of the field approximates the color used by Ark's MOTD background in-game, to help you pick good colors.

{% include image.html file="motd.png" file2x="motd@2x.png" caption="The Message of the Day field allows editing the message with colors." %}

To assign a color to a word or multiple words, select what you would like to change and press the paintbrush icon in the top left.

In the top right corner is an eye button, which allows switch between WYSIWYG[^2] mode and plain mode.

{% include image.html file="motd_raw.png" file2x="motd_raw@2x.png" caption="If doing it the Ark way is more your thing, that's an option too." %}

You can switch modes as much as you like.

**There are some things you should not do with your Message of the Day!** Thanks to an [Ark bug](https://usebeacon.app/blog/motd_bug), you need to avoid slashes in your message. These are most commonly used in Discord invite urls. For example, `discord.gg/hTKzmak` or `https://discord.gg/hTKzmak` will both cause your message to be cut short. Ark will see the slash in the link as a color closing tag, get confused, and stop the message short. Most admins will choose to do something like `Discord hTKzmak` instead.
{:.important}

[^2]: What You See Is What You Get.

### Passwords

All three password fields have a switch to their left. If turned off, Beacon will not include the password, falling back instead to [Custom Config](/configs/customcontent/). For example, you might have `ServerAdminPassword=12345` defined in your Custom Config editor. If the switch next to **Admin Password**{:.ui-keyword} is turned off, the server's admin password would be `12345`. If it is turned on, the admin password would be the value in the field. If the switch is off and Custom Config does not have a `ServerAdminPassword` value, then the server would have no admin password unless it's already defined in the `GameUserSettings.ini` being deployed or exported to.

- **Admin Password**{:.ui-keyword}: This is the password required to use cheat commands.
- **Server Password**{:.ui-keyword}: This is the password required to join the server.
- **Spectator Password**{:.ui-keyword}: This is the password required to enter spectator mode.

## The Middle Tab

No it's not actually called middle. The tab tab between **General**{:.ui-keyword} and **Notes**{:.ui-keyword} changes depending on the type of server.

### FTP Servers: **Connection**{:.ui-keyword}

These fields are the connection information for the FTP server. They will match what was used during the import process, so changing the values here is only necessary if something about the server has changed.

> **Tip**: Do not use the **Autodetect**{:.ui-keyword} option for the **Mode**{:.ui-keyword} unless you have to. It will be slower and require Beacon to attempt each mode until it finds a connection.

### Local Servers: **Files**{:.ui-keyword}

There are two fields to choose the location of the `Game.ini` and `GameUserSettings.ini` files. When both files are selected, Beacon will allow its [Deploy](/servers/deploy/) feature to work for the server.

When using Beacon's [Export](/servers/exporting/) feature, if this server is selected in the **Server**{:.ui-keyword} menu, Beacon will automatically read these files and show the finished version. This will not affect the functionality of the **Smart Copy**{:.ui-keyword} and **Smart Save**{:.ui-keyword} features.

### Nitrado and GameServerApp.com

These servers do not have a middle tab.

## The **Notes**{:.ui-keyword} Tab

The **Notes**{:.ui-keyword} tab is just a simple note pad that gets kept with the server. Use it however you like.

## Security

The Servers editor contains lots of sensitive data, including passwords and authorization tokens. For that reason, everything in this editor is stored within the project's encrypted data. Only the author (and other authorized users) will see anything in this section. To every other user, the list will appear empty.

{% include affectedkeys.html %}