<?php
require(dirname(__FILE__, 3) . '/framework/loader.php');

$database = BeaconCommon::Database();
$results = $database->Query("SELECT mac_url, win_32_url, win_64_url, win_combo_url, build_display, build_number FROM updates WHERE stage >= 3 ORDER BY build_number DESC LIMIT 1;");
if ($results->RecordCount() != 1) {
	echo 'Whoops, no version information was found.';
	exit;
}

$primary_links = array();
$alternate_links = array();
$version = $results->Field('build_display');
$build = intval($results->Field('build_number'));

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

$results = $database->Query("SELECT MAX(stamp) AS stamp FROM ((SELECT MAX(objects.last_update) AS stamp FROM objects INNER JOIN mods ON (objects.mod_id = mods.mod_id) WHERE objects.min_version <= $1 AND mods.confirmed = TRUE) UNION (SELECT MAX(action_time) AS stamp FROM deletions WHERE min_version <= $1) UNION (SELECT MAX(last_update) AS stamp FROM help_topics) UNION (SELECT MAX(last_update) AS stamp FROM game_variables)) AS merged;", $build);
$last_database_update = new DateTime($results->Field("stamp"), new DateTimeZone('UTC'));
$prerelease = $database->Query("SELECT mac_url, win_64_url, win_combo_url, win_32_url, build_display, build_number, stage FROM updates WHERE stage < 3 AND build_number > $1 ORDER BY build_number DESC LIMIT 1;", $build);

?><h1>Current Version</h1>
<p class="text-center">Version <?php echo $version; ?></p>
<p class="text-center"><?php foreach ($primary_links as $link) { ?><a class="button" href="<?php echo BeaconCommon::SignDownloadURL($link['url']); ?>" rel="nofollow"><?php echo htmlentities($link['label']); ?></a><?php } ?><br><span class="mini"><?php echo implode(' | ' , $alternate_html); ?></span></p>
<h3>Engrams Database</h3>
<div class="indent">
	<p><a href="classes.php?version=<?php echo $build; ?>" rel="nofollow">Download Engrams Database</a><br>Last updated <?php echo '<time datetime="' . $last_database_update->format('c') . '">' . $last_database_update->format('F jS, Y') . ' at ' . $last_database_update->format('g:i A') . ' UTC</time>'; ?>.</p>
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
	$prerelease_links[] = '<a href="classes.php?version=' . $prerelease->Field('build_number') . '" rel="nofollow">Engrams Database</a>';
?>
<h3 id="preview">Preview Release</h3>
<div class="indent">
	<p>Beacon <?php echo htmlentities($prerelease->Field('build_display')); ?> is available for testing. Preview releases may not be stable and users should make backups of any data they are not willing to lose. To create a backup, launch Beacon and choose &quot;Open Data Folder&quot; from the &quot;Help&quot; menu. The folder shown contains valuable user data. Copy the folder to a safe location, along with any Beacon files desired.</p>
	<p>Links: <?php echo implode(', ', $prerelease_links); ?></p>
</div>
<?php } ?>
<h3 id="requirements">System Requirements</h3>
<div class="double_column">
	<div class="column">
		<p><strong>Mac</strong></p>
		<ul>
			<li>El Capitan (10.11), Sierra (10.12), High Sierra (10.13), Mojave (10.14), or newer.</li>
		</ul>
	</div>
	<div class="column">
		<p><strong>Windows</strong></p>
		<ul>
			<li>Windows 7 with Service Pack 1, Windows 8, Windows 8.1, Windows 10, or newer.</li>
		</ul>
	</div>
</div>