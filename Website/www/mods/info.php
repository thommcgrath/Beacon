<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');

if (empty($_GET['mod_id']) == false && BeaconCommon::IsUUID($_GET['mod_id'])) {
	$mod = BeaconMod::GetByModID($_GET['mod_id']);
} elseif (empty($_GET['workshop_id']) == false) {
	$mods = BeaconMod::GetByConfirmedWorkshopID($_GET['workshop_id']);
	if (is_array($mods) && count($mods) == 1) {
		$mod = $mods[0];
	}
}

if (is_null($mod)) {
	http_response_code(404);
	echo '<h1>Mod Not Found</h1><p>The mod may have been deleted. Hopefully not though.</p>';
	exit;
}

BeaconTemplate::SetTitle('Mod: ' . $mod->Name());
$engrams = BeaconEngram::Get($mod->ModID());
$loot_sources = BeaconLootSource::Get($mod->ModID());
$has_engrams = count($engrams) > 0;
$has_loot_sources = count($loot_sources) > 0;
$has_something = $has_engrams || $has_loot_sources;

?><h1><?php echo htmlentities($mod->Name()); ?></h1>
<p>Beacon has built-in support for <a href="<?php echo BeaconWorkshopItem::URLForModID($mod->WorkshopID()); ?>"><?php echo htmlentities($mod->Name()); ?></a>. This means its engrams are already part of Beacon's database and you can begin using them immediately.</p>
<?php if ($has_engrams) { ?>
<h3><?php echo htmlentities($mod->Name()); ?> Engrams</h3>
<p>See the full list with spawn codes <a href="/mods/<?php echo abs($mod->WorkshopID()); ?>/spawncodes">here</a>.</p>
<ul>
	<?php foreach ($engrams as $engram) { ?><li><a href="/object/<?php echo $engram->ClassString(); ?>"><?php echo htmlentities($engram->Label()); ?></a></li><?php } ?>
</ul>
<?php } ?>
<?php if ($has_loot_sources) { ?>
<h3><?php echo htmlentities($mod->Name()); ?> Loot Sources</h3>
<ul>
	<?php foreach ($loot_sources as $loot_source) { ?><li><a href="/object/<?php echo $loot_source->ClassString(); ?>"><?php echo htmlentities($loot_source->Label()); ?></a></li><?php } ?>
</ul>
<?php } ?>
<?php if (!$has_something) { ?>
<p><?php echo htmlentities($mod->Name()); ?> doesn't appear to provide anything to Beacon. It must be here for emotional support only.</p>
<?php } ?>