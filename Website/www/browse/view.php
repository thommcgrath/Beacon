<?php

if (empty($_GET['document_id'])) {
	header('Location: /browse/');
	exit;
}

require(dirname(__FILE__, 3) . '/framework/loader.php');

$document_id = $_GET['document_id'];
$search_keys = array(
	'public' => true,
	'document_id' => $document_id
);
	

$documents = \Ark\Project::Search($search_keys);
if (count($documents) != 1) {
	http_response_code(404);
	BeaconTemplate::SetTitle('Project Not Found');
	echo '<h1>Project not found</h1><p><a href="/browse/">Browse community projects</a></p>';
	exit;
}

$document = $documents[0];

$map_filter = $document->MapMask();
if (array_key_exists('map_filter', $_GET)) {
	$map_filter = intval($_GET['map_filter']);
}

BeaconTemplate::SetTitle($document->Name());
BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('generator.scss'));
BeaconTemplate::AddScript(BeaconCommon::AssetURI('generator.js'));

$author_id = $document->UserID();
$author = BeaconUser::GetByUserID($author_id);
$author_name = $author->IsAnonymous() ? 'Anonymous' : $author->Username();
$maps = \Ark\Maps::Masks($document->MapMask());

?><h1><?php echo htmlentities($document->Name()); ?><br><span class="subtitle">By <?php echo htmlentities($author_name); ?><span class="user-suffix">#<?php echo htmlentities($author->Suffix()); ?></span></span></h1>
<h3>Description</h3>
<div class="indent">
	<p><?php echo nl2br(htmlentities($document->Description())); ?></p>
</div>
<h3>Requirements</h3>
<div class="indent">
	<p>Maps: <?php
$map_names = array_values($maps);
if (count($map_names) >= 3) {
	$last = array_pop($map_names);
	echo implode(', ', $map_names) . ', and ' . $last;
	$map_names[] = $last;
} elseif (count($map_names) == 2) {
	echo $map_names[0] . ' and ' . $map_names[1];
} else {
	echo $map_names[0];
}
?></p>
	<p>Platforms: <span class="platform_tag pc">PC</span><?php if ($document->ConsoleSafe()) {?><span class="platform_tag xbox">Xbox</span><span class="platform_tag playstation">PlayStation</span><?php } ?></p>
	<?php
		
	$database = BeaconCommon::Database();
	$mod_ids = $document->RequiredMods(false);
	$results = $database->Query('SELECT workshop_id, name FROM ark.mods WHERE array_position($1, mod_id) IS NOT NULL ORDER BY name;', $mod_ids);
	$unknown_mods = false;
	$mod_links = array();
	while (!$results->EOF()) {
		$mod_links[] = '<a href="/mods/' . abs($results->Field('workshop_id')) . '">' . htmlentities($results->Field('name')) . '</a>';
		$results->MoveNext();
	}
	if (count($mod_links) != count($document->RequiredMods(true))) {
		$mod_links[] = 'one or more mods not listed with Beacon';
	}
	
	if (count($mod_links) > 0) {
		echo '<p>Uses Mods: ' . ucfirst(BeaconCommon::ArrayToEnglish($mod_links)) . '.</p>';
	}
	
	$editors = $document->ImplementedConfigs(true);
	$editor_names = array();
	foreach ($editors as $name) {
		switch ($name) {
		case 'BreedingMultipliers':
			$editor_names[] = 'Breeding Multipliers';
			break;
		case 'CraftingCosts':
			$editor_names[] = 'Crafting Costs';
			break;
		case 'CustomContent':
			$editor_names[] = 'Custom Config';
			break;
		case 'DayCycle':
			$editor_names[] = 'Day and Night Cycle';
			break;
		case 'DinoAdjustments':
			$editor_names[] = 'Creature Adjustments';
			break;
		case 'EngramControl':
			$editor_names[] = 'Engram Control';
			break;
		case 'ExperienceCurves':
			$editor_names[] = 'Levels and XP';
			break;
		case 'HarvestRates':
			$editor_names[] = 'Harvest Rates';
			break;
		case 'LootDrops':
			$editor_names[] = 'Loot Drops';
			break;
		case 'LootScale':
		case 'OtherSettings':
			$editor_names[] = 'General Settings';
			break;
		case 'SpawnPoints':
			$editor_names[] = 'Creature Spawns';
			break;
		case 'SpoilTimers':
			$editor_names[] = 'Decay and Spoil';
			break;
		case 'StackSizes':
			$editor_names[] = 'Stack Sizes';
			break;
		case 'StatLimits':
			$editor_names[] = 'Item Stat Limits';
			break;
		case 'StatMultipliers':
			$editor_names[] = 'Stat Multipliers';
			break;
		}
	}
	if (count($editor_names) > 0) {
		sort($editor_names);
		echo '<p>Contains Configs: ' . BeaconCommon::ArrayToEnglish(array_unique($editor_names)) . '</p>';
	}
		
	?>
