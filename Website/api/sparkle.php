<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');
header('Cache-Control: no-cache');

$stage = 3;
if (isset($_GET['stage'])) {
	$stage = intval($_GET['stage']);
}

$current_build = 0;
if (isset($_GET['build'])) {
	$current_build = intval($_GET['build']);
}

// Beacon 1.2.0 and its betas did not report architecture correctly
$device_mask = BeaconUpdates::ARCH_INTEL32;
$arch_str = 'x86';
if (isset($_GET['arch'])) {
	$arch_str = $_GET['arch'];
	switch ($_GET['arch']) {
	case 'x86':
		$device_mask = BeaconUpdates::ARCH_INTEL32;
		break;
	case 'x86_64':
	case 'x64':
		$device_mask = BeaconUpdates::ARCH_INTEL64;
		$arch_str = 'x64';
		break;
	case 'arm':
		$device_mask = BeaconUpdates::ARCH_ARM32;
		break;
	case 'arm64':
	case 'arm_64':
		$device_mask = BeaconUpdates::ARCH_ARM64;
		$arch_str = 'x64';
		break;
	}
}

$platform = 'any';
$device_os = null;
if (isset($_GET['platform'])) {
	switch ($_GET['platform']) {
	case 'mac':
		$platform = BeaconUpdates::PLATFORM_MACOS;
		break;
	case 'win':
		$platform = BeaconUpdates::PLATFORM_WINDOWS;
		break;
	case 'lin':
		$platform = BeaconUpdates::PLATFORM_LINUX;
		break;
	}
	
	$device_os = null;
	if (isset($_GET['osversion'])) {
		$device_os = $platform . ' ' . $_GET['osversion'];
	}
}

$updates = BeaconUpdates::FindUpdates($current_build, $device_mask, $stage, $device_os);

if (BeaconCommon::InProduction()) {
	header('Content-Type: application/rss+xml');
} else {
	header('Content-Type: text/plain');
}

echo '<' . '?xml version="1.0" encoding="utf-8"?' . ">\n";
echo '<rss version="2.0" xmlns:sparkle="http://www.andymatuschak.org/xml-namespaces/sparkle" xmlns:dc="http://purl.org/dc/elements/1.1/">' . "\n";
echo "\t<channel>\n";
echo "\t\t<title>Beacon Version History</title>\n";
echo "\t\t<link>https://" . BeaconCommon::APIDomain() . "/sparkle.php?arch=" . $arch_str . "</link>\n";
echo "\t\t<language>en</language>\n";

$parser = new Parsedown();
foreach ($updates as $update) {
	echo "\t\t<item>\n";
	echo "\t\t\t<title>Beacon " . $update['build_display'] . "</title>\n";
	echo "\t\t\t<link>https://usebeacon.app</link>\n";
	echo "\t\t\t<description><![CDATA[" . $parser->text($update['notes']) . "]]></description>\n";
	echo "\t\t\t<pubDate>" . date('r', $update['publish_time']) . "</pubDate>\n";
	echo "\t\t\t<sparkle:version>" . BuildNumberToCFBundleVersion($update['build_number']) . "</sparkle:version>\n";
	echo "\t\t\t<sparkle:shortVersionString>" . $update['build_display'] . "</sparkle:shortVersionString>\n";
	switch ($platform) {
	case BeaconUpdates::PLATFORM_MACOS:
		echo "\t\t\t<sparkle:minimumSystemVersion>" . $update['min_mac_version'] . "</sparkle:minimumSystemVersion>\n";
		break;
	case BeaconUpdates::PLATFORM_WINDOWS:
		echo "\t\t\t<sparkle:minimumSystemVersion>" . $update['min_win_version'] . "</sparkle:minimumSystemVersion>\n";
		break;
	}
	
	if (is_null($update['required_if_below']) === false) {
		echo "\t\t\t<sparkle:criticalUpdate sparkle:version=\"" . BuildNumberToCFBundleVersion($update['required_if_below']) . "\"></sparkle:criticalUpdate>\n";
	}
	
	if (array_key_exists($platform, $update['files'])) {
		foreach ($update['files'][$platform] as $url => $signatures) {
			PrintEnclosure($url, $signatures, $platform);
		}
	} else {
		foreach ($update['files'] as $file_platform => $files) {
			foreach ($files as $url => $signatures) {
				PrintEnclosure($url, $signatures, $file_platform);
			}
		}
	}	
	
	echo "\t\t</item>\n";
}

echo "\t</channel>\n";
echo "</rss>\n";

function BuildNumberToCFBundleVersion(int $build_number): string {
	$major_version = floor($build_number / 10000000);
	$build_number = $build_number - ($major_version * 10000000);
	$minor_version = floor($build_number / 100000);
	$build_number = $build_number - ($minor_version * 100000);
	$bug_version = floor($build_number / 1000);
	$build_number = $build_number - ($bug_version * 1000);
	$stage_code = floor($build_number / 100);
	$build_number = $build_number - ($stage_code * 100);
	$non_release_version = $build_number;
	
	return number_format($major_version, 0, '') . '.' . number_format($minor_version, 0, '', '') . '.' . number_format($bug_version, 0, '', '') . '.' . number_format($stage_code, 0, '', '') . '.' . number_format($non_release_version, 0, '', '');
}

function PrintEnclosure(string $url, array $signatures, string $platform): void {
	if (array_key_exists(BeaconUpdates::SIGNATURE_ED25519, $signatures) === false || array_key_exists(BeaconUpdates::SIGNATURE_DSA, $signatures) === false) {
		return;
	}
	
	echo "\t\t\t" . '<enclosure url="' . htmlentities(BeaconCommon::SignDownloadURL($url)) . '" type="application/octet-stream"';
	switch ($platform) {
	case BeaconUpdates::PLATFORM_MACOS:
		echo ' sparkle:os="macos" sparkle:edSignature="' . $signatures[BeaconUpdates::SIGNATURE_ED25519] . '"';
		break;
	case BeaconUpdates::PLATFORM_WINDOWS:
		echo ' sparkle:os="windows" sparkle:dsaSignature="' . $signatures[BeaconUpdates::SIGNATURE_DSA] . '" sparkle:installerArguments="/SILENT /SP- /NOICONS /CLOSEAPPLICATIONS /RESTARTAPPLICATIONS"';
		break;
	}
	echo " />\n";
}

?>
