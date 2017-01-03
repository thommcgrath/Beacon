<?php
require_once($_SERVER['DOCUMENT_ROOT'] . '/php/engine.php');
$page_title = 'Beacon';

AddHeadLine('<link rel="stylesheet" href="/beacon/assets/beacon.css" type="text/css">');

$database = ConnectionManager::BeaconDatabase();
$results = $database->Query("SELECT mac_url, win_url, build_display FROM updates ORDER BY build_number DESC LIMIT 1;");
$mac_url = $results->Field('mac_url');
$win_url = $results->Field('win_url');
$version = $results->Field('build_display');

$results = $database->Query("SELECT COUNT(classstring) AS preset_count FROM presets;");
$preset_count = $results->Field("preset_count");

$results = $database->Query("SELECT MAX(max) FROM ((SELECT MAX(last_update AT TIME ZONE 'UTC') FROM loot_sources) UNION (SELECT MAX(last_update AT TIME ZONE 'UTC') FROM presets) UNION (SELECT MAX(last_update AT TIME ZONE 'UTC') FROM engrams)) AS dates;");
$last_database_update = new DateTime($results->Field("max"), new DateTimeZone('UTC'));

define('MODE_NA', 0);
define('MODE_MAC', 1);
define('MODE_WIN', 2);

$mode = MODE_NA;
$hero_name = 'HeroMac';
if (IsMacOS()) {
	$mode = MODE_MAC;
} elseif (IsWindows()) {
	$mode = MODE_WIN;
	$hero_name = 'HeroWindows';
}

$mac_label = 'macOS 10.9.5+';
$win_label = 'Windows 7 SP1+';
$hero_name = '/beacon/assets/images/' . $hero_name;

?>
<div class="articleheader">
	<h1>Beacon</h1>
	<p>Beacon is a tool for customizing the contents of loot sources in Ark: Survival Evolved.</p>
</div>
<div class="articlebody">
	<div class="right-screenshot"><img src="<?php echo $hero_name; ?>.png" srcset="<?php echo $hero_name; ?>.png 1x, <?php echo $hero_name; ?>@2x.png 2x, <?php echo $hero_name; ?>@3x.png 3x" width="427" height="351" alt=""><p>Customize any of the loot sources in Ark: Survival Evolved.</p></div>
	<p>Beacon is an open source tool that allows server admins for Ark: Survival Evolved to customize the contents of loot sources. These are the beacons that descend from the sky, crates in caves, and crates deep in the sea.</p>
	<p><?php echo number_format($preset_count, 0); ?> pre-defined sets are included that can be placed into loot sources. Beacon is aware of all built-in items in the game, including for Scorched Earth. And items from mods can be included by using their class strings.</p> 
	<p>For admins who have already customized their loot sources, Beacon can import an existing Game.ini file. Getting the updated sources back into the server's Game.ini is as easy as exporting a new file, or loot sources can be copied from Beacon and pasted into the file using a text editor. Users can customize any of the presets, and even share entire document sets online.</p>
	<p>Beacon deals with quality codes for you. No more trying to understand the difference between a 1.5 and 4.0 quality item, Beacon knows this for you. Simply select from any of the standard quality names, or even use one of the custom quality values like &quot;Pearlescent&quot; for truly overpowered loot.</p>
	<p class="text-center"><a href="/beacon/gettingstarted/">Getting Started</a> | <a href="/beacon/documents.php/1616b43c-9efd-4441-bfc2-bb153185216a">Sample Document</a></p>
	<div class="push">&nbsp;</div>
	<?php switch ($mode) {
	case MODE_NA: ?>
	<p class="text-center">Sorry, Beacon is not available on your platform. But you can still <a href="<?php echo $mac_url; ?>">download Beacon for <?php echo $mac_label; ?></a> or <a href="<?php echo $win_url; ?>">download Beacon for <?php echo $win_label; ?></a>.</p>
	<?php break;
	case MODE_MAC: ?>
	<p class="text-center"><a href="<?php echo $mac_url; ?>" class="download-button">Download for <?php echo $mac_label; ?></a><br><a href="<?php echo $win_url; ?>" class="download-alternate">Or Download for <?php echo $win_label; ?></a></p>
	<?php break;
	case MODE_WIN: ?>
	<p class="text-center"><a href="<?php echo $win_url; ?>" class="download-button">Download for <?php echo $win_label; ?></a><br><a href="<?php echo $mac_url; ?>" class="download-alternate">Or Download for <?php echo $mac_label; ?></a></p>
	<?php break;
	} ?>
	<p class="text-center">Version <?php echo $version; ?>. Engrams database last updated <?php echo '<time datetime="' . $last_database_update->format('c') . '">' . $last_database_update->format('F jS, Y') . ' at ' . $last_database_update->format('g:i A T') . '</time>'; ?>.</p>
	<p class="text-center"><a href="https://github.com/thommcgrath/Beacon"><img src="/gfx/GitHubLogo.png" srcset="/gfx/GitHubLogo.png 1x, /gfx/GitHubLogo@2x.png 2x, /gfx/GitHubLogo@3x.png 3x" width="93" height="25" alt="Beacon on GitHub"></a></p>
</div>