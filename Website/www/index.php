<?php

require($_SERVER['SITE_ROOT'] . '/framework/loader.php');
BeaconTemplate::AddStylesheet('index.css');
BeaconTemplate::AddHeaderLine('<meta name="description" content="Using Ark\'s ConfigOverrideSupplyCrateItems to modify loot crate contents by hand is a maddening experience. Beacon makes it easy.">');

?><p class="text-center"><img id="hero" src="/assets/images/hero.svg"></p>
<div class="frontpage-left">
	<img src="/assets/images/landing-beacon.svg" class="landing-icon" height="60">
	<h1>Customize any loot source</h1>
	<p>Beacon knows of over 70 official loot sources for the maps The Island, Scorched Earth, The Center, and Ragnarok, including boss drops and artifact crates. Users of custom maps with custom loot sources are not out of luck either, because Beacon allows custom loot source definitions.</p>
</div>
<div class="frontpage-right">
	<img src="/assets/images/landing-database.svg" class="landing-icon" height="60">
	<h1>Actively updated cloud database</h1>
	<p>Beacon automatically keeps its list of items up to date. In some cases, Beacon knows of new patch items before the patch is even released.</p>
	<p>And now with mod support, mod authors can add their items to Beacon's database. Using a mod which the author has not advertised to Beacon? No problem, Beacon can utilize admin spawn codes too.</p>
</div>
<div class="frontpage-left">
	<img src="/assets/images/landing-preset.svg" class="landing-icon" height="60">
	<h1>Includes library of presets</h1>
	<p>Crafting an entire loot table can be daunting task. Beacon includes handy presets such as &quot;Dino Consumables&quot; and &quot;Thatch Housing&quot; to serve has a starting point. Users can create their own presets or edit the built-in ones and even share their creations with other users.</p>
</div>
<div class="frontpage-right">
	<img src="/assets/images/landing-import.svg" class="landing-icon" height="60">
	<h1>Import from Game.ini and Ark Dev Kit</h1>
	<p>Have some customized loot from another tool? Beacon can handle that. Item sets from the Ark Dev Kit can even be copied and pasted directly into Beacon. When its time to update server configs, either export everything or copy one (or more) loot sources and paste them directly into the config file.</p>
</div>