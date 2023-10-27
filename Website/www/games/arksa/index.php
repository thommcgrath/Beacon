<?php
require(dirname(__FILE__, 4) . '/framework/loader.php');
BeaconTemplate::SetTitle('Beacon for Ark: Survival Ascended', false);
BeaconTemplate::SetCanonicalPath('/Games/ArkSA');

$breadcrumbs = new BeaconBreadcrumbs();
$breadcrumbs->AddComponent('/Games', 'Games');
$breadcrumbs->AddComponent('ArkSA', 'Ark: Survival Ascended');
echo $breadcrumbs->Render();

?><h1>Beacon for Ark: Survival Ascended</h1>
<ul>
	<li><a href="/Games/ArkSA/Creatures">Creatures</a></li>
	<li><a href="/Games/ArkSA/Engrams">Engrams</a></li>
	<li><a href="/Games/ArkSA/LootDrops">Loot Drops</a></li>
	<li><a href="/Games/ArkSA/Mods">Mods</a></li>
	<li><a href="/Games/ArkSA/Cheats">Spawn Codes</a></li>
	<li><a href="/Games/ArkSA/SpawnPoints">Spawn Points</a></li>
</ul>
