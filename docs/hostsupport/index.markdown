---
title: Host Support
nav_order: 1
---
# {{page.title}}

Beacon works with nearly any host, as long as the host provides the ability to edit the `Game.ini` and `GameUserSettings.ini` files. However, Beacon works with some hosts better than others.

## Directly Supported Hosts

Beacon supports a handful of hosts that it can communicate directly with. Not every host supports every feature, so see the feature matrix below to see which hosts supports which Beacon features. Every host listed here supports basic import and deploy, so those features are not listed here.

| Host | Start, Stop, & Status | Shutdown Message | Launch Options | Config Snapshots |
| -- | -- | -- | -- | -- |
| Nitrado | Yes | Yes[^1] | Partial[^2] | Yes |
| GameServerApp.com | No | No | Yes | No |
| GameServersPanel | Yes | No | Yes | Yes |
| ASA Manager | Yes | No | No | No |
| Beacon Open Hosting API[^3] | Yes | Yes | Yes | Yes |
| FTP & SFTP | No | No | No | No |
| Local Files | No | No | No | No |

[^1]: Nitrado claims to support a stop message, and it works for some users, but not others. We've worked directly with Nitrado to figure this out without a resolution. Beacon is sending the stop message correctly, but there's no guarantee it will actually appear in-game.
[^2]: Nitrado does not provide direct access to the game's launch options, so Beacon can only control the options Nitrado exposes.
[^3]: The Beacon Open Hosting API supports these features, but hosts that implement the API ultimately have control over these behaviors.

### Other Hosts

There are too many Ark hosts to list here individually, but if they are not listed here **assume they are compatible**. If you can copy and paste the ini files in their control panel, you can use Beacon's Smart Copy feature. Beacon will not be able to help with your launch options or starting, stopping, or restarting your servers.

## Unsupported Hosts

### GPORTAL

GPORTAL, while popular, has a few bad behaviors that do not work well with Beacon. GPORTAL has trouble correctly parsing Ark ini files, such as treating the keys as case-sensitive and getting confused by the `[Beacon]` section added to assist with change tracking. **At this time, it is advised not to use Beacon with GPORTAL servers**.

## Supporting More Hosts

If you are a hosting provider, consider implementing Beacon's [Open Hosting API](/hostingapi). Your users will immediately gain full import and deploy capabilities with Beacon. If this isn't practical, reach out at [get in touch](mailto:help@usebeacon.app) and we'll see what we can do.