# Beacon Version History

## Build 6

- Added missing items to presets: night vision goggles, tapejara saddle, metal sword, pike, water jar, and canteen.
- Added new presets: SCUBA Gear, Player Consumables, and Dino Consumables.
- Now possible to unpublish previously published documents.
- Fixed bug causing imported configurations to have their quality scaled too low.
- Local database of loot sources and engrams is now automatically updated online.
- Missing items added to engram database: Tapejara Egg, and Archaeopteryx Egg.

## Build 5

- Fixed KeyNotFoundExceptions on subsequent launches for some users.

## Build 4

- Fixed crash while importing an empty config.
- A beacon is know known as a loot source, since Beacon works for more than just beacons.
- UI elements will be sized nicer on each platform.
- It is now possible to edit multiple loot sources at the same time. Select multiple loot sources and only the sets common to all selected sources will be shown. Adding, editing, and removing sets will affect the all selected loot sources.
- Set entry sorting is now correct.
- It is now possible to create, edit, and customize presets! This is a power user feature, so it is hidden, but possible. First, setup an item set in any beacon. Include all possible items for both The Island and Scorched Earth. Right-click the set in the list and choose "Create Preset" to show the editor dialog. From here, items can be unchecked to exclude them from each map. More details available on the edit dialog itself. To edit a preset, hold the Option/Alt key while selecting the preset from the "Add Item Set" menu.
- Introducing document sharing! This couldn't be simpler. Just open your Beacon document and choose "Publish Document…" from the "Document" menu. Give the document a title and description, that's it! The document will be stored online and a shareable URL will be returned. Need to make changes? Just publish again, the URL will stay the same!
- Hidden multipliers for all loot sources are now known. Thanks to https://survivetheark.com/index.php?/profile/290980-qowyn/ for the missing Scorched Earth multipliers.

## Build 3

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

## Build 2

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

## Build 1

Initial release