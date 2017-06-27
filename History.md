# Beacon Version History

## Build 15 (Beta 8)

**_Important_** This build has a significant amount of refinements to its config generation code. Most notably, it no longer generates two config entries for every item set entry. This was done previously to counteract Ark's odd selection system. This caused other problems, such as preventing the "Prevent Duplicates" option from working correctly.

It is **very strongly recommended** that users not only rebuild their configs, but also inspect some of their item set entries. There is a new "Simulation" section in the entry editor that will give you an idea of how Ark will pick its loot. There is a very good chance this will not be what you expect, so adjustments to your file are likely necessary.

### Custom Items

Beacon has changed from using class strings (such as PrimalItemResource_Wood_C) to blueprint paths. For most documents, this will be an inconsequential change. For documents using custom/mod engrams, there are two side effects:

1. Most importantly, since blueprint paths are unique, there is no possibility of conflict. There are some mods will share the same class strings which confuses Ark's loot generation. Using blueprint paths solves this issue.
2. Beacon *must* have a blueprint path for each item. Since custom items were only supplied with class strings in the past, this means Beacon cannot generate a proper config for documents which have custom items. So Beacon has a new "problem resolution" dialog which will alert authors for problems such as this. The solution is to simply paste in cheat/spawn codes. Beacon will extract what it needs automatically.

Despite these changes, the Beacon document format remains backwards compatible.

### Library

The "Preset Library" has been moved into a new "Library" window. In addition to the presets previously available, the Library now contains a document browser and engram manager.

The document browser allows users to discover popular configurations, publish their own, or unpublish previously published documents.

The engram manager allows users to import lists of spawn/cheat codes to maintain a persistent list of custom items. The import process will attempt to guess at item names, but users can adjust the name and other settings.

### Preset Updates

Presets can now specify The Center and Ragnarok as targets. Right-clicking one or more entries in the preset editor will bring up a menu option "Create Blueprint Entry" which will set all the selected blueprint chances to 0% and create a new entry with all the blueprintable engrams at 100% chance. The purpose of this is to act closer to Ark's default loot system. This feature may introduce multiple blueprint entries to keep the items properly contained within their selected maps.

### The Center & Ragnarok

Because these maps use the same loot sources as The Island (with some exceptions) the switcher at the top of the Loot Sources list now directs how presets will build their contents.

Here's an example of what this means. The Mantis is available on Scorched Earth and Ragnarok, so its kibble should only be available on those two maps. However, Ragnarok uses The Island's loot sources. So, if adding the "Dino Consumables" preset to the "Island White (Level 3)" loot source with "The Island" selected, "Kibble (Mantis Egg)" will not be included. Doing the same thing with "Ragnarok" selected will include the Mantis Egg Kibble.

Users are advised to keep this menu set to the intended map for best results.

### Other New Features & Changes

- Beacon documents and presets now format their contents nicely, making them easier to version control.
- Beacon now supports mods! Mod authors can register their mods with Beacon and manage the items within the mod for Beacon users to easily use. Just give Beacon a file of spawn codes or a URL to the codes online, and it'll try its best to parse out all the items. Mod authors may also publish their engram lists to their own servers in JSON or CSV format, and Beacon will maintain its database accordingly.
- Improved identity management. All Beacon users have an "identity" file which authenticates their online actions. Now this identity can be backed up and restored, as well as making it easy to view the identity key pair.
- Public Beacon API! Anybody can manage documents, mods, and engrams however they please. The new 'Developer Tools' window has built-in an 'API Guide' section for learning about the API, and an 'API Builder' section for generating sample API code.
- New admin spawn code list at https://beaconapp.cc/spawn/ - if Beacon knows about it, including mod items, you can find it and its spawn code here. Mod authors may even link to this from their Steam page using https://beaconapp.cc/spawn/?mod_id=<mod_id> to show only items for that mod.
- It is now possible to paste a spawn/cheat code or blueprint path into the entry editor's filter field.
- Entry editing has a new UI! Per-engram weights are now supported, and there is a new "Simulation" section. This will give you a live idea of how Ark will choose items based on your settings.
- Item Set list now allows multiple selection.

### Bug Fixes

- Fixed an issue with engrams not automatically updating.
- Improved tab order in most, if not all, views.
- Fixed some UI elements being too short on Windows.
- Default and Cancel buttons have been swapped on Windows to better match system standards.
- Beacon will swap min/max values when the maximum is less than the minimum.
- Weight values from imported configurations will be respected down to 0.0001 instead of 0.01.
- Fixed an issue with custom items appearing in the entry editor when editing an existing entry.
- Fixed bug which caused the delete confirmation to appear when cutting an item.

## Build 14 (Beta 7)

