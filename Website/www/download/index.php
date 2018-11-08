<?php
require($_SERVER['SITE_ROOT'] . '/framework/loader.php');

$database = BeaconCommon::Database();
$results = $database->Query("SELECT mac_url, win_url, build_display, build_number FROM updates ORDER BY build_number DESC LIMIT 1;");
if ($results->RecordCount() != 1) {
	echo 'Whoops, no version information was found.';
	exit;
}
$mac_url = $results->Field('mac_url');
$win_url = $results->Field('win_url');
$version = $results->Field('build_display');
$build   = intval($results->Field('build_number'));

$results = $database->Query("SELECT MAX(last_update) FROM objects WHERE min_version <= $1;", array($build));
$last_database_update = new DateTime($results->Field("max"), new DateTimeZone('UTC'));

define('MODE_NA', 0);
define('MODE_MAC', 1);
define('MODE_WIN', 2);

$mac_label = 'Download for Mac';
$win_label = 'Download for Windows';

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
<p class="text-center">Version <?php echo $version; ?></p>
<?php if ($mode == MODE_NA) { ?>
<p class="text-center"><a class="button" href="<?php echo $mac_url; ?>"><?php echo htmlentities($mac_label); ?></a><a class="button" href="<?php echo $win_url; ?>"><?php echo htmlentities($win_label); ?></a><br><span class="mini"><a href="#requirements">System Requirements</a></span></p>
<?php } else { ?>
<p class="text-center"><a class="button" href="<?php echo $primary_url; ?>"><?php echo htmlentities($primary_label); ?></a><br><span class="mini">Or <a href="<?php echo $alternate_url; ?>"><?php echo htmlentities($alternate_label); ?></a> | <a href="#requirements">System Requirements</a></span></p>
<?php } ?>
<div class="patreon_box"><p><a href="/donate.php" class="button">Donate</a></p><p>Beacon may be free, but developing it isn't. Consider helping out with a couple bucks towards things like server rentals.</p></div>
<h3>Engrams Database</h3>
<div class="indent">
	<p><a href="classes.php?version=<?php echo $build; ?>">Download Engrams Database</a><br>Last updated <?php echo '<time datetime="' . $last_database_update->format('c') . '">' . $last_database_update->format('F jS, Y') . ' at ' . $last_database_update->format('g:i A') . ' UTC</time>'; ?>.</p>
</div>
<h3 id="requirements">System Requirements</h3>
<div class="double_column">
	<div class="column">
		<p><strong>Mac</strong></p>
		<ul>
			<li>Yosemite, El Capitan, Sierra, High Sierra, Mojave, or newer.</li>
		</ul>
	</div>
	<div class="column">
		<p><strong>Windows</strong></p>
		<ul>
			<li>Windows 7 with Service Pack 1, Windows 8, Windows 8.1, Windows 10, or newer.</li>
			<li>64-bit edition of Windows.</li>
		</ul>
	</div>
</div>