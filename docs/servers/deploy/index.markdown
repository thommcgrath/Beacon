---
title: Updating Your Server With Deploy
parent: Server Management
nav_order: 1
---
# {{page.title}}

Beacon's deploy feature is a powerful tool to help update your servers quickly and correctly. Deploy can be used with Nitrado, GameServerApp.com, and FTP servers, as well as local ini files on your computer. If your server is not one of these types, see [Updating Your Server With Export](/servers/exporting/) instead.

### Supported Features

Not every server connection type supports all deploy features.

| Feature | Nitrado | GSA | FTP | Local |
| -- | -- | -- | -- | -- |
| Start / Stop | Yes | No | No | No |
| Launch Options | Yes | Yes | No | No |
| Backups | Yes | Yes | Yes | Yes |

## Getting Started

Press the _Deploy_ button in the Project Toolbar. It has a rocketship icon. You will be presented with a list of deploy-capable servers.

> If you are told you have no servers ready for deploy, see [Importing an Existing Config](/servers/importing/) for getting your server (or servers) connected to your Beacon project.

{% include image.html file="options.png" file2x="options@2x.png" caption="Beginning your deploy and choosing options." %}

There three important options to consider at this step:
- **Back up Game.ini and GameUserSettings.ini before making changes**: Beacon will keep a perfect copy of your two ini files before it makes any changes to the server. For Nitrado servers, it will also create a Configuration Profile. **You are advised to keep this option turned on**. If creating a support ticket from within Beacon, these backups are included and can be invaluable at diagnosing problems.
- **Erase server Game.ini and GameUserSettings.ini files**: In a normal deploy, Beacon will download the ini files from a server and make changes to them. With this option, Beacon will download the ini files for backup purposes only, but will ignore them when building the new ini files. For this reason, the backup feature **must** be turned on.
- **Allow me to review changes before updating server**: After generating the new ini files, Beacon will show you the exact files it will upload to the server, requiring you to check a box before upload.

Press the _Begin_ button to start the deploy. If any of your servers support start & stop, Beacon will ask for a stop message.

{% include image.html file="stopmessage.png" file2x="stopmessage@2x.png" caption="Beacon supports a stop message, but it doesn't always work." %}

> **Nitrado Servers**: Nitrado gives Beacon the means to show a stop message, but it often does not actually show up in-game. We've worked with Nitrado on the issue, but even they cannot figure out why this happens. It works for some servers, and not for others. We think it has something to do with the server name, but we haven't figured out exactly what causes it.

### Watch the Deploy Steps

Clicking on a server in the list on the left shows the steps Beacon has taken.

### Review Files if Requested

If the _Allow me to review changes before updating server_ option was turned on, this is the when Beacon will show you the new ini files it wants to upload.

{% include image.html file="review.png" file2x="review@2x.png" caption="If the review option was turned on, you will be given a chance to confirm the files look good before continuing the process." %}

If you're satisfied with the files, check the _Both config files are correct_ box and then _Approve_. Otherwise, press _Cancel_ and the deploy process stops for that server only.

## Finishing Up

If all went well, Beacon will report success.

{% include image.html file="finished.png" file2x="finished@2x.png" caption="All servers deployed correctly." %}

If there are errors, review the log messages by choosing the server (or servers) on the left.

## Nitrado Server Notes

- Beacon can update Nitrado servers even if they are not in expert mode. However, some changes will require export mode be turned on. Beacon knows what these changes are and will ask you for permission turning on expert mode. It will do this safely by performing a restart to ensure your latest control panel changes are present in your ini files.
- Nitrado tech support recommends waiting 5 minutes after the server has stopped before updating the ini files. Beacon waits 3 minutes, or the server's configured shutdown time, whichever is longer.

## Tips and Troubleshooting

- After uploading a file, Beacon will immediately download it again to compare what is on the server. If the server's file does not match what Beacon sent it, it will try the upload and verify cycle twice more. If after three tries the file still does not match, Beacon will report the error "Could not upload <the file> and verify its content is correct on the server." Some FTP servers will allow downloading of the ini files, but will ignore uploaded files. You will need to work with your host to figure out why the files are not being saved correctly.