- macOS version is now compiled as a 64-bit binary. Windows will remain 32-bit for a few more months while the compiler is updated to support 64-bit debugging on Windows. More details at http://blog.xojo.com/2017/03/28/where-is-64-bit-debugging-for-windows/
- Now treating presets as documents. This means they can be saved, imported, opened, etc. independently from the preset library. The most notable change will be the lack of "Cancel" and "Save" buttons on the preset editor. The editor now uses File -> Save or Save As to save.

## Build 13 (Beta 6)

- Fixes exceptions on Windows caused by user account paths containing non-ASCII characters.
- Fixed issue preventing update checking, engram updates, document publishing, mailing list subscription, and all other online functions from working on Windows 7.
- Fixed issue with importing config files which had excess spacing around keys.

## Build 12 (Beta 5)

- Removing the special considerations for Scorched Earth desert crates. This means exporting an entire ini file is possible. Beacon will automatically adapt the loot source accordingly. Rebuilding your ini files is recommended.
- No longer possible to paste duplicate item sets into loot sources. This would end up hiding the sets entirely, only to become visible in the export. Beacon will automatically clean up loot sources which might have been affected by this in the past.

[Developer note regarding the desert loot crates] I had previously concluded, based on Google search results, that SE desert crates and Island deep sea crates used the same class string. It turns out this is incorrect, so all the special workarounds I implemented needed to be removed. My thanks to Ark Community member Gumballz who pointed this out to me. The correct information was right in front of my in the dev kit, and I just didn't notice.

## Build 11 (Beta 4)

- Now offers to subscribe users to the Beacon Announce mailing list. This only happens during the first launch, the dialog will never be seen a second time.
- Special considerations are now made for the desert loot crates in Scorched Earth. Most users will never notice anything peculiar about this loot source. However, in order to support this particular crate, exporting both The Island and Scorched Earth configs at the same time is no longer possible.
- Fixed loot source color and sort order of duplicated sources.
- Fixing bug with showing the engram database date incorrectly on Windows.
- About window now has a button to update engrams automatically. This should still happen automatically at startup, but the button will provide confirmation of success or failure.
- Added offline logging to help track down certain bugs. This is stored in %AppData%\The ZAZ\Beacon on Windows or ~/Library/Application Support/The ZAZ/Beacon on macOS.

## Build 10 (Beta 3)

- About window now shows when the engram database was last updated.
- Now possible to import engram definitions. If for some reason your copy of Beacon cannot update definitions automatically, they can be downloaded from the Beacon website and imported using the Import menu item. See https://beaconapp.cc/ to download definitions.
- Deleting a loot source or item set now has a confirmation dialog.
- Adding custom loot icons for the boss sources.

## Build 9 (Beta 2)

*All user should rebuild their configs using this version. Quality values were not correct in previous builds.*

- Now possible to duplicate a preset.
- Entry editor engram list will correctly sort on the checkbox column.
- Item set entries can now be double-clicked to edit.
- Added steppers to item set min and max fields.
- Item sets will correctly default to NumItemSetsPower=1 rather than 0.
- Fixed critical issue where Beacon was truncating the decimals from loot source multipliers.
- Fixed exception caused by trying to create a new preset from an item set that was previously created from a preset which no longer exists.

## Build 8 (Beta 1)

- Loot source list now includes icons and can be filtered to show all sources, island sources, or scorched sources.
- New loot source wizard. Selecting a defined source is clearer, allows adding presets while adding a loot source. Custom loot sources now have a full range of settings available to ensure proper loot calculation on export.
- Editing multiple entries is now much nicer, as the "edit" checkboxes will default to off, and automatically enable when changing a setting.
- No longer possible to set an entry's blueprint chance if no blueprint exists for the engram.
- Exporting no longer creates set entries for blueprints if the engram has no blueprint.
- It is now possible to change the engrams in a set entry.
- When adding multiple engrams, it is now possible to choose between creating one entry per engram (the previous behavior) or adding all engrams to a single entry. This is useful, for example, to include both a Quetzal Saddle and Quetzal Platform Saddle in the same entry so the game will pick one or the other, but not both.
- Added increased resolution icons, supporting Windows scaling settings up to 300%.
- Loot sources are now sorted by design instead of alphabetically.
- Built-in presets are now updated automatically by the server.
- Editing or duplicating a loot source allows the item sets added by a preset to be reconfigured. This is useful when duplicating a standard beacon into a bonus beacon, for example, as it will adjust qualities and quantities accordingly.
- Item sets now know which preset defined them. This allows an item set to be renamed, but can still be reconfigured by the loot source wizard without altering the other settings such as name and weight.
- Improved engram lookup speed, which should make the loading files faster.
- Added right-click option to reconfigure item sets from their preset.
- Set entries list now supports multiple item copy and paste.
- Added "Preset Library" to the "Window" menu, which is used for managing presets.
- Option/Alt while selecting a preset from a menu will no longer trigger an edit action. Instead, edit presets from the preset library.
- New per-item options for presets to prevent modification of quality and or quantity based on the loot source.

## Build 7 (Alpha 7)

- Fixing cast issue with importing from text.

## Build 6 (Alpha 6)

- Added missing items to presets: night vision goggles, tapejara saddle, metal sword, pike, water jar, and canteen.
- Added new presets: SCUBA Gear, Player Consumables, and Dino Consumables.
- Now possible to unpublish previously published documents.
- Fixed bug causing imported configurations to have their quality scaled too low.
- Local database of loot sources and engrams is now automatically updated online.
- Missing items added to engram database: Tapejara Egg, and Archaeopteryx Egg.

## Build 5 (Alpha 5)

- Fixed KeyNotFoundExceptions on subsequent launches for some users.

## Build 4 (Alpha 4)

- Fixed crash while importing an empty config.
- A beacon is know known as a loot source, since Beacon works for more than just beacons.
- UI elements will be sized nicer on each platform.
- It is now possible to edit multiple loot sources at the same time. Select multiple loot sources and only the sets common to all selected sources will be shown. Adding, editing, and removing sets will affect the all selected loot sources.
- Set entry sorting is now correct.
- It is now possible to create, edit, and customize presets! This is a power user feature, so it is hidden, but possible. First, setup an item set in any beacon. Include all possible items for both The Island and Scorched Earth. Right-click the set in the list and choose "Create Preset" to show the editor dialog. From here, items can be unchecked to exclude them from each map. More details available on the edit dialog itself. To edit a preset, hold the Option/Alt key while selecting the preset from the "Add Item Set" menu.
- Introducing document sharing! This couldn't be simpler. Just open your Beacon document and choose "Publish Document…" from the "Document" menu. Give the document a title and description, that's it! The document will be stored online and a shareable URL will be returned. Need to make changes? Just publish again, the URL will stay the same!
- Hidden multipliers for all loot sources are now known. Thanks to https://survivetheark.com/index.php?/profile/290980-qowyn/ for the missing Scorched Earth multipliers.

## Build 3 (Alpha 3)

- Now supports copy & paste. Users can now copy a beacon and paste it into another document or even directly into their text editor. When pasting into a text editor, the text is a properly constructed ConfigOverrideSupplyCrateItems line ready for use. It is also possible to go in the opposite direction. Copy a ConfigOverrideSupplyCrateItems line from a text editor and paste into Beacon.
- Fixed an artificial minimum quality.
- Updated document format for more future-proofing.
- Added application and document icons.
- Added Tapejara Saddle to known engrams database.
- Beacon can now check for updates.
- Added three new quality options. Careful with these, they will produce some very powerful gear. The current Ascendant multiplier is 7. The new multipliers are Epic (9), Legendary (12), and Pearlescent (16).
- Quality values will no longer change when moving a beacon from one location to another.
- Changed how blueprints are handled. This will prevent excessive blueprints found in loot sources.
- Added "Report a Problem" to the Help/Application menu.

## Build 2 (Alpha 2)

- Added "Import Config" under the File menu. An existing Game.ini file can be imported into Beacon. A new beacon document will be created from it which can be customized, saved, and exported again. This process will parse all ConfigOverrideSupplyCrateItems lines in the file.
- Multiple set entries can be edited at the same time. Simply select multiple lines with shift or control/command, and press edit. Checkboxes on the right of each value allow users to edit only the intended values.
- Multiple set entries can be added at the same time. Adding an entry now uses checkboxes in the class list. Simply check off multiple classes and all will be added when the process is complete.
- Added a footer bar as an alternative means of control.
- Clicking the "+" button in the beacon list will bring up the "Add Beacon" dialog. Holding the "+" will bring up an "Add Beacon" menu. This new menu has a power user option at the bottom called "New Custom Beacon" which does exactly what it sounds like.
- Like adding a beacon, adding a set to a beacon can be done with a click or a hold action. Clicking adds a new empty set, holding presents the preset menu.
- Beacon now knows some of the hidden quality multipliers of the loot crates themselves. This information will be used to craft quality values specific to the loot crate being edited. The set entry list now uses quality names such as Primitive, Ramshackle, etc. instead of the raw quality values.
- Quality values have been adjusted. The last build used the values from the wiki, which appear to be too high. Thanks to extensive testing from Reddit user Hickey464.
- Fixed all saddles presets missing a value. The result caused all saddles to use their weight value as the max quality, and max quality value as min quality.
- Added an About window.
- All known loot sources have been defined.

## Build 1 (Alpha 1)

Initial release