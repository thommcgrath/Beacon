<?php
require(dirname(__FILE__, 3) . '/framework/loader.php');

$database = BeaconCommon::Database();
$results = $database->Query("SELECT mac_url, win_32_url, win_64_url, win_combo_url, build_display, build_number, delta_version FROM updates WHERE stage >= 3 ORDER BY build_number DESC LIMIT 1;");
if ($results->RecordCount() != 1) {
	echo 'Whoops, no version information was found.';
	exit;
}

$primary_links = array();
$alternate_links = array();
$version = $results->Field('build_display');
$build = intval($results->Field('build_number'));
$stable_engrams_version = $results->Field('delta_version');

if (BeaconCommon::IsMacOS()) {
	$primary_links[] = array(
		'label' => 'Download for Mac',
		'url' => $results->Field('mac_url')
	);
	
	if (is_null($results->Field('win_64_url')) === false) {
		$alternate_links[] = array(
			'label' => 'Download for Windows (64-bit)',
			'url' => $results->Field('win_64_url')
		);
	}
	if (is_null($results->Field('win_32_url')) === false) {
		$alternate_links[] = array(
			'label' => 'Download for Windows (32-bit)',
			'url' => $results->Field('win_32_url')
		);
	}
	if ((is_null($results->Field('win_64_url')) || is_null($results->Field('win_32_url'))) && is_null($results->Field('win_combo_url')) === false) {
		$alternate_links[] = array(
			'label' => 'Download for Windows',
			'url' => $results->Field('win_combo_url')
		);
	}
} elseif (BeaconCommon::IsWindows()) {
	$is_64 = BeaconCommon::IsWindows64();
	
	if ($is_64 && is_null($results->Field('win_64_url')) === false) {
		$primary_links[] = array(
			'label' => 'Download for Windows',
			'url' => $results->Field('win_64_url')
		);
		
		if (is_null($results->Field('win_32_url')) === false) {
			$alternate_links[] = array(
				'label' => 'Download for Windows (32-bit)',
				'url' => $results->Field('win_32_url')
			);
		}
	} elseif ($is_64 === false && is_null($results->Field('win_32_url')) === false) {
		$primary_links[] = array(
			'label' => 'Download for Windows',
			'url' => $results->Field('win_32_url')
		);
		
		if (is_null($results->Field('win_64_url')) === false) {
			$alternate_links[] = array(
				'label' => 'Download for Windows (64-bit)',
				'url' => $results->Field('win_64_url')
			);
		}
	} elseif (is_null($results->Field('win_combo_url')) === false) {
		$primary_links[] = array(
			'label' => 'Download for Windows',
			'url' => $results->Field('win_combo_url')
		);
	} elseif (is_null($results->Field('win_64_url')) === false) {
		$primary_links[] = array(
			'label' => 'Download for Windows',
			'url' => $results->Field('win_64_url')
		);
	} elseif (is_null($results->Field('win_32_url')) === false) {
		$primary_links[] = array(
			'label' => 'Download for Windows',
			'url' => $results->Field('win_32_url')
		);
	}
	
	$alternate_links[] = array(
		'label' => 'Download for Mac',
		'url' => $results->Field('mac_url')
	);
} else {
	$primary_links[] = array(
		'label' => 'Download for Mac',
		'url' => $results->Field('mac_url')
	);
	
	if (is_null($results->Field('win_64_url')) === false) {
		$primary_links[] = array(
			'label' => 'Download for Windows (64-bit)',
			'url' => $results->Field('win_64_url')
		);
	}
	if (is_null($results->Field('win_32_url')) === false) {
		$primary_links[] = array(
			'label' => 'Download for Windows (32-bit)',
			'url' => $results->Field('win_32_url')
		);
	}
	if ((is_null($results->Field('win_64_url')) || is_null($results->Field('win_32_url'))) && is_null($results->Field('win_combo_url')) === false) {
		$primary_links[] = array(
			'label' => 'Download for Windows',
			'url' => $results->Field('win_combo_url')
		);
	}
}

$alternate_links[] = array(
	'label' => 'System Requirements',
	'url' => '#requirements'
);

$alternate_html = array();
foreach ($alternate_links as $link) {
	$alternate_html[] = '<a href="' . htmlentities(BeaconCommon::SignDownloadURL($link['url'])) . '" rel="nofollow">' . htmlentities($link['label']) . '</a>';
}

if ($stable_engrams_version >= 5) {
	$results = $database->Query('SELECT path, created FROM update_files WHERE version = $1 AND type = \'Complete\';', $stable_engrams_version);
	$last_database_update = new DateTime($results->Field('created'));
	$engrams_url = 'https://updates.usebeacon.app' . $results->Field('path');
} else {
	$last_database_update = BeaconCommon::NewestUpdateTimestamp($build);
	$engrams_url = 'classes.php?version=' . $build;
}
$prerelease = $database->Query('SELECT mac_url, win_64_url, win_combo_url, win_32_url, build_display, build_number, stage, delta_version FROM updates WHERE stage < 3 AND build_number > $1 ORDER BY build_number DESC LIMIT 1;', $build);
$stable_136 = $database->Query('SELECT win_combo_url FROM updates WHERE build_number = 10306300;');

?><h1>Current Version</h1>
<p class="text-center">Version <?php echo $version; ?></p>
<p class="text-center"><?php foreach ($primary_links as $link) { ?><a class="button" href="<?php echo BeaconCommon::SignDownloadURL($link['url']); ?>" rel="nofollow"><?php echo htmlentities($link['label']); ?></a><?php } ?><br><span class="mini"><?php echo implode(' | ' , $alternate_html); ?></span></p>
<h3>Engrams Database</h3>
<div class="indent">
	<p><a href="<?php echo $engrams_url; ?>" rel="nofollow">Download Engrams Database</a><br>Last updated <?php echo '<time datetime="' . $last_database_update->format('c') . '">' . $last_database_update->format('F jS, Y') . ' at ' . $last_database_update->format('g:i A') . ' UTC</time>'; ?>.</p>
</div>
<?php if ($prerelease->RecordCount() == 1) {
	
	$prerelease_links = array('<a href="' . htmlentities(BeaconCommon::SignDownloadURL($prerelease->Field('mac_url'))) . '" rel="nofollow">Mac Download</a>');
	$is_64 = BeaconCommon::IsMacOS() || BeaconCommon::IsWindows64();
	
	if (is_null($prerelease->Field('win_64_url')) && is_null($prerelease->Field('win_32_url'))) {
		$prerelease_links[] = '<a href="' . htmlentities(BeaconCommon::SignDownloadURL($prerelease->Field('win_combo_url'))) . '" rel="nofolow">Windows Download</a>';
	} else {
		if (is_null($prerelease->Field('win_64_url')) === false) {
			$label = 'Windows Download';
			if ($is_64 === false && is_null($prerelease->Field('win_32_url')) === false) {
				$label .= ' (64-bit)';
			}
			$prerelease_links[] = '<a href="' . htmlentities(BeaconCommon::SignDownloadURL($prerelease->Field('win_64_url'))) . '" rel="nofolow">' . $label . '</a>';
		}
		if (is_null($prerelease->Field('win_32_url')) === false) {
			$label = 'Windows Download';
			if ($is_64 === true && is_null($prerelease->Field('win_64_url')) === false) {
				$label .= ' (32-bit)';
			}
			$prerelease_links[] = '<a href="' . htmlentities(BeaconCommon::SignDownloadURL($prerelease->Field('win_32_url'))) . '" rel="nofolow">' . $label . '</a>';
		}
	}
	
	$prerelease_links[] = '<a href="/history.php?stage=' . htmlentities($prerelease->Field('stage')) . '#build' . htmlentities($prerelease->Field('build_number')) . '">Release Notes</a>';
	
	$prerelease_engrams_version = $prerelease->Field('delta_version');
	if ($prerelease_engrams_version == $stable_engrams_version) {
		$prerelease_engrams_url = $engrams_url;
	} elseif ($prerelease_engrams_version >= 5) {
		$results = $database->Query('SELECT path FROM update_files WHERE version = $1 AND type = \'Complete\';', $prerelease_engrams_version);
		$prerelease_engrams_url = 'https://updates.usebeacon.app' . $results->Field('path');
	} else {
		$prerelease_engrams_url = 'classes.php?version=' . $prerelease->Field('build_number');
	}
	$prerelease_links[] = '<a href="' . $prerelease_engrams_url . '" rel="nofollow">Engrams Database</a>';
?>
<h3 id="preview">Preview Release</h3>
<div class="indent">
	<p>Beacon <?php echo htmlentities($prerelease->Field('build_display')); ?> is available for testing. Preview releases may not be stable and users should make backups of any data they are not willing to lose. To create a backup, launch Beacon and choose &quot;Open Data Folder&quot; from the &quot;Help&quot; menu. The folder shown contains valuable user data. Copy the folder to a safe location, along with any Beacon files desired.</p>
	<p>Links: <?php echo implode(', ', $prerelease_links); ?></p>
</div>
<?php } ?>
<?php if ($stable_136->RecordCount() == 1) { ?>
<h3 id="legacy">Legacy Stable Version 1.3.6</h3>
<div class="indent">
	<p>In very rare cases, some users on Windows 7 are unable to connect to Nitrado using Beacon 1.4 and newer. While we wait for a bug fix from our dev tool provider, Beacon 1.3.6 is available as an alternative.</p>
	<p><a href="<?php echo htmlentities(BeaconCommon::SignDownloadURL($stable_136->Field('win_combo_url'))); ?>" rel="nofollow">Windows Download</a></p>
</div>
<?php } ?>
<h3 id="requirements">System Requirements</h3>
<div class="double_column">
	<div class="column">
		<p><strong>Mac</strong></p>
		<ul>
			<li>El Capitan (10.11), Sierra (10.12), High Sierra (10.13), Mojave (10.14), Catalina (10.15), or newer.</li>
		</ul>
	</div>
	<div class="column">
		<p><strong>Windows</strong></p>
		<ul>
			<li>Windows 7 with Service Pack 1, Windows 8, Windows 8.1, Windows 10, or newer.</li>
		</ul>
	</div>
</div>