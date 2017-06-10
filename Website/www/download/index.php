<?php
require($_SERVER['SITE_ROOT'] . '/framework/loader.php');

$database = BeaconCommon::Database();
$results = $database->Query("SELECT mac_url, win_url, build_display, build_number FROM updates ORDER BY build_number DESC LIMIT 1;");
$mac_url = $results->Field('mac_url');
$win_url = $results->Field('win_url');
$version = $results->Field('build_display');
$build   = $results->Field('build_number');

$results = $database->Query("SELECT COUNT(classstring) AS preset_count FROM presets;");
$preset_count = $results->Field("preset_count");

$results = $database->Query("SELECT MAX(last_update) FROM updatable_objects WHERE min_version IS NULL OR min_version <= $1;", array($build));
$last_database_update = new DateTime($results->Field("max"), new DateTimeZone('UTC'));

define('MODE_NA', 0);
define('MODE_MAC', 1);
define('MODE_WIN', 2);

$mac_label = 'Download for macOS 10.9.5+';
$win_label = 'Download for Windows 7 SP1+';

$mode = MODE_NA;
if (BeaconCommon::IsMacOS()) {
	$mode = MODE_MAC;
	$primary_label = $mac_label;
	$primary_url = $mac_url;
	$alternate_label = $win_label;
	$alternate_url = $win_url;
} elseif (BeaconCommon::IsWindows()) {
	$mode = MODE_WIN;
	$primary_label = $win_label;
	$primary_url = $win_url;
	$alternate_label = $mac_label;
	$alternate_url = $mac_url;
}
?>
<h1>Current Version</h1>
<div class="indent">
	<p>Version <?php echo $version; ?></p>
<?php if ($mode == MODE_NA) { ?>
	<p class="text-center"><a class="button" href="<?php echo $mac_url; ?>"><?php echo htmlentities($mac_label); ?></a><a class="button" href="<?php echo $win_url; ?>"><?php echo htmlentities($win_label); ?></a></p>
<?php } else { ?>
	<p class="text-center"><a class="button" href="<?php echo $primary_url; ?>"><?php echo htmlentities($primary_label); ?></a><br><span class="mini">Or <a href="<?php echo $alternate_url; ?>"><?php echo htmlentities($alternate_label); ?></a></span></p>
<?php } ?>
</div>
<h3>Engrams Database</h3>
<div class="indent">
	<p><a href="classes.php?version=<?php echo $build; ?>">Download Engrams Database</a><br>Last updated <?php echo '<time datetime="' . $last_database_update->format('c') . '">' . $last_database_update->format('F jS, Y') . ' at ' . $last_database_update->format('g:i A') . ' UTC</time>'; ?>.</p>
</div>