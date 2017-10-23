<?php
require($_SERVER['SITE_ROOT'] . '/framework/loader.php');
BeaconTemplate::SetTitle('Help');

$default_island_document = BeaconDocumentMetadata::GetByDocumentID('eab656ca-20c6-4bec-bd15-6066f0fb16d3');
$default_scorched_document = BeaconDocumentMetadata::GetByDocumentID('08bccb22-3c06-4982-b267-c2abd81e959a');
$default_island_updated = (count($default_island_document) == 1) ? $default_island_document[0]->LastUpdated() : null;
$default_scorched_updated = (count($default_scorched_document) == 1) ? $default_scorched_document[0]->LastUpdated() : null;

?><h1>Getting Started</h1>
<div class="indent">
	<p>New users who have no idea how to start customizing loot should <a href="gettingstarted.php">read this</a>.</p>
</div>
<h1>Common Issues</h1>
<div class="indent">
	<p>As much as Beacon attempts to be self-explaining, sometimes there are problems that require human interaction.</p>
	<h3>Modifying the default loot</h3>
	<div class="indent">
		<p>Beacon does not have official support for editing the default loot, however community member <a href="https://steamcommunity.com/id/vyvin">Vyvin</a> has extracted the default loot for The Island and Scorched Earth and shared the results.</p>
		<ol>
			<li><a href="https://api.beaconapp.cc/v1/document.php/eab656ca-20c6-4bec-bd15-6066f0fb16d3">The Island</a><?php if ($default_island_updated !== null) { echo ', updated <time datetime="' . $default_island_updated->format('c') . '">' . $default_island_updated->format('F jS, Y') . ' at ' . $default_island_updated->format('g:i A') . ' UTC</time>'; } ?></li>
			<li><a href="https://api.beaconapp.cc/v1/document.php/08bccb22-3c06-4982-b267-c2abd81e959a">Scorched Earth</a><?php if ($default_scorched_updated !== null) { echo ', updated <time datetime="' . $default_scorched_updated->format('c') . '">' . $default_scorched_updated->format('F jS, Y') . ' at ' . $default_scorched_updated->format('g:i A') . ' UTC</time>'; } ?></li>
		</ol>
	</div>
	<h3>Finding a starting point</h3>
	<div class="indent">
		<p>Not every admin wants to build an entire loot table from scratch. Beacon has a library of documents shared by the community that are ready to use and customize. In the Window menu, go to Library. The initial view is the Documents tab, which hosts the community documents.</p>
	</div>
	<h3>Adding mod items</h3>
	<div class="indent">
		<p>To start, find the cheat or spawn code for the item or items that need to be added. These will typically look like &quot;cheat giveitem Blueprint'/path/to/item' 1 1 false&quot; and copy one or more to the clipboard. Do not worry about extra formatting, Beacon can extract the data it needs from as little as a single command or an entire web page full of commands.</p>
		<p>For a temporary solution, when adding an engram to an item set the field up top labelled &quot;Search or Enter Spawn Command&quot; will accept the copied command or commands. The mod items will then show up in the list below.</p>
		<p>For a more permanent solution, go to the Window menu and select Library. In that window, press Engrams to see the engrams manager. The engrams manager can import engrams from a website or file, but the easiest way is with the &quot;Import from Clipboard&quot; button. If the button is not enabled, that means Beacon did not find any copied spawn commands. Go back, copy one or more commands, and the button should enable.</p>
		<p>When importing engrams from spawn commands, Beacon will guess at names. The engrams manager can be used to rename items or change map availability.</p>
	</div>
	<h3>Engrams are not updating</h3>
	<div class="indent">
		<p>Beacon automatically updates its engram database every launch. However, there are scenarios that could prevent this from happening.</p>
		<p>First thing is first, manually update your engrams. <a href="/download/classes.php">Download the engrams</a>, then use &quot;Import&hellip;&quot; from the &quot;File&quot; menu to import the file into Beacon.</p>
		<p>Now on to actually solving the problem. Users on Windows 7 and Windows 8.0 (but not Windows 8.1 and newer) often have this issue because these versions do not have support for TLS 1.1 and 1.2 enabled, which Beacon requires. Normally, the Beacon installer will attempt to enable this support automatically, but this doesn't always work.</p>
		<p>See <a href="https://support.microsoft.com/en-gb/help/3140245/update-to-enable-tls-1.1-and-tls-1.2-as-a-default-secure-protocols-in-winhttp-in-windows">https://support.microsoft.com/en-gb/help/3140245/update-to-enable-tls-1.1-and-tls-1.2-as-a-default-secure-protocols-in-winhttp-in-windows</a> for more details and a solution.</p>
	</div>
	<h3>Item quality does not match</h3>
	<div class="indent">
		<p>Most importantly, Beacon must know the server difficulty in order to compute correct quality values. Below the Loot Sources list is a small gear icon used to adjust settings. Use any one of the three fields to input difficulty. There is a link to the wiki explaining more about difficulty if more help is needed.</p>
		<p>If difficulty is set correctly, next make sure the server's Game.ini does not contain a SupplyCrateLootQualityMultiplier setting, or the value is set to 1.0. This setting will alter Beacon's values dramatically.</p>
		<p>If both difficulty and quality multiplier are correct, the issue is likely just Ark itself. Best we as a community can determine, quality works in a number of steps:</p>
		<ol>
			<li>The item template is loaded. It has the following (made up) base stats: 100 durability, 100 defense, 100 hypothermal, and 100 hyperthermal.</li>
			<li>Each item has a pool of additional stat points to be allocated. For this example, the pool will be 10 points.</li>
			<li>Assuming a quality multiplier of 2.0, the additional point pool would be 20 points. These 20 points are then randomly distributed to the 4 stats. In this example, we'll give 10 points to durability, 5 to defense, 3 to hypothermal, and 2 to hyperthermal.</li>
			<li>Lastly, <em>a single stat is measured to determine the label to give the item</em>. Most items measure durability. Let's assume the range is 100-105 = Primitive, 106-110 = Ramshackle, and 111-120 = Apprentice. In this case, the item would be prefixed Ramshackle because the item's durability is 110.</li>
		</ol>
		<p>Now, let's generate the same item with the same quality multiplier again:</p>
		<ol>
			<li>This time 3 points were given to durability, 10 points to defense, 5 points to hypothermal, and 2 points to hyperthermal. This item has exactly the same quality and total stats, but the stats are distributed differently. This is how loot generation works to ensure each item is unique.</li>
			<li>Because Ark is only measuring durability and this item's durability is only 103, it is given the Primitive prefix.</li>
		</ol>
		<p>Beacon will produce the intended loot, but due to how Ark measures stats and assigns prefixes, it is impossible to guarantee a specific prefix.</p>
	</div>
	<h3>The ini file produced isn't what was expected</h3>
	<div class="indent">
		<p>This is such a detailed subject that there is <a href="math.php">an entire separate page</a> just explaining how Beacon does its math. Though the short version of the story is that Beacon produces ini files intended for Ark to read them, not humans. The code it creates attempts to tell Ark about the author's intentions. This means sometimes doing weird things to make that a reality.</p>
	</div>
	<h3>Learning more about ConfigOverrideSupplyCrateItems</h3>
	<div class="indent">
		<p>See <a href="spec.php">this document</a> for more details about what Beacon knows about the ConfigOverrideSupplyCrateItems config option.</p>
	</div>
	<h3>Loot sources not updating on official maps.</h3>
	<div class="indent">
		<p>The loot override code generated by Beacon is recognized by Ark, but not yet by some other tools. Users of Ark Server Manager have reported issues using the code that Beacon generates. Update to Ark Server Manager 1.0.288 (or newer) and disable Supply Crate Overrides. This will prevent ASM from altering the code that Beacon generates.</p>
	</div>
	<h3>Some more personal help</h3>
	<div class="indent">
		<p>Get in touch. Bugs should be reported on the <a href="/reportaproblem.php">GitHub page</a>. Anybody can create an account and this is more helpful than email when it comes to bugs. General help inquiries should be sent to <a href="mailto:forgotmyparachute@beaconapp.cc">forgotmyparachute@beaconapp.cc</a>.</p>
		<p class="text-center"><a href="https://discord.gg/2vbT7fV"><img height="40" src="/assets/images/discord-full-white.svg"></a></p>
		<p>Beacon now has a <a href="https://discord.gg/2vbT7fV">Discord server</a>. Come ask questions, but realize that people need to sleep.</p>
	</div>
</div>