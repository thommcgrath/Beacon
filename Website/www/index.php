<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');
BeaconTemplate::AddStylesheet('/assets/css/index.css');
BeaconTemplate::AddHeaderLine('<meta name="description" content="Using Ark\'s ConfigOverrideSupplyCrateItems to modify loot crate contents by hand is a maddening experience. Beacon makes it easy.">');

$hero_suffix = BeaconCommon::IsWindows() ? 'windows' : 'mac';

$database = BeaconCommon::Database();
$results = $database->Query('SELECT COUNT(object_id) AS loot_source_count FROM loot_sources;');
$loot_source_count = $results->Field('loot_source_count');
$rounded = floor($loot_source_count / 5) * 5;

?><div id="index_container">
	<div id="hero_container"><img id="hero" class="<?php echo $hero_suffix; ?>" src="/assets/images/spacer.png"></div>
	<div class="frontpage-left">
		<img src="/assets/images/landing-beacon.svg" class="landing-icon" height="60">
		<h1>Customize Any Loot Source</h1>
		<p>Beacon knows of over <?php echo $rounded; ?> official loot sources for the maps The Island, Scorched Earth, Aberration, The Center, and Ragnarok, including boss drops and artifact crates. Users of custom maps with custom loot sources are not out of luck either, because Beacon allows custom loot source definitions.</p>
	</div>
	<div class="frontpage-right">
		<img src="/assets/images/landing-database.svg" class="landing-icon" height="60">
		<h1>Actively Updated Cloud Database</h1>
		<p>Beacon automatically keeps its list of items up to date. In some cases, Beacon knows of new patch items before the patch is even released.</p>
		<p>And now with mod support, mod authors can add their items to Beacon's database. Using a mod which the author has not advertised to Beacon? No problem, Beacon can utilize admin spawn codes too.</p>
	</div>
	<div class="frontpage-left">
		<img src="/assets/images/landing-preset.svg" class="landing-icon" height="60">
		<h1>Includes Library of Templates</h1>
		<p>Crafting an entire loot table can be daunting task. Beacon includes handy presets such as &quot;Dino Consumables&quot; and &quot;Thatch Housing&quot; to serve has a starting point. Users can create their own presets or edit the built-in ones and even share their creations with other users.</p>
	</div>
	<div class="frontpage-right">
		<img src="/assets/images/landing-import.svg" class="landing-icon" height="60">
		<h1>Import from Game.ini and the Ark Dev Kit</h1>
		<p>Have some customized loot from another tool? Beacon can handle that. Item sets from the Ark Dev Kit can even be copied and pasted directly into Beacon. When its time to update server configs, either export everything or copy one (or more) loot sources and paste them directly into the config file.</p>
	</div>
</div>