</div>
<h3>Download</h3>
<div class="indent">
	<p><a href="<?php echo $document->ResourceURL(); ?>" rel="nofollow">Download original project</a> or <a href="<?php echo str_replace('https://', 'beacon://', $document->ResourceURL()); ?>" rel="nofollow">Open project in Beacon</a></p>
</div>
<h3>Create Game.ini</h3>
<div class="indent">
	<p>Create a customized Game.ini from this project.</p>
	<div id="mode_tabs"><div id="mode_tabs_new" class="selected">Create New</div><div id="mode_tabs_paste">Paste Text</div><div id="mode_tabs_upload">Upload File</div></div>
	<div id="mode_customizations">
		<input type="hidden" id="map_mask" name="map_mask" value="<?php echo ($map_filter & $document->MapMask()); ?>">
		<table id="options_table">
		<?php if (count($maps) > 1) { ?><tr><td class="label">Include Maps:</td><td><?php
		
		foreach ($maps as $value => $name) {
			$id = 'map_check_' . $value;
			echo ' <label class="checkbox"><input id="' . $id . '" type="checkbox" value="' . $value . '"' . (($map_filter & $value) == $value ? ' checked' : '') . '><span></span>' . htmlentities($name) . '</label>';
		}
		
		?></td></tr><?php } ?>
		<tr><td class="label"><label for="dino_level_field">Max Dino Level:</label></td><td><input type="number" id="dino_level_field" value="120"></td></tr>
		<tr><td class="label"><label for="difficulty_reference">Difficulty Settings:</label></td><td><textarea readonly rows="2" id="difficulty_reference"></textarea><br><span class="smaller">This space is only a reference. These options will produce the desired dino level. Loot will be scaled accordingly.</span></td></tr>
		</table>
	</div>
	<div id="mode_view">
		<div id="mode_view_new">
			<p>This option creates a new Game.ini from scratch. Use this if your server has no customizations.</p>
			<form action="generate" method="get">
				<input type="hidden" name="document_id" value="<?php echo htmlentities($document->ProjectID()); ?>">
				<input type="hidden" name="difficulty_value" value="" id="create_difficulty_value">
				<p class="text-center"><label class="radio"><input type="radio" name="mode" value="inline" id="create_inline_check" checked><span></span>Show new Game.ini in browser</label><br><label class="radio"><input type="radio" name="mode" value="download" id="create_download_check"><span></span>Download new Game.ini</label></p>
				<p class="text-center"><input type="submit" value="Generate"></p>
			</form>
		</div>
		<div id="mode_view_paste">
			<p>Paste your current Game.ini here and a customized version will be produced for you.</p>
			<form action="generate" method="post">
				<input type="hidden" name="document_id" value="<?php echo htmlentities($document->ProjectID()); ?>">
				<input type="hidden" name="mode" value="inline">
				<input type="hidden" name="difficulty_value" value="" id="paste_difficulty_value">
				<textarea name="content" rows="20" wrap="off"></textarea>
				<p class="text-center"><input type="submit" value="Generate"></p>
			</form>
		</div>
		<div id="mode_view_upload">
			<p>Upload your current Game.ini to download a customized version.</p>
			<form action="generate" method="post" enctype="multipart/form-data">
				<input type="hidden" name="document_id" value="<?php echo htmlentities($document->ProjectID()); ?>">
				<input type="hidden" name="mode" value="download">
				<input type="hidden" name="difficulty_value" value="" id="upload_difficulty_value">
				<input type="file" name="content" accept=".ini" id="upload_file_selector">
				<p class="text-center"><input type="submit" id="upload_file_selector_button" value="Choose File"></p>
			</form>
		</div>
	</div>
</div>