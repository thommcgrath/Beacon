<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');
BeaconTemplate::SetPageDescription('Beacon is Ark\'s easiest server manager that can update and control your Xbox, PS4, and PC Ark servers with a couple clicks.');

BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('index.css'));

BeaconTemplate::StartScript();
?><script>

document.addEventListener("DOMContentLoaded", function() {
	if (window.navigator.platform === 'Win32') {
		document.getElementById('hero').classList.add('windows');
	}
});

</script><?php
BeaconTemplate::FinishScript();

$public_build = BeaconCommon::MinVersion();
$database = BeaconCommon::Database();
$results = $database->Query('SELECT COUNT(object_id) AS loot_source_count, experimental FROM ark.loot_sources WHERE min_version <= $1 GROUP BY experimental;', $public_build);
while (!$results->EOF()) {
	if ($results->Field('experimental')) {
		$unofficial_source_count = $results->Field('loot_source_count');
	} else {
		$official_source_count = $results->Field('loot_source_count');
	}
	$results->MoveNext();
}

?>
<div id="nitrado_container">
	<a href="https://www.nitrado-aff.com/5LMHK7/D42TT/"><img id="nitrado_logo" class="white-on-dark" src="<?php echo BeaconCommon::AssetURI('spacer.png'); ?>" alt="Get your server from Nitrado"></a>
</div>
<div id="hero_container"><img id="hero" src="<?php echo BeaconCommon::AssetURI('spacer.png'); ?>" alt="Beacon main window"></div>
<div id="index_body">
	<div id="index_features">
		<div class="feature">
			<div class="header-with-subtitle">
				<h2>Over <?php echo floor($official_source_count / 5) * 5; ?> loot drops and counting</h2>
				<div class="subtitle text-red">Beacon knows them all, so you can get going quicker</div>
			</div>
			<p>Normal drops, cave crates, boss loot, beaver dams&hellip; whatever you want to change. Plus support for custom loot drops, such as those provided by mod maps or not officially supported by Ark. Plus, Beacon has support for an additional <?php echo $unofficial_source_count; ?> unofficial loot drops, such as the Orbital Supply Drop events and creature inventories.</p>
		</div>
		<div class="feature">
			<div class="header-with-subtitle">
				<h2>No need to start from scratch</h2>
				<div class="subtitle text-green">Unless you want to, that's cool too</div>
			</div>
			<p>Beacon has a library of community-maintained documents, both in-app and <a href="/browse/">on the web</a>, ready to be deployed to your own server.</p>
			<p>Beacon also has a library of templates for smaller chunks of the loot config process. This makes it easy to include a curated selection of items in your drops without all the work of starting from scratch.</p>
		</div>
		<div class="feature">
			<div class="header-with-subtitle">
				<h2>Easiest, most reliable way to configure a server</h2>
				<div class="subtitle text-blue">Works directly with Nitrado servers</div>
			</div>
			<p>For users hosted with Nitrado, Beacon can handle the entire configuration process automatically. It will start and stop the server, change settings, create backups, and update files as needed to ensure your server - or a whole cluster of servers - are configured correctly. And it can do it while you get a coffee.</p>
			<p>Not with Nitrado? No problem, Beacon supports FTP, FTP with TLS, and SFTP servers too. While it can't restart the server for you, it can still update your files automatically.</p>
			<p>No FTP either? Copy &amp; Paste to the rescue. Simply copy your entire config file, and with a single click, Beacon will update your config so you can paste it back where it needs to go.</p>
			<p>And of course, you can just save the config files to your computer too, which is great for single player.</p>
		</div>
		<div class="feature">
			<div class="header-with-subtitle">
				<h2>Takes user privacy seriously</h2>
				<div class="subtitle text-purple">No analytics, heavy encryption, true anonymity, and fully open source</div>
			</div>
			<p>Config files contain server passwords. So Beacon encrypts those with your own 2048-bit RSA private key. FTP credentials or Nitrado access tokens? Yep, those too. That private key enables Beacon's cloud features too, yet you don't even need to setup an account! For users who choose to create an account, even your email address is stored as a one-way hash! Beacon and the Beacon API take special care to enable true privacy and user data protection.</p>
		</div>
		<div class="feature">
			<div class="header-with-subtitle">
				<h2>Plus mods and more</h2>
				<div class="subtitle text-yellow">Painlessly add engrams, loot drops, creatures, and spawn points from any mod</div>
			</div>
			<p>Users wanting to add mod items to their loot drops only need a list of the admin spawn codes. Give Beacon the link to the web page with the codes, or copy &amp; paste them, and Beacon can do the rest. No special formatting required, Beacon will scour the content for spawn codes.</p>
			<p>Mod authors can also <a href="/help/registering_your_mod_with_beacon">add support for their mod</a> directly to Beacon. The items show up to all Beacon users automatically, and Beacon will also maintain a spawn codes page just for your mod. For example, <a href="/mods/1999447172/spawncodes">here is the spawn codes for Super Structures</a>. The engrams list can be updated at any time from within Beacon, or Beacon's API can pull the engrams list from your own server (or Steam page) every few hours.</p>
		</div>
	</div>
	<div id="index_updates" class="separator-color text-lighter">
		<h3>Recent Updates</h3>
		<ul>
			<?php
			
			$results = $database->Query('SELECT title, detail, url FROM news WHERE stage >= 3 AND moment <= CURRENT_TIMESTAMP ORDER BY moment DESC LIMIT 4;');
			while (!$results->EOF()) {
				echo '<li>';
				echo '<div class="title">' . htmlentities($results->Field('title')) . '</div>';
				if (is_string($results->Field('detail')) && $results->Field('detail') != '') {
					echo '<div class="detail">' . nl2br(htmlentities($results->Field('detail')), false) . '</div>';
				}
				if (is_string($results->Field('url')) && $results->Field('url') != '') {
					echo '<div class="more"><a href="' . htmlentities($results->Field('url')) . '">Read More &hellip;</a></div>';
				}
				echo '</li>';
				$results->MoveNext();
			}
			
			?>
		</ul>
	</div>
</div>
