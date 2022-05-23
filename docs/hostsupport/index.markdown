---
title: Supported Hosts
nav_order: 1
---
# {{page.title}}

Beacon works with nearly any host, as long as the host provides the ability to edit the `Game.ini` and `GameUserSettings.ini` files. However, Beacon works with some hosts better than others.

### Nitrado

Nitrado and Beacon work better together than any other host, thanks to Nitrado's API. Beacon can discover, start, stop, and otherwise fully control Nitrado servers.

### GameServerApp.com

Beacon's has excellent support for GameServerApp.com, which allows it to update the ini files and launch options for a template. But since Beacon works with GSA templates instead of servers directly, Beacon is unable to start, stop, or restart GSA servers.

### GPORTAL

GPORTAL, while popular, has a few bad behaviors that do not work well with Beacon. GPORTAL has trouble correctly parsing Ark ini files, such as treating the keys as case-sensitive and getting confused by the `[Beacon]` section added to assist with change tracking. **At this time, it is advised not to use Beacon with GPORTAL servers**.

### Other Hosts

There are too many Ark hosts to list here individually, but if they are not listed here **assume they are compatible**. If you can copy and paste the ini files in their control panel, you can use Beacon's Smart Copy feature. Beacon will not be able to help with your launch options or starting, stopping, or restarting your servers.

## How to Support More Hosts

If you are a hosting provider with an API Beacon could use to interact with customer servers, please [get in touch](mailto:help@usebeacon.app)! We'd love to improve Beacon's support for your host. We'll support any host that has the technical capability.