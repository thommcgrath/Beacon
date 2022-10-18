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

$database = BeaconCommon::Database();
$download_links = [
	'current' => BuildLinks($stable)
];
if ($prerelease && $prerelease['build_number'] > $stable['build_number']) {
	$download_links['preview'] = BuildLinks($prerelease);
}

BeaconTemplate::StartScript();
?><script>
let updateScreenNotice = function() {
	let screen = window.screen;
	let screenWidthPoints = screen.width;
	let screenHeightPoints = screen.height;
	let screenWidthPixels = screenWidthPoints * window.devicePixelRatio;
	let screenHeightPixels = screenHeightPoints * window.devicePixelRatio;
	
	let isMac = navigator.platform.indexOf('Mac') > -1;
	let isWindows = navigator.platform.indexOf('Win') > -1;
	
	let notice = null;
	if (screenWidthPoints < 1280 || screenHeightPoints < 720) {
		notice = 'This screen may not be supported. A resolution of at least 1280x720 points is required.';
		if (screenWidthPixels >= 1280 && screenHeightPixels >= 720) {
			let maxScalingSupported = Math.round(Math.min(screenWidthPixels / 1280, screenHeightPixels / 720) * 100);
			if (isWindows) {
				notice = 'Your display scaling settings may prevent Beacon from fitting on your screen. If you experience trouble fitting Beacon\'s window on your screen, try changing your display scaling to ' + maxScalingSupported + '% or lower. <a href="https://www.windowscentral.com/how-set-custom-display-scaling-setting-windows-10#change_display_scaling_default_settings_windows10">Learn how to change scaling settings.</a>';
			}
		}
	}
	
	if (notice) {
		let screenNotice = document.getElementById('screenCompatibilityNotice');
		screenNotice.innerHTML = notice;
		screenNotice.classList.remove('hidden');
	}
};

const buildDownloadsTable = async () => {
	const downloadMac = 'macOS';
	const downloadWinUniversal = 'windows-universal';
	const downloadWinIntel64 = 'windows-x64';
	const downloadWinIntel = 'windows-x86';
	const downloadWinARM64 = 'windows-arm64';
	
	let priorities = [downloadWinIntel64, downloadMac, downloadWinIntel, downloadWinARM64];
	let hasRecommendation = false;
	
	switch (navigator.platform) {
	case 'Win32':
		// Try to use client hints to determine the best version, but this isn't supported in Firefox
		if ('userAgentData' in navigator) {
			await navigator.userAgentData.getHighEntropyValues(['architecture', 'bitness']).then((ua) => {
				if (ua.bitness == 32) {
					priorities = [downloadWinIntel, downloadWinIntel64, downloadWinARM64, downloadMac];
					hasRecommendation = true;
				} else if (ua.bitness == 64) {
					if (ua.architecture == 'arm') {
						priorities = [downloadWinARM64, downloadWinIntel, downloadWinIntel64, downloadMac];
						hasRecommendation = true;
					} else if (ua.architecture == 'x86') {
						priorities = [downloadWinIntel64, downloadWinIntel, downloadWinARM64, downloadMac];
						hasRecommendation = true;
					}
				}
			}).catch(() => {});
		}
		if (hasRecommendation === false) {
			priorities = [downloadWinUniversal, downloadWinIntel64, downloadWinIntel, downloadWinARM64, downloadMac];
			hasRecommendation = true;	
		}
		break;
	case 'MacIntel':
		// Mac is simple, there's only one version
		priorities = [downloadMac, downloadWinIntel64, downloadWinIntel, downloadWinARM64];
		hasRecommendation = true;
		break;
	}
	
	const addChildRow = (table, label, url, buttonCaption = 'Download') => {
		let childRow = document.createElement('div');
		childRow.classList.add('row');
		let childLabel = document.createElement('div');
		childLabel.classList.add('label');
		childLabel.innerHTML = label;
		let childDownload = document.createElement('div');
		childDownload.classList.add('button');
		let childButton = document.createElement('a');
		childButton.classList.add('button');
		childButton.href = url;
		childButton.innerText = buttonCaption;
		childButton.setAttribute('rel', 'nofollow');
		childDownload.appendChild(childButton);
		childRow.appendChild(childLabel);
		childRow.appendChild(childDownload);
		table.appendChild(childRow);
	};
	
	const addChildRows = (table, data, recommend) => {
		if (hasRecommendation === false) {
			let warningRow = document.createElement('div');
			warningRow.classList.add('row');
			let warningLabel = document.createElement('div');
			warningLabel.classList.add('full');
			warningLabel.classList.add('text-red');
			warningLabel.innerText = 'Sorry, this version of Beacon is not compatible with your device. But just in case a mistake was made, here are the download links.';
			warningRow.appendChild(warningLabel)
			table.appendChild(warningRow);
		}
		
		let first = true; // Set first only after a row is added, in case one gets skipped
		for (const downloadKey of priorities) {
			let recommendedTag = (recommend === true && hasRecommendation === true && first === true) ? '<span class="tag blue mini left-space">Recommended</span>' : '';
			
			switch (downloadKey) {
			case downloadMac:
				if (data.hasOwnProperty('mac_url')) {
					addChildRow(table, `Mac${recommendedTag}<br><span class="mini text-lighter">For macOS ${data.mac_display_versions}</span>`, data.mac_url);
					first = false;
				}
				break;
			case downloadWinIntel:
				if (data.hasOwnProperty('win_32_url')) {
					addChildRow(table, `Windows x86 32-bit${recommendedTag}<br><span class="mini text-lighter">For 32-bit versions of ${data.win_display_versions}</span>`, data.win_32_url);
					first = false;
				}
				break;
			case downloadWinIntel64:
				if (data.hasOwnProperty('win_64_url')) {
					addChildRow(table, `Windows x86 64-bit${recommendedTag}<br><span class="mini text-lighter">For 64-bit versions of ${data.win_display_versions}</span>`, data.win_64_url);
					first = false;
				}
				break;
			case downloadWinARM64:
				if (data.hasOwnProperty('win_arm64_url')) {
					addChildRow(table, `Windows ARM 64-bit${recommendedTag}<br><span class="mini text-lighter">For 64-bit versions of ${data.win_arm_display_versions}</span>`, data.win_arm64_url);
					first = false;
				}
				break;
			case downloadWinUniversal:
				if (data.hasOwnProperty('win_combo_url')) {
					addChildRow(table, `Windows Universal${recommendedTag}<br><span class="mini text-lighter">For all versions of ${data.win_display_versions}</span>`, data.win_combo_url);
					first = false;
				}
				break;
			}
		}
		
		addChildRow(table, 'Engrams Database, updated <time datetime="' + data.engrams_date + '">' + data.engrams_date_display + '</time>', data.engrams_url);
		addChildRow(table, 'Release Notes', data.history_url, 'View');
	};
	
	const download_data = <?php echo json_encode($download_links, JSON_PRETTY_PRINT); ?>;
	let stable_table = document.getElementById('stable-table');
	let prerelease_table = document.getElementById('prerelease-table');
	let legacy_table = document.getElementById('legacy-table');
	
	let current = download_data.current;
	let headerRow = document.createElement('div');
	headerRow.classList.add('row');
	let headerBody = document.createElement('div');
	headerBody.classList.add('full');
	headerBody.innerText = 'Stable Version: Beacon ' + current.build_display;
	headerRow.appendChild(headerBody);
	stable_table.appendChild(headerRow);
	
	addChildRows(stable_table, current, true);
	
	let prerelease = download_data.preview;
	if (prerelease) {
		let headerRow = document.createElement('div');
		headerRow.classList.add('row');
		let headerBody = document.createElement('div');
		headerBody.classList.add('full');
		headerBody.innerText = 'Preview Version: Beacon ' + prerelease.build_display;
		headerRow.appendChild(headerBody);
		prerelease_table.appendChild(headerRow);
		
		addChildRows(prerelease_table, prerelease, false);
	} else {
		prerelease_table.classList.add('hidden');
	}
	
	let legacy = download_data.legacy;
	if (legacy) {
		let headerRow = document.createElement('div');
		headerRow.classList.add('row');
		let headerBody = document.createElement('div');
		headerBody.classList.add('full');
		headerBody.innerText = 'Legacy Version: Beacon ' + legacy.build_display;
		headerRow.appendChild(headerBody);
		legacy_table.appendChild(headerRow);
		
		addChildRows(legacy_table, legacy, false);
	} else {
		legacy_table.classList.add('hidden');
	}
	
	document.getElementById('mac_version_requirements').innerText = 'macOS ' + current.mac_display_versions;
	document.getElementById('win_version_requirements').innerText = current.win_display_versions;
};

document.addEventListener('DOMContentLoaded', function() {
	updateScreenNotice();
	buildDownloadsTable();
});

</script><?php
BeaconTemplate::FinishScript();

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
	/*if ($min_mac_version <= 101800) {
		$mac_versions[] = '13 Ventura';
	}*/
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
	if ($min_win_version <= 603009600) {
		$win_versions[] = 'Windows 8.1';
	}
	if ($min_win_version <= 603009200) {
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