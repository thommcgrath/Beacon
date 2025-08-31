<?php
require(dirname(__FILE__, 4) . '/framework/loader.php');
BeaconTemplate::SetTitle('Beacon for Ark: Survival Evolved', false);
BeaconTemplate::SetCanonicalPath('/Games/Ark');

$breadcrumbs = new BeaconBreadcrumbs();
$breadcrumbs->AddComponent('/Games', 'Games');
$breadcrumbs->AddComponent('Ark', 'Ark: Survival Evolved');
echo $breadcrumbs->Render();

?><h1>Beacon for Ark: Survival Evolved</h1>
<ul>
	<li><a href="/Games/Ark/Creatures">Creatures</a></li>
	<li><a href="/Games/Ark/Engrams">Engrams</a></li>
	<li><a href="/Games/Ark/LootDrops">Loot Drops</a></li>
	<li><a href="/Games/Ark/Mods">Mods</a></li>
	<li><a href="/Games/Ark/Cheats">Spawn Codes</a></li>
	<li><a href="/Games/Ark/SpawnPoints">Spawn Points</a></li>
	<li><a href="/Games/Ark/Colors">Colors</a></li>
</ul>
