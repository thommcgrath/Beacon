<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');
BeaconTemplate::SetTitle('Supported Mods');
BeaconTemplate::SetCanonicalPath('/Games/Ark/Mods');

use BeaconAPI\v4\ContentPack;

$packs = ContentPack::Search(['gameId' => 'Ark', 'confirmed' => true, 'isIncludedInDeltas' => true], true);

$breadcrumbs = new BeaconBreadcrumbs();
$breadcrumbs->AddComponent('/Games', 'Games');
$breadcrumbs->AddComponent('Ark', 'Ark: Survival Evolved');
$breadcrumbs->AddComponent('Mods', 'Mods');
echo $breadcrumbs->Render();

?><h1>Supported Mods</h1>
<p>Beacon supports mods, both officially and unofficially! This page lists the Ark mods that Beacon already supports. If you want to add mod items to your own copy of Beacon, <a href="/help/adding_blueprints_to_beacon">here's how</a>. If you are a mod developer and want to add your mod to Beacon for all users to enjoy, <a href="/help/registering_your_mod_with_beacon">it's pretty simple</a>.</p>
<table class="generic">
	<thead>
		<th>Mod Name</th>
		<th>Steam Id</th>
	</thead>
	<tbody>
		<?php foreach ($packs as $pack) { ?><tr>
			<td><a href="/Games/Ark/Mods/<?php echo htmlentities(urlencode($pack->MarketplaceId())); ?>"><?php echo htmlentities($pack->Name()); ?></a></td>
			<td><a href="<?php echo htmlentities($pack->MarketplaceUrl()); ?>" target="_blank"><?php echo htmlentities($pack->MarketplaceId()); ?></a></td>
		</tr><?php } ?>
	</tbody>
</table>