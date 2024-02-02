<?php

if (empty($_GET['projectId'])) {
	header('Location: /browse/');
	exit;
}

require(dirname(__FILE__, 3) . '/framework/loader.php');

use BeaconAPI\v4\{Ark, ArkSA, Project, User};

$projectId = $_GET['projectId'] ?? $_GET['projectId'];
$project = Project::Fetch($projectId);
if (is_null($project) || $project->IsPublic() === false) {
	http_response_code(404);
	BeaconTemplate::SetTitle('Project Not Found');
	echo '<h1>Project not found</h1><p><a href="/browse/">Browse community projects</a></p>';
	exit;
}

$mapFilter = filter_var($_GET['mapFilter'] ?? $_GET['map_filter'] ?? null, FILTER_VALIDATE_INT);
if ($mapFilter === false) {
	$mapfilter = $project->MapMask();
}

BeaconTemplate::SetTitle($project->Title());
BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('generator.css'));
BeaconTemplate::AddScript(BeaconCommon::AssetURI('generator.js'));

$authorId = $project->UserId();
$author = User::Fetch($authorId);
$authorName = $author->IsAnonymous() ? 'Anonymous' : $author->Username();
$baseUrl = BeaconCommon::APIDomain() . '/v4/projects/' . urlencode($project->ProjectId());
$gameId = $project->GameId();

$maps = [];
switch ($gameId) {
case 'Ark':
	$maps = Ark\Map::Search(['mask' => $project->MapMask()], true);
	break;
case 'ArkSA':
	$maps = ArkSA\Map::Search(['mask' => $project->MapMask()], true);
	break;
}

BeaconTemplate::SetCanonicalPath('/browse/' . urlencode($project->ProjectId()), false);

?><h1><?php echo htmlentities($project->Title()); ?><br><span class="subtitle">By <?php echo htmlentities($authorName); ?><span class="user-suffix">#<?php echo htmlentities($author->Suffix()); ?></span></span></h1>
<h3>Description</h3>
<div class="indent break-code">
	<p><?php echo nl2br(htmlentities($project->Description())); ?></p>
</div>
<h3>Requirements</h3>
<div class="indent">
	<?php
	if (count($maps) > 0) {
		$mapNames = [];
		foreach ($maps as $map) {
			$mapNames[] = $map->Label();
		}
		echo '<p>' . (count($maps) === 1 ? 'Map' : 'Maps') . ': ' . BeaconCommon::ArrayToEnglish($mapNames) . '</p>';
	}
	?>
	<p>Platforms: <span class="platform_tag pc">PC</span><?php if ($project->ConsoleSafe()) {?><span class="platform_tag xbox">Xbox</span><span class="platform_tag playstation">PlayStation</span><?php } ?></p>
	<?php

	$database = BeaconCommon::Database();

	$packIds = [];
	if ($gameId === 'Ark') {
		$packIds = $project->RequiredMods(false);
	} else {
		$packIds = $project->RequiredContentPacks(false);
	}
	$results = $database->Query('SELECT name, marketplace_id FROM public.content_packs WHERE game_id = $1 AND array_position($2, content_pack_id) IS NOT NULL ORDER BY name;', $gameId, '{' . $packIds . '}');
	$unknownPacks = false;
	$packLinks = [];
	while (!$results->EOF()) {
		$packLinks[] = '<a href="/Games/' . urlencode($gameId) . '/Mods/' . urlencode($results->Field('marketplace_id')) . '">' . htmlentities($results->Field('name')) . '</a>';
		$results->MoveNext();
	}
	if (empty($packIds) === false && count($packLinks) !== count(explode(',', $packIds))) {
		$packLinks[] = 'one or more mods not listed with Beacon';
	}
	if (count($packLinks) > 0) {
		echo '<p>Uses Mods: ' . ucfirst(BeaconCommon::ArrayToEnglish($packLinks)) . '.</p>';
	}

	$editors = $project->ImplementedConfigs(true);
	$editorNames = array();
	foreach ($editors as $name) {
		switch ($name) {
		case 'Ark.BreedingMultipliers':
		case 'ArkSA.BreedingMultipliers':
		case 'BreedingMultipliers':
			$editorNames[] = 'Breeding Multipliers';
			break;
		case 'Ark.CraftingCosts':
		case 'ArkSA.CraftingCosts':
		case 'CraftingCosts':
			$editorNames[] = 'Crafting Costs';
			break;
		case 'Ark.CustomConfig':
		case 'ArkSA.CustomConfig':
		case 'SDTD.CustomConfig':
		case 'Palworld.CustomConfig':
		case 'CustomContent':
			$editorNames[] = 'Custom Config';
			break;
		case 'Ark.DayCycle':
		case 'ArkSA.DayCycle':
		case 'DayCycle':
			$editorNames[] = 'Day and Night Cycle';
			break;
		case 'Ark.CreatureAdjustments':
		case 'ArkSA.CreatureAdjustments':
		case 'DinoAdjustments':
			$editorNames[] = 'Creature Adjustments';
			break;
		case 'Ark.EngramControl':
		case 'ArkSA.EngramControl':
		case 'EngramControl':
			$editorNames[] = 'Engram Control';
			break;
		case 'Ark.LevelsAndXP':
		case 'ArkSA.LevelsAndXP':
		case 'ExperienceCurves':
			$editorNames[] = 'Levels and XP';
			break;
		case 'Ark.HarvestRates':
		case 'ArkSA.HarvestRates':
		case 'HarvestRates':
			$editorNames[] = 'Harvest Rates';
			break;
		case 'Ark.LootDrops':
		case 'ArkSA.LootDrops':
		case 'LootDrops':
			$editorNames[] = 'Loot Drops';
			break;
		case 'Ark.GeneralSettings':
		case 'ArkSA.GeneralSettings':
		case 'SDTD.GeneralSettings':
		Case 'Palworld.GeneralSettings':
		case 'LootScale':
		case 'OtherSettings':
			$editorNames[] = 'General Settings';
			break;
		case 'Ark.CreatureSpawns':
		case 'ArkSA.CreatureSpawns':
		case 'SpawnPoints':
			$editorNames[] = 'Creature Spawns';
			break;
		case 'Ark.DecayAndSpoil':
		case 'ArkSA.DecayAndSpoil':
		case 'SpoilTimers':
			$editorNames[] = 'Decay and Spoil';
			break;
		case 'Ark.StackSizes':
		case 'ArkSA.StackSizes':
		case 'StackSizes':
			$editorNames[] = 'Stack Sizes';
			break;
		case 'Ark.StatLimits':
		case 'ArkSA.StatLimits':
		case 'StatLimits':
			$editorNames[] = 'Item Stat Limits';
			break;
		case 'Ark.StatMultipliers':
		case 'ArkSA.StatMultipliers':
		case 'StatMultipliers':
			$editorNames[] = 'Stat Multipliers';
			break;
		}
	}
	if (count($editorNames) > 0) {
		sort($editorNames);
		echo '<p>Contains Configs: ' . BeaconCommon::ArrayToEnglish(array_unique($editorNames)) . '</p>';
	}

	?>
</div>
<h3>Download</h3>
<div class="indent">
	<p><a href="https://<?php echo htmlentities($baseUrl); ?>" rel="nofollow">Download original project</a> or <a href="beacon://<?php echo htmlentities($baseUrl . '?name=' . urlencode($project->Title())); ?>" rel="nofollow">Open project in Beacon</a></p>
</div>
<h3>Create Game.ini</h3>
<div class="indent">
	<p>Create a customized Game.ini from this project.</p>
	<div id="mode_tabs"><div id="mode_tabs_new" class="selected">Create New</div><div id="mode_tabs_paste">Paste Text</div><div id="mode_tabs_upload">Upload File</div></div>
	<div id="mode_customizations">
		<input type="hidden" id="map_mask" name="mapMask" value="<?php echo ($mapFilter & $project->MapMask()); ?>">
		<table id="options_table">
		<?php if (count($maps) > 1) { ?><tr><td class="label">Include Maps:</td><td><?php

		foreach ($maps as $map) {
			$value = $map->Mask();
			$id = 'map_check_' . $value;
			echo ' <label class="checkbox"><input id="' . $id . '" type="checkbox" value="' . $value . '"' . (($mapFilter & $value) == $value ? ' checked' : '') . '><span></span>' . htmlentities($map->Label()) . '</label>';
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
				<input type="hidden" name="projectId" value="<?php echo htmlentities($project->ProjectID()); ?>">
				<input type="hidden" name="difficultyValue" value="" id="create_difficulty_value">
				<p class="text-center">
					<div class="input-radio"><input type="radio" name="mode" value="inline" id="create_inline_check" checked><label for="create_inline_check">Show new Game.ini in browser</label></div>
					<div class="input-radio"><input type="radio" name="mode" value="download" id="create_download_check"><label for="create_download_check">Download new Game.ini</label></div>
				</p>
				<p class="text-center"><input type="submit" value="Generate"></p>
			</form>
		</div>
		<div id="mode_view_paste">
			<p>Paste your current Game.ini here and a customized version will be produced for you.</p>
			<form action="generate" method="post">
				<input type="hidden" name="projectId" value="<?php echo htmlentities($project->ProjectID()); ?>">
				<input type="hidden" name="mode" value="inline">
				<input type="hidden" name="difficultyValue" value="" id="paste_difficulty_value">
				<textarea name="content" rows="20" wrap="off"></textarea>
				<p class="text-center"><input type="submit" value="Generate"></p>
			</form>
		</div>
		<div id="mode_view_upload">
			<p>Upload your current Game.ini to download a customized version.</p>
			<form action="generate" method="post" enctype="multipart/form-data">
				<input type="hidden" name="projectId" value="<?php echo htmlentities($project->ProjectID()); ?>">
				<input type="hidden" name="mode" value="download">
				<input type="hidden" name="difficultyValue" value="" id="upload_difficulty_value">
				<input type="file" name="content" accept=".ini" id="upload_file_selector">
				<p class="text-center"><input type="submit" id="upload_file_selector_button" value="Choose File"></p>
			</form>
		</div>
	</div>
</div>
