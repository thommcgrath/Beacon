<?php
require($_SERVER['SITE_ROOT'] . '/framework/loader.php');
BeaconTemplate::SetTitle('Getting Started With Beacon');
?>
<h1>Getting Started With Beacon</h1>
<div class="indent">
	<h2><a id="Introduction"></a>Introduction</h2>
	<div class="indent">
		<p>Ark players know too well the feeling of rushing to grab a red loot drop only to find it filled with a hide hat and a water jar. Beacon is a tool designed to allow server admins to fix that.</p>
		<p>Wildcard gave admins this ability ages ago, but actually doing so is a frustrating experience in madness. The phrase &quot;wall of text&quot; could not be more appropriate. So many admins either wouldn’t customize, or would use a config they found on pastebin, for example.</p>
		<p>Beacon makes it simple. Beacon makes it human.</p>
	</div>
	<h2><a id="Getting_Started"></a>Getting Started</h2>
	<div class="indent">
		<p>There are lots of different loot sources in the game, and Beacon lets admins customize them all. When creating a new document, there will be no loot sources listed. This essentially means &quot;no changes&quot; and this is important. If a loot source is not defined in a document, it will be left as standard.</p>
		<p>To start, add a loot source. This can be done using the &quot;Add Loot Source&hellip;&quot; menu option from the &quot;Document&quot; menu or using the small plus button in the lower left of the window. This opens the loot source wizard. Start simple and select &quot;Island White (Level 3)&quot; and press the &quot;Next&quot; button. In the next screen, the minimum and maximum number of item sets can be specified. Leave this alone for now. Under the &quot;Presets&quot; list, check &quot;Cloth Clothing&quot;, &quot;Small Saddles&quot;, and &quot;Primitive Tools&quot; before pressing the &quot;Done&quot; button.</p>
		<p>That’s it! Well, there’s plenty more that can be done, but at the most basic level, white loot drops on The Island and The Center will now contain one or all of the sets listed.</p>
		<p>The new loot source will be selected automatically. In the second column is the list of possible sets the loot source can select from. Remember the &quot;Min Sets&quot; and &quot;Max Sets&quot; values from a moment ago? That specifies how many of these sets can be chosen when filling a loot source.</p>
		<p>Selecting any of the item sets will list the possible contents. Just like a loot source, an item set has a minimum and maximum number of items to select. The &quot;Cloth Clothing&quot; set defaults to selecting between 1 and 5 items, so a drop could contain just a hat or a full set of cloth clothing. The &quot;Weight&quot; value of each set specifies its relative likeliness of selection. All three sets will have a weight of 50 by default, and that means they are all equally likely to be selected. The chance for selection is basically &quot;weight / sum of all weights&quot; so increasing the value of one set to 100 would make it 50% likely to be chosen, vs 25% for the other two sets.</p>
		<p>Inside each set is the list of possible contents. Item set entries have a minimum quantity, maximum quantity, minimum quality, maximum quality, weight, and blueprint chance. Quantities need no explanation, and weight works the same as with item sets.</p>
		<p>Quality ranges are&hellip; interesting. The range specified is ideal, but Ark introduces an amount of randomness to quality values, so do not take these as hard limits. The quality values Beacon uses have been extensively tested to produce <em>the most statistically likely</em> loot at the desired quality, but it is not guaranteed. This is just how Ark behaves unfortunately.</p>
		<p>The blueprint chance is just the chance for an item to be blueprint instead of a usable item. Not all items have a blueprint - like wood for example - so their blueprint chance is always 0%.</p>
		<p>The next step is to go to the &quot;File&quot; menu and select &quot;Export&quot; to create a Game.ini file ready for the server.</p>
	</div>
	<h2><a id="TipsTricks"></a>Tips &amp; Tricks</h2>
	<ul>
		<li>It is possible to select multiple loot sources. Item sets that are identical between all selected loot sources will remain in the item set list and can be edited together.</li>
		<li>Copy &amp; Paste is fully supported, so feel free to copy a set from one loot source to another, or entries between sets.</li>
		<li>It is perfectly acceptable to put Scorched Earth items in loot sources for The Island and The Center, and vice versa. However, certain items don’t actually work. For example, Wyvern Eggs can be put into a loot source on The Island, but cannot actually be hatched as they will vanish when placed on the ground for incubating. Other things just don’t make sense, such as Oil Pumps on The Island. Just be aware.</li>
		<li>Existing server configs can be imported. However, this isn’t very convenient, as item sets won’t have names. Don’t import a config previous exported by Beacon. The config that Beacon exports is designed to work around some of Ark’s oddities and won’t appear the same as the original document.</li>
		<li>Save your Beacon document. When new items are added, it’ll be easier to add them to your loot sources next time.</li>
		<li>Beacon updates its database of loot sources, engrams, and presets automatically. A new version of Beacon will not be needed when new items are added to Ark.</li>
		<li>An item set entry can contain multiple items. This is different from having multiple single-engram set entries. For example, having an entry with both the Quetzal Saddle and Quetzal Platform Saddle guarantees one or the other. However, having one entry for each allows the possibility for both saddles to be selected.</li>
	</ul>
</div>