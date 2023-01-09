<?php
require(dirname(__FILE__, 3) . '/framework/loader.php');
header('Cache-Control: no-cache');
//header('Accept-CH: UA-Mobile, UA-Arch, UA-Platform, UA-Bitness');
?><p class="notice-block notice-caution hidden" id="screenCompatibilityNotice"></p>
<div id="stable-table" class="downloads-table"></div>
<div id="prerelease-table" class="downloads-table"></div>
<div id="legacy-table" class="downloads-table"></div>
<h3 id="requirements">System Requirements</h3>
<div class="double_column">
	<div class="column">
		<p><strong>Mac</strong></p>
		<ul>
			<li id="mac_version_requirements">Big Sur (11), El Capitan (10.11), Sierra (10.12), High Sierra (10.13), Mojave (10.14), Catalina (10.15), or newer.</li>
			<li>1280x720 screen resolution or greater. Retina screens will need 2560x1440 pixels or greater.</li>
		</ul>
	</div>
	<div class="column">
		<p><strong>Windows</strong></p>
		<ul>
			<li id="win_version_requirements">Windows 7 with Service Pack 1, Windows 8, Windows 8.1, Windows 10, Windows 11, or newer.</li>
			<li>1280x720 screen resolution or greater. Windows scaling settings will affect this number. For example, a 150% scaling setting would require 1.5 times more pixels, which is 1920x1080. At 200% scaling, the minimum screen resolution is 2560x1440.</li>
		</ul>
	</div>
</div><?php

$stable = BeaconUpdates::FindLatestInChannel(BeaconUpdates::CHANNEL_STABLE);
$prerelease = BeaconUpdates::FindLatestInChannel(BeaconUpdates::CHANNEL_ALPHA);
$legacy = BeaconUpdates::GetUpdateByBuildNumber(10601303);

$database = BeaconCommon::Database();
$download_links = [
	'current' => BuildLinks($stable)
];
if ($prerelease && $prerelease['build_number'] > $stable['build_number']) {
	$download_links['preview'] = BuildLinks($prerelease);
}
if ($legacy) {
	$download_links['legacy'] = BuildLinks($legacy);
}

BeaconTemplate::StartScript();
?><script>
const downloadData = <?php echo json_encode($download_links, JSON_PRETTY_PRINT); ?>;
</script><?php
BeaconTemplate::FinishScript();
BeaconTemplate::AddScript(BeaconCommon::AssetURI('download.js'));

function BuildLinks(array $update): array {
	$build = $update['build_number'];
	$delta_version = $update['delta_version'];
	$stage = $update['stage'];
	
	$data = [
		'build_display' => $update['build_display'],
		'build_number' => $build,
		'stage' => $stage,
		'mac_url' => BeaconCommon::SignDownloadURL(array_key_first($update['files'][BeaconUpdates::PLATFORM_MACOS]), 300)
	];
		
	foreach ($update['files'][BeaconUpdates::PLATFORM_WINDOWS] as $url => $architectures) {
		switch ($architectures) {
		case BeaconUpdates::ARCH_INTEL32:
			$data['win_32_url'] = BeaconCommon::SignDownloadURL($url, 300);
			break;
		case BeaconUpdates::ARCH_INTEL64:
			$data['win_64_url'] = BeaconCommon::SignDownloadURL($url, 300);
			break;
		case BeaconUpdates::ARCH_INTEL:
		case BeaconUpdates::ARCH_INTEL | BeaconUpdates::ARCH_ARM64:
			$data['win_combo_url'] = BeaconCommon::SignDownloadURL($url, 300);
			break;
		case BeaconUpdates::ARCH_ARM64:
			$data['win_arm64_url'] = BeaconCommon::SignDownloadURL($url, 300);
			break;
		}
	}
	
	$min_mac_version = $update['min_mac_version'];
	list($mac_major, $mac_minor, $mac_bug) = explode('.', $min_mac_version, 3);
	$min_mac_version = ($mac_major * 10000) + ($mac_minor * 100) + $mac_bug;
	$mac_versions = [];
	if ($min_mac_version <= 101800 && $build >= 10602000) {
		$mac_versions[] = '13 Ventura';
	}
	if ($min_mac_version <= 101700) {
		$mac_versions[] = '12 Monterey';
	}
	if ($min_mac_version <= 101600) {
		$mac_versions[] = '11 Big Sur';
	}
	if ($min_mac_version <= 101500) {
		$mac_versions[] = '10.15 Catalina';
	}
	if ($min_mac_version <= 101400) {
		$mac_versions[] = '10.14 Mojave';
	}
	if ($min_mac_version <= 101300) {
		$mac_versions[] = '10.13 High Sierra';
	}
	if ($min_mac_version <= 101200) {
		$mac_versions[] = '10.12 Sierra';
	}
	if ($min_mac_version <= 101100) {
		$mac_versions[] = '10.11 El Capitan';
	}
	$data['mac_display_versions'] = BeaconCommon::ArrayToEnglish($mac_versions, 'or');
	
	$min_win_version = $update['min_win_version'];
	list($win_major, $win_minor, $win_build) = explode('.', $min_win_version, 3);
	$min_win_version = ($win_major * 100000000) + ($win_minor * 1000000) + $win_build;
	$win_versions = [];
	$win_arm_versions = [];
	if ($min_win_version <= 1000022000) {
		$win_versions[] = 'Windows 11';
		if (array_key_exists('win_arm64_url', $data)) {
			$win_arm_versions[] = 'Windows 11';
		}
	}
	if ($min_win_version <= 1000010240) {
		$win_versions[] = 'Windows 10';
		if (array_key_exists('win_arm64_url', $data)) {
			$win_arm_versions[] = 'Windows 10';
		}
	}
	if ($min_win_version <= 603009200) {
		$win_versions[] = 'Windows 8.1';
	}
	if ($min_win_version <= 602009200) {
		$win_versions[] = 'Windows 8';
	}
	if ($min_win_version <= 601007601) {
		$win_versions[] = 'Windows 7 with Service Pack 1';
	}
	$data['win_display_versions'] = BeaconCommon::ArrayToEnglish($win_versions, 'or');
	if (array_key_exists('win_arm64_url', $data)) {
		$data['win_arm_display_versions'] = BeaconCommon::ArrayToEnglish($win_arm_versions, 'or');
	}
	
	if ($delta_version >= 5) {
		$database = BeaconCommon::Database();
		$results = $database->Query('SELECT path, created FROM update_files WHERE version = $1 AND type = \'Complete\';', $delta_version);
		$last_database_update = new DateTime($results->Field('created'));
		$data['engrams_url'] = 'https://updates.usebeacon.app' . $results->Field('path');
	} else {
		$last_database_update = BeaconCommon::NewestUpdateTimestamp($build);
		$data['engrams_url'] = BeaconCommon::AbsoluteURL('/download/classes?version=' . $build);
	}
	$data['engrams_date'] = $last_database_update->format('c');
	$data['engrams_date_display'] = $last_database_update->format('F jS, Y') . ' at ' . $last_database_update->format('g:i A') . ' UTC';
	
	$data['history_url'] = BeaconCommon::AbsoluteURL('/history?stage=' . $stage . '#build' . $build);
	
	return $data;
}

?>