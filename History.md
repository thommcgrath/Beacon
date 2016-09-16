# Beacon Version History

## Build 3

- Now supports copy & paste. Users can now copy a beacon and paste it into another document or even directly into their text editor. When pasting into a text editor, the text is a properly constructed ConfigOverrideSupplyCrateItems line ready for use. It is also possible to go in the opposite direction. Copy a ConfigOverrideSupplyCrateItems line from a text editor and paste into Beacon.

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