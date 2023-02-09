<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');

use BeaconAPI\v4\Ark\{ConfigOption, ContentPack, Creature, Engram, LootContainer, SpawnPoint};
$id = $_GET['modId'] ?? $_GET['steamId'] ?? $_GET['mod_id'] ?? $_GET['workshop_id'] ?? '';
$pack = ContentPack::Fetch($id);
if (is_null($pack)) {
	http_response_code(404);
	echo '<h1>Mod Not Found</h1><p>The mod may have been deleted. Hopefully not though.</p>';
	exit;
}

$filters = [
	'contentPackId' => $pack->ContentPackId()
];

BeaconTemplate::SetTitle('Mod: ' . $pack->Name());
BeaconTemplate::SetPageDescription('Beacon has built-in support for the Ark mod "' . $pack->Name() . '" which means its engrams are already part of Beacon\'s database so you can begin using them immediately.');
$engrams = Engram::Search($filters, true);
$lootContainers = LootContainer::Search($filters, true);
$creatures = Creature::Search($filters, true);
//$configOptions = ConfigOption::Search($filters, true);
$spawnPoints = SpawnPoint::Search($filters, true);
$hasEngrams = count($engrams) > 0;
$hasLootContainers = count($lootContainers) > 0;
$hasCreatures = count($creatures) > 0;
$hasConfigOptions = false;//count($configOptions) > 0;
$hasSpawnPoints = count($spawnPoints) > 0;
$hasSomething = $hasEngrams || $hasLootContainers || $hasCreatures || $hasConfigOptions || $hasSpawnPoints;

?><h1><?php echo htmlentities($pack->Name()); ?></h1>
<p>Beacon has built-in support for <a href="<?php echo htmlentities($pack->SteamUrl()); ?>"><?php echo htmlentities($pack->Name()); ?></a>. This means its engrams are already part of Beacon's database and you can begin using them immediately.</p>
<?php if ($hasEngrams) { ?>
<h3 id="engrams"><?php echo htmlentities($pack->Name()); ?> Engrams</h3>
<p><a href="/mods/<?php echo htmlentities(urlencode($pack->SteamId())); ?>/spawncodes">See the full list with spawn codes here.</a></p>
<ul class="object_list">
	<?php foreach ($engrams as $engram) { ?><li><a href="/object/<?php echo htmlentities(urlencode($engram->UUID())); ?>"><?php echo htmlentities($engram->Label()); ?></a></li><?php } ?></ul>
<?php } ?>
<?php if ($hasLootContainers) { ?>
<h3 id="lootsources"><?php echo htmlentities($pack->Name()); ?> Loot Sources</h3>
<ul class="object_list">
	<?php foreach ($lootContainers as $lootContainer) { ?><li><a href="/object/<?php echo htmlentities(urlencode($lootContainer->UUID())); ?>"><?php echo htmlentities($lootContainer->Label()); ?></a></li><?php } ?>
</ul>
<?php } ?>
<?php if ($hasCreatures) { ?>
<h3 id="creatures"><?php echo htmlentities($pack->Name()); ?> Creatures</h3>
<ul class="object_list">
	<?php foreach ($creatures as $creature) { ?><li><a href="/object/<?php echo htmlentities(urlencode($creature->UUID())); ?>"><?php echo htmlentities($creature->Label()); ?></a></li><?php } ?>
</ul>
<?php } ?>
<?php if ($hasSpawnPoints) { ?>
<h3 id="spawnpoints"><?php echo htmlentities($pack->Name()); ?> Spawn Points</h3>
<ul class="object_list">
	<?php foreach ($spawnPoints as $spawnPoint) { ?><li><a href="/object/<?php echo htmlentities(urlencode($spawnPoint->UUID())); ?>"><?php echo htmlentities($spawnPoint->Label()); ?></a></li><?php } ?>
</ul>
<?php } ?>
<?php

if ($hasConfigOptions) {
	echo '<h3 id="configoptions">' . htmlentities($pack->Name()) . ' Config Options</h3>';
	echo '<table class="generic">';
	
	$config_files = array();
	foreach ($configOptions as $option) {
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
<?php if (!$hasSomething) { ?>
<p><?php echo htmlentities($pack->Name()); ?> doesn't appear to provide anything to Beacon. It must be here for emotional support only.</p>
<?php } ?>