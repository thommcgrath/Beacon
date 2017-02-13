# Beacon Version History

## Build 11 (Beta 4)

- Now offers to subscribe users to the Beacon Announce mailing list. This only happens during the first launch, the dialog will never be seen a second time.
- Special considerations are now made for the desert loot crates in Scorched Earth. Most users will never notice anything peculiar about this loot source. However, in order to support this particular crate, exporting both The Island and Scorched Earth configs at the same time is no longer possible.
- Fixed loot source color and sort order of duplicated sources.
- Fixing bug with showing the engram database date incorrectly on Windows.
- About window now has a button to update engrams automatically. This should still happen automatically at startup, but the button will provide confirmation of success or failure.
- Added offline logging to help track down certain bugs. This is stored in %AppData%\The ZAZ\Beacon on Windows or ~/Library/Application Support/The ZAZ/Beacon on macOS.

## Build 10 (Beta 3)

- About window now shows when the engram database was last updated.
- Now possible to import engram definitions. If for some reason your copy of Beacon cannot update definitions automatically, they can be downloaded from the Beacon website and imported using the Import menu item. See https://thezaz.com/beacon to download definitions.
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