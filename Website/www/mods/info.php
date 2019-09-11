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
$creatures = BeaconCreature::Get($mod->ModID());
$config_options = BeaconConfigLine::Get($mod->ModID());
$has_engrams = count($engrams) > 0;
$has_loot_sources = count($loot_sources) > 0;
$has_creatures = count($creatures) > 0;
$has_config_options = count($config_options) > 0;
$has_something = $has_engrams || $has_loot_sources || $has_creatures || $has_config_options;

?><h1><?php echo htmlentities($mod->Name()); ?></h1>
<p>Beacon has built-in support for <a href="<?php echo BeaconWorkshopItem::URLForModID($mod->WorkshopID()); ?>"><?php echo htmlentities($mod->Name()); ?></a>. This means its engrams are already part of Beacon's database and you can begin using them immediately.</p>
<?php if ($has_engrams) { ?>
<h3 id="engrams"><?php echo htmlentities($mod->Name()); ?> Engrams</h3>
<p>See the full list with spawn codes <a href="/mods/<?php echo abs($mod->WorkshopID()); ?>/spawncodes">here</a>.</p>
<ul class="object_list">
	<?php foreach ($engrams as $engram) { ?><li><a href="/object/<?php echo ($engram->IsAmbiguous() ? (urlencode($engram->ModWorkshopID()) . '/' . urlencode($engram->ClassString())) : urlencode($engram->ClassString())); ?>"><?php echo htmlentities($engram->Label()); ?></a></li><?php } ?></ul>
<?php } ?>
<?php if ($has_loot_sources) { ?>
<h3 id="lootsources"><?php echo htmlentities($mod->Name()); ?> Loot Sources</h3>
<ul class="object_list">
	<?php foreach ($loot_sources as $loot_source) { ?><li><a href="/object/<?php echo $loot_source->ClassString(); ?>"><?php echo htmlentities($loot_source->Label()); ?></a></li><?php } ?>
</ul>
<?php } ?>
<?php if ($has_creatures) { ?>
<h3 id="creatures"><?php echo htmlentities($mod->Name()); ?> Creatures</h3>
<ul class="object_list">
	<?php foreach ($creatures as $creature) { ?><li><a href="/object/<?php echo $creature->ClassString(); ?>"><?php echo htmlentities($creature->Label()); ?></a></li><?php } ?>
</ul>
<?php } ?>
<?php

if ($has_config_options) {
	echo '<h3 id="configoptions">' . htmlentities($mod->Name()) . ' Config Options</h3>';
	echo '<table class="generic">';
	
	$config_files = array();
	foreach ($config_options as $option) {
		$file = $option->ConfigFileName();
		if (array_key_exists($file, $config_files)) {
			$headers = $config_files[$file];
		} else {
			$headers = array();
		}
		
		$header = $option->SectionHeader();
		if (array_key_exists($header, $headers)) {
			$options = $headers[$header];
		} else {
			$options = array();
		}
		
		$options[] = $option;
		$headers[$header] = $options;
		$config_files[$file] = $headers;
	}
	
	foreach ($config_files as $filename => $headers) {
		echo '<thead><tr><th>' . htmlentities($filename) . '</th></tr></thead>';
		foreach ($headers as $header => $options) {
			echo '<thead><tr><th>' . htmlentities('[' . $header . ']') . '</th></tr></thead>';
			echo '<tbody>';
			foreach ($options as $option) {
				echo '<tr><td><span class="source-code-font">' . htmlentities($option->KeyName()) . '=' . htmlentities($option->DefaultValue()) . '</span><br><span class="smaller text-lighter">' . nl2br(htmlentities($option->Description())) . '</span></td></tr>';
			}
			echo '</tbody>';
		}
	}
	
	echo '</table>';
} ?>
<?php if (!$has_something) { ?>
<p><?php echo htmlentities($mod->Name()); ?> doesn't appear to provide anything to Beacon. It must be here for emotional support only.</p>
<?php } ?>