<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');
BeaconTemplate::SetTitle('Supported Mods');

use BeaconAPI\v4\Ark\ContentPack;

$packs = ContentPack::Search(['confirmed' => true, 'isIncludedInDeltas' => true], true);

?><h1>Supported Mods</h1>
<p>Beacon supports mods, both officially and unofficially! This page lists the Ark mods that Beacon already supports. If you want to add mod items to your own copy of Beacon, <a href="/help/adding_blueprints_to_beacon">here's how</a>. If you are a mod developer and want to add your mod to Beacon for all users to enjoy, <a href="/help/registering_your_mod_with_beacon">it's pretty simple</a>.</p>
<table class="generic">
	<thead>
		<th>Mod</th>
		<th>Workshop ID</th>
	</thead>
	<tbody>
		<?php foreach ($packs as $pack) { ?><tr>
			<td><a href="/mods/<?php echo htmlentities(urlencode($pack->SteamId())); ?>"><?php echo htmlentities($pack->Name()); ?></a></td>
			<td><a href="<?php echo htmlentities($pack->SteamUrl()); ?>" target="_blank"><?php echo htmlentities($pack->SteamId()); ?></a></td>
		</tr><?php } ?>
	</tbody>
</table>