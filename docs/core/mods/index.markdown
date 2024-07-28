---
title: Game Mods in Beacon
parent: Core Features
has_children: true
nav_order: 3
redirect_from:
  - /core/blueprints/
---
# {{page.title}}

> If you find that Beacon is missing which the game supports without mods, please [let us know](/help/contact).

## The Mods Tab

{% include image.html file="mods.png" file2x="mods@2x.png" caption="The Mods tab allows browsing mod information, as well as adding new mod info to Beacon." %}

The **Mods**{:.ui-keyword} tab has a list with 5 columns:
- **Name**{:.ui-keyword}: The name of the mod.
- **Type**{:.ui-keyword}: One of the following: "Official", "Custom", "CurseForge", or "Steam Workshop". "Custom" mods are fully editable mods whose data belongs exclusively to your Beacon account. "Official" mods contain official game content that can be viewed but not edited. "CurseForge" and "Steam Workshop" mods are included with Beacon by their author or other reliable source. These are editable only if you own the mod, otherwise they are read-only.
- **Game**{:.ui-keyword}: The game the mod belongs to.
- **Mod ID**{:.ui-keyword}: The CurseForge Project ID, Steam Workshop ID, or Steam App ID for the mod.
- **Last Updated**{:.ui-keyword}: The time of the last update, in your local time zone.

To the right of the toolbar is a **Filter Mods**{:.ui-keyword} field to search your mods list, and a **Filter Mods**{:.ui-keyword} button to hide or show mods in the list. When you use the button, the **Types**{:.ui-keyword} group shows some different type options. "Custom" mods are your own mods, "Beacon-Supplied" are "Official", "CurseForge", or "Steam Workshop" mods that you do not own, and "Registered" mods are those "CurseForge" or "Steam Workshop" mods that you **do** own.

### Adding a Mod to Beacon

There are 3 ways to add a mod to Beacon, and the right way depends on several factors.

If you're the developer of the mod you want to add to Beacon, use the **Register Mod**{:.ui-keyword} toolbar item. After collecting the Mod ID, Beacon will present you with a confirmation code to temporarily add to the mod description so that ownership of your mod can be verified.

If you are not the developer of the mod, you can either use **Add Mod**{:.ui-keyword} to add the mod without any content, or **Discover Mods**{:.ui-keyword} to allow Beacon to gather mod information for you, when possible. Follow these links for more information about mod discovery:

- [Mod Discovery for Ark: Survival Ascended](/core/mods/arksa/#mod-discovery)
- [Mod Discovery for Ark: Survival Evolved](/core/mods/ark/#mod-discovery)

### Editing or Viewing Content for a Mod in Beacon

Double click a mod row, or select the row and press **Edit Blueprints**{:.ui-keyword}, to open a tab for the mod's content. See one of the guides below for Game-specific instructions.

- [Ark: Survival Ascended](/core/mods/arksa/)
- [Ark: Survival Evolved](/core/mods/ark/)

### Importing and Exporting Mod Content

Beacon's mod data can be exported for archiving or sharing. This will create a `.beacondata' file that you can store wherever you like.

> For all Beacon accounts, including anonymous accounts, Beacon backs up all mod content to the cloud. These backups are also versioned just like Beacon cloud projects.

Select one or more mods in the **Mods**{:.ui-keyword} tab, then press the **Export**{:.ui-keyword} button. You will be prompted for a location to save the file. All selected mods will be exported to the same file, so if you want one file per mod, you will have to export them one by one.

To import a data file, press the **Import**{:.ui-keyword} button in the toolbar and select a `.beacondata` file to import. This uses the same mechanism that Beacon uses to download changes to its official data, so the effects may not be immediately obvious. When the import is done, you should be able to find the mod (or mods) in the **Mods**{:.ui-keyword} list.

## The Community Tab

{% include image.html file="community.png" file2x="community@2x.png" caption="Community mods are automatically maintained by Beacon's mod discovery feature." %}

The **Community**{:.ui-keyword} tab contains a list of mod files that can be downloaded to your copy of Beacon. These are automatically uploaded by the mod discovery process when appropriate. The **Status**{:.ui-keyword} column will show either "Download" or "Update Available" for mods you have already downloaded. "Update Available" means that the results are newer than what you downloaded.

Double-click a row or select multiple rows and press **Download**{:.ui-keyword} to download and import the mod data. Beacon will open each mod tab when finished as long as you have less than 5 mods selected to download.