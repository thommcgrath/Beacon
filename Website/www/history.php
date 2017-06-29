<?php
require($_SERVER['SITE_ROOT'] . '/framework/loader.php');
BeaconTemplate::SetTitle('Version History');
?><h1>Version History</h1>
<div class="indent">
	<h2 id="build18">Beta 10 (Build 18)</h2>
	<ul>
		<li>Beacon files finally show up with their own icon and can be used from Windows Explorer.</li>
		<li>Engrams view in the Library will refresh after importing.</li>
		<li>Recognizing more cheat/spawn codes as valid.</li>
		<li>Added support for the beacon:// url scheme to Windows.</li>
		<li>Added an option when defining custom loot sources to increase compatibility with mods that do not support blueprints in loot definitions.</li>
	</ul>
	<h2 id="build17">Beta 9 (Build 17)</h2>
	<div class="indent">
		<p>Emergency build. Had to remove the &quot;pretty&quot; JSON on Windows as it was proving to be much too slow.</p>
	</div>
	<h2 id="build16">Beta 8 (Build 16)</h2>
	<div class="indent">
		<p>This build has a significant number of refinements to its config generation code. Most notably, it no longer generates two config entries for every item set entry. This was done previously to counteract Ark's odd selection system. This caused other problems, such as preventing the "Prevent Duplicates" option from working correctly.</p>
		<p>It is <strong>very strongly recommended</strong> that users not only rebuild their configs, but also inspect some of their item set entries. There is a new "Simulation" section in the entry editor that will give you an idea of how Ark will pick its loot. There is a very good chance this will not be what you expect, so adjustments to your file are likely necessary.</p>
		<h3>Custom Items</h3>
		<div class="indent">
			<p>Beacon has changed from using class strings (such as PrimalItemResource_Wood_C) to blueprint paths. For most documents, this will be an inconsequential change. For documents using custom/mod engrams, there are two side effects:</p>
			<ol>
				<li>Most importantly, since blueprint paths are unique, there is no possibility of conflict. There are some mods which share the same class strings which confuses Ark's loot generation. Using blueprint paths solves this issue.</li>
				<li>Beacon <em>must</em> have a blueprint path for each item. Since custom items were only supplied with class strings in the past, this means Beacon cannot generate a proper config for documents which have custom items. So Beacon has a new &quot;problem resolution&quot; dialog which will alert authors for problems such as this. The solution is to simply paste in cheat/spawn codes. Beacon will extract what it needs automatically.</li>
			</ol>
			<p>Despite these changes, the Beacon document format remains backwards compatible.</p>
		</div>
		<h3>Library</h3>
		<div class="indent">
			<p>The &quot;Preset Library&quot; has been moved into a new &quot;Library&quot; window. In addition to the presets previously available, the Library now contains a document browser and engram manager.</p>
			<p>The document browser allows users to discover popular configurations, publish their own, or unpublish previously published documents.</p>
			<p>The engram manager allows users to import lists of spawn/cheat codes to maintain a persistent list of custom items. The import process will attempt to guess at item names, but users can adjust the name and other settings.</p>
		</div>
		<h3>Preset Updates</h3>
		<div class="indent">
			<p>Presets can now specify The Center and Ragnarok as targets. Right-clicking one or more entries in the preset editor will bring up a menu option &quot;Create Blueprint Entry&quot; which will set all the selected blueprint chances to 0% and create a new entry with all the blueprintable engrams at 100% chance. The purpose of this is to act closer to Ark's default loot system. This feature may introduce multiple blueprint entries to keep the items properly contained within their selected maps.</p>
		</div>
		<h3>The Center &amp; Ragnarok</h3>
		<div class="indent">
			<p>Because these maps use the same loot sources as The Island (with some exceptions) the switcher at the top of the Loot Sources list now directs how presets will build their contents.</p>
			<p>Here's an example of what this means. The Mantis is available on Scorched Earth and Ragnarok, so its kibble should only be available on those two maps. However, Ragnarok uses The Island's loot sources. So, if adding the &quot;Dino Consumables&quot; preset to the &quot;Island White (Level 3)&quot; loot source with &quot;The Island&quot; selected, &quot;Kibble (Mantis Egg)&quot; will not be included. Doing the same thing with &quot;Ragnarok&quot; selected will include the Mantis Egg Kibble.</p>
			<p>Users are advised to keep this menu set to the intended map for best results.</p>
		</div>
		<h3>Other New Features &amp; Changes</h3>
		<ul>
			<li>Beacon documents and presets now format their contents nicely, making them easier to version control.</li>
			<li>Beacon now supports mods! Mod authors can register their mods with Beacon and manage the items within the mod for Beacon users to easily use. Just give Beacon a file of spawn codes or a URL to the codes online, and it'll try its best to parse out all the items. Mod authors may also publish their engram lists to their own servers in JSON or CSV format, and Beacon will maintain its database accordingly.</li>
			<li>Improved identity management. All Beacon users have an &quot;identity&quot; file which authenticates their online actions. Now this identity can be backed up and restored, as well as making it easy to view the identity key pair.</li>
			<li>Public Beacon API! Anybody can manage documents, mods, and engrams however they please. The new &quot;Developer Tools&quot; window has built-in an &quot;API Guide&quot; section for learning about the API, and an &quot;API Builder&quot; section for generating sample API code.</li>
			<li>New admin spawn code list at <a href="https://beaconapp.cc/spawn/">https://beaconapp.cc/spawn/</a> - if Beacon knows about it, including mod items, you can find it and its spawn code here. Mod authors may even link to this from their Steam page using https://beaconapp.cc/spawn/?mod_id=&lt;mod_id&gt; to show only items for that mod.</li>
			<li>It is now possible to paste a spawn/cheat code or blueprint path into the entry editor's filter field.</li>
			<li>Entry editing has a new UI! Per-engram weights are now supported, and there is a new &quot;Simulation&quot; section. This will give you a live idea of how Ark will choose items based on your settings.</li>
			<li>Item Set list now allows multiple selection.</li>
		</ul>
		<h3>Bug Fixes</h3>
		<ul>
			<li>Fixed an issue with engrams not automatically updating.</li>
			<li>Improved tab order in most, if not all, views.</li>
			<li>Fixed some UI elements being too short on Windows.</li>
			<li>Default and Cancel buttons have been swapped on Windows to better match system standards.</li>
			<li>Beacon will swap min/max values when the maximum is less than the minimum.</li>
			<li>Weight values from imported configurations will be respected down to 0.0001 instead of 0.01.</li>
			<li>Fixed an issue with custom items not appearing in the entry editor when editing an existing entry.</li>
			<li>Fixed bug which caused the delete confirmation to appear when cutting an item.</li>
		</ul>
	</div>
	<h2 id="build14">Beta 7 (Build 14)</h2>
	<ul>
		<li>macOS version is now compiled as a 64-bit binary. Windows will remain 32-bit for a few more months while the compiler is updated to support 64-bit debugging on Windows. More details at <a href="http://blog.xojo.com/2017/03/28/where-is-64-bit-debugging-for-windows/">http://blog.xojo.com/2017/03/28/where-is-64-bit-debugging-for-windows/</a></li>
		<li>Now treating presets as documents. This means they can be saved, imported, opened, etc. independently from the preset library. The most notable change will be the lack of &quot;Cancel&quot; and &quot;Save&quot; buttons on the preset editor. The editor now uses File -> Save or Save As to save.</li>
	</ul>
	<h2 id="build13">Beta 6 (Build 13)</h2>
	<ul>
		<li>Fixes exceptions on Windows caused by user account paths containing non-ASCII characters.</li>
		<li>Fixed issue preventing update checking, engram updates, document publishing, mailing list subscription, and all other online functions from working on Windows 7.</li>
		<li>Fixed issue with importing config files which had excess spacing around keys.</li>
	</ul>
	<h2 id="build12">Beta 5 (Build 12)</h2>
	<ul>
		<li>Removing the special considerations for Scorched Earth desert crates. This means exporting an entire ini file is possible. Beacon will automatically adapt the loot source accordingly. Rebuilding your ini files is recommended.</li>
		<li>No longer possible to paste duplicate item sets into loot sources. This would end up hiding the sets entirely, only to become visible in the export. Beacon will automatically clean up loot sources which might have been affected by this in the past.</li>
	</ul>
	<div class="indent">
		<h3>Regarding the desert loot crates</h3>
		<div class="indent">
			<p>I had previously concluded, based on Google search results, that SE desert crates and Island deep sea crates used the same class string. It turns out this is incorrect, so all the special workarounds I implemented needed to be removed. My thanks to Ark Community member Gumballz who pointed this out to me. The correct information was right in front of my in the dev kit, and I just didn't notice.</p>
		</div>
	</div>
	<h2 id="build11">Beta 4 (Build 11)</h2>
	<ul>
		<li>Now offers to subscribe users to the Beacon Announce mailing list. This only happens during the first launch, the dialog will never be seen a second time.</li>
		<li>Special considerations are now made for the desert loot crates in Scorched Earth. Most users will never notice anything peculiar about this loot source. However, in order to support this particular crate, exporting both The Island and Scorched Earth configs at the same time is no longer possible.</li>
		<li>Fixed loot source color and sort order of duplicated sources.</li>
		<li>Fixing bug with showing the engram database date incorrectly on Windows.</li>
		<li>About window now has a button to update engrams automatically. This should still happen automatically at startup, but the button will provide confirmation of success or failure.</li>
		<li>Added offline logging to help track down certain bugs. This is stored in %AppData%\The ZAZ\Beacon on Windows or ~/Library/Application Support/The ZAZ/Beacon on macOS.</li>
	</ul>
	<h2 id="build10">Beta 3 (Build 10)</h2>
	<ul>
		<li>About window now shows when the engram database was last updated.</li>
		<li>Now possible to import engram definitions. If for some reason your copy of Beacon cannot update definitions automatically, they can be downloaded from the Beacon website and imported using the Import menu item. See <a href="https://beaconapp.cc/download/">https://beaconapp.cc/download/</a> to download definitions.</li>
		<li>Deleting a loot source or item set now has a confirmation dialog.</li>
		<li>Adding custom loot icons for the boss sources.</li>
	</ul>
	<h2 id="build9">Beta 2 (Build 9)</h2>
	<div class="indent">
		<p><em>All user should rebuild their configs using this version. Quality values were not correct in previous builds.</em></p>
	</div>
	<ul>
		<li>Now possible to duplicate a preset.</li>
		<li>Entry editor engram list will correctly sort on the checkbox column.</li>
		<li>Item set entries can now be double-clicked to edit.</li>
		<li>Added steppers to item set min and max fields.</li>
		<li>Item sets will correctly default to NumItemSetsPower=1 rather than 0.</li>
		<li>Fixed critical issue where Beacon was truncating the decimals from loot source multipliers.</li>
		<li>Fixed exception caused by trying to create a new preset from an item set that was previously created from a preset which no longer exists.</li>
	</ul>
	<h2 id="build8">Beta 1 (Build 8)</h2>
	<ul>
		<li>Loot source list now includes icons and can be filtered to show all sources, island sources, or scorched sources.</li>
		<li>New loot source wizard. Selecting a defined source is clearer, allows adding presets while adding a loot source. Custom loot sources now have a full range of settings available to ensure proper loot calculation on export.</li>
		<li>Editing multiple entries is now much nicer, as the &quot;edit&quot; checkboxes will default to off, and automatically enable when changing a setting.</li>
		<li>No longer possible to set an entry's blueprint chance if no blueprint exists for the engram.</li>
		<li>Exporting no longer creates set entries for blueprints if the engram has no blueprint.</li>
		<li>It is now possible to change the engrams in a set entry.</li>
		<li>When adding multiple engrams, it is now possible to choose between creating one entry per engram (the previous behavior) or adding all engrams to a single entry. This is useful, for example, to include both a Quetzal Saddle and Quetzal Platform Saddle in the same entry so the game will pick one or the other, but not both.</li>
		<li>Added increased resolution icons, supporting Windows scaling settings up to 300%.</li>
		<li>Loot sources are now sorted by design instead of alphabetically.</li>
		<li>Built-in presets are now updated automatically by the server.</li>
		<li>Editing or duplicating a loot source allows the item sets added by a preset to be reconfigured. This is useful when duplicating a standard beacon into a bonus beacon, for example, as it will adjust qualities and quantities accordingly.</li>
		<li>Item sets now know which preset defined them. This allows an item set to be renamed, but can still be reconfigured by the loot source wizard without altering the other settings such as name and weight.</li>
		<li>Improved engram lookup speed, which should make the loading files faster.</li>
		<li>Added right-click option to reconfigure item sets from their preset.</li>
		<li>Set entries list now supports multiple item copy and paste.</li>
		<li>Added &quot;Preset Library&quot; to the &quot;Window&quot; menu, which is used for managing presets.</li>
		<li>Option/Alt while selecting a preset from a menu will no longer trigger an edit action. Instead, edit presets from the preset library.</li>
		<li>New per-item options for presets to prevent modification of quality and or quantity based on the loot source.</li>
	</ul>
	<h2 id="build7">Alpha 7 (Build 7)</h2>
	<ul>
		<li>Fixing cast issue with importing from text.</li>
	</ul>
	<h2 id="build6">Alpha 6 (Build 6)</h2>
	<ul>
		<li>Added missing items to presets: night vision goggles, tapejara saddle, metal sword, pike, water jar, and canteen.</li>
		<li>Added new presets: SCUBA Gear, Player Consumables, and Dino Consumables.</li>
		<li>Now possible to unpublish previously published documents.</li>
		<li>Fixed bug causing imported configurations to have their quality scaled too low.</li>
		<li>Local database of loot sources and engrams is now automatically updated online.</li>
		<li>Missing items added to engram database: Tapejara Egg, and Archaeopteryx Egg.</li>
	</ul>
	<h2 id="build5">Alpha 5 (Build 5)</h2>
	<ul>
		<li>Fixed KeyNotFoundExceptions on subsequent launches for some users.</li>
	</ul>
	<h2 id="build4">Alpha 4 (Build 4)</h2>
	<ul>
		<li>Fixed crash while importing an empty config.</li>
		<li>A beacon is know known as a loot source, since Beacon works for more than just beacons.</li>
		<li>UI elements will be sized nicer on each platform.</li>
		<li>It is now possible to edit multiple loot sources at the same time. Select multiple loot sources and only the sets common to all selected sources will be shown. Adding, editing, and removing sets will affect the all selected loot sources.</li>
		<li>Set entry sorting is now correct.</li>
		<li>It is now possible to create, edit, and customize presets! This is a power user feature, so it is hidden, but possible. First, setup an item set in any beacon. Include all possible items for both The Island and Scorched Earth. Right-click the set in the list and choose &quot;Create Preset&quot; to show the editor dialog. From here, items can be unchecked to exclude them from each map. More details available on the edit dialog itself. To edit a preset, hold the Option/Alt key while selecting the preset from the &quot;Add Item Set&quot; menu.</li>
		<li>Introducing document sharing! This couldn't be simpler. Just open your Beacon document and choose &quot;Publish Document…&quot; from the &quot;Document&quot; menu. Give the document a title and description, that's it! The document will be stored online and a shareable URL will be returned. Need to make changes? Just publish again, the URL will stay the same!</li>
		<li>Hidden multipliers for all loot sources are now known. Thanks to <a href="https://survivetheark.com/index.php?/profile/290980-qowyn/">https://survivetheark.com/index.php?/profile/290980-qowyn/</a> for the missing Scorched Earth multipliers.</li>
	</ul>
	<h2 id="build3">Alpha 3 (Build 3)</h2>
	<ul>
		<li>Now supports copy &amp; paste. Users can now copy a beacon and paste it into another document or even directly into their text editor. When pasting into a text editor, the text is a properly constructed ConfigOverrideSupplyCrateItems line ready for use. It is also possible to go in the opposite direction. Copy a ConfigOverrideSupplyCrateItems line from a text editor and paste into Beacon.</li>
		<li>Fixed an artificial minimum quality.</li>
		<li>Updated document format for more future-proofing.</li>
		<li>Added application and document icons.</li>
		<li>Added Tapejara Saddle to known engrams database.</li>
		<li>Beacon can now check for updates.</li>
		<li>Added three new quality options. Careful with these, they will produce some very powerful gear. The current Ascendant multiplier is 7. The new multipliers are Epic (9), Legendary (12), and Pearlescent (16).</li>
		<li>Quality values will no longer change when moving a beacon from one location to another.</li>
		<li>Changed how blueprints are handled. This will prevent excessive blueprints found in loot sources.</li>
		<li>Added &quot;Report a Problem&quot; to the Help/Application menu.</li>
	</ul>
	<h2 id="build2">Alpha 2 (Build 2)</h2>
	<ul>
		<li>Added &quot;Import Config&quot; under the File menu. An existing Game.ini file can be imported into Beacon. A new beacon document will be created from it which can be customized, saved, and exported again. This process will parse all ConfigOverrideSupplyCrateItems lines in the file.</li>
		<li>Multiple set entries can be edited at the same time. Simply select multiple lines with shift or control/command, and press edit. Checkboxes on the right of each value allow users to edit only the intended values.</li>
		<li>Multiple set entries can be added at the same time. Adding an entry now uses checkboxes in the class list. Simply check off multiple classes and all will be added when the process is complete.</li>
		<li>Added a footer bar as an alternative means of control.</li>
		<li>Clicking the &quot;+&quot; button in the beacon list will bring up the &quot;Add Beacon&quot; dialog. Holding the &quot;+&quot; will bring up an &quot;Add Beacon&quot; menu. This new menu has a power user option at the bottom called &quot;New Custom Beacon&quot; which does exactly what it sounds like.</li>
		<li>Like adding a beacon, adding a set to a beacon can be done with a click or a hold action. Clicking adds a new empty set, holding presents the preset menu.</li>
		<li>Beacon now knows some of the hidden quality multipliers of the loot crates themselves. This information will be used to craft quality values specific to the loot crate being edited. The set entry list now uses quality names such as Primitive, Ramshackle, etc. instead of the raw quality values.</li>
		<li>Quality values have been adjusted. The last build used the values from the wiki, which appear to be too high. Thanks to extensive testing from Reddit user Hickey464.</li>
		<li>Fixed all saddles presets missing a value. The result caused all saddles to use their weight value as the max quality, and max quality value as min quality.</li>
		<li>Added an About window.</li>
		<li>All known loot sources have been defined.</li>
	</ul>
	<h2 id="build1">Alpha 1 (Build 1)</h2>
	<div class="indent">
		<p>Initial release</p>
	</div>
</div>