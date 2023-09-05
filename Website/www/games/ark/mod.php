<?php
require(dirname(__FILE__, 4) . '/framework/loader.php');

use BeaconAPI\v4\ContentPack;

$contentPackId = $_GET['contentPackId'] ?? '';
$pack = null;
if (BeaconCommon::IsUUID($contentPackId)) {
	$pack = ContentPack::Fetch($contentPackId);
} elseif (filter_var($contentPackId, FILTER_VALIDATE_INT, ['options' => ['min_range' => -9223372036854775808, 'max_range' => 9223372036854775807]])) {
	$packs = ContentPack::Search(['gameId' => 'Ark', 'marketplaceId' => $contentPackId, 'isConfirmed' => true], true);
	if (count($packs) === 1) {
		$pack = $packs[0];
	}
}
if (is_null($pack)) {
	header('Location: /Games/Ark/Mods', true, 302);
	exit;
}

$title = $pack->Name();
BeaconTemplate::SetTitle($title);
BeaconTemplate::SetPageDescription('Beacon Supports "' . $pack->Name() . '" for Ark: Survival Evolved', false);
BeaconTemplate::SetCanonicalPath('/Games/Ark/Mods/' . urlencode($pack->MarketplaceId()));

$breadcrumbs = new BeaconBreadcrumbs();
$breadcrumbs->AddComponent('/Games', 'Games');
$breadcrumbs->AddComponent('Ark', 'Ark: Survival Evolved');
$breadcrumbs->AddComponent('Mods', 'Mods');
$breadcrumbs->AddComponent(urlencode($pack->MarketplaceId()), $pack->Name());
echo $breadcrumbs->Render();

?><h1><?php echo htmlentities($title); ?></h1>
<ul>
	<li><a href="/Games/Ark/Mods/<?php echo urlencode($pack->MarketplaceId()); ?>/Creatures">Creatures</a></li>
	<li><a href="/Games/Ark/Mods/<?php echo urlencode($pack->MarketplaceId()); ?>/Engrams">Engrams</a></li>
	<li><a href="/Games/Ark/Mods/<?php echo urlencode($pack->MarketplaceId()); ?>/LootDrops">Loot Drops</a></li>
	<li><a href="/Games/Ark/Mods/<?php echo urlencode($pack->MarketplaceId()); ?>/Cheats">Spawn Codes</a></li>
	<li><a href="/Games/Ark/Mods/<?php echo urlencode($pack->MarketplaceId()); ?>/SpawnPoints">Spawn Points</a></li>
</ul>
