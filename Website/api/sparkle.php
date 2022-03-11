<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

$stage = 3;
if (isset($_GET['stage'])) {
	$stage = intval($_GET['stage']);
}
$arch = 2;
$arch_str = 'x64';
if (isset($_GET['arch'])) {
	switch ($_GET['arch']) {
	case 'arm64':
		$arch = 4;
		break;
	case 'arm':
		$arch = 8;
		break;
	case 'x64':
		$arch = 2;
		break;
	case 'x86':
		$arch = 1;
		break;
	}
}
switch ($arch) {
case 1:
	$arch_str = 'x86';
	break;
case 2:
	$arch_str = 'x64';
	break;
case 4:
	$arch_str = 'arm64';
	break;
case 8:
	$arch_str = 'arm';
	break;
}
if (isset($_GET['platform']) && isset($_GET['osversion']) && preg_match('/^\d{1,3}\.\d{1,3}\.\d{1,6}$/', $_GET['osversion']) === 1) {
	switch ($_GET['platform']) {
	case 'mac':
		$version_column = 'min_mac_version';
		$os_version = $_GET['osversion'];
		break;
	case 'win':
		$version_column = 'min_win_version';
		$os_version = $_GET['osversion'];
		break;
	}
}

if (BeaconCommon::InProduction()) {
	header('Content-Type: application/rss+xml');
} else {
	header('Content-Type: text/plain');
}

echo '<' . '?xml version="1.0" encoding="utf-8"?' . ">\n";
echo '<rss version="2.0" xmlns:sparkle="http://www.andymatuschak.org/xml-namespaces/sparkle"  xmlns:dc="http://purl.org/dc/elements/1.1/">' . "\n";
echo "\t<channel>\n";
echo "\t\t<title>Beacon Version History</title>\n";
echo "\t\t<link>https://" . BeaconCommon::APIDomain() . "/sparkle.php?arch=" . $arch_str . "</link>\n";
echo "\t\t<language>en</language>\n";

$parser = new Parsedown();
$database = BeaconCommon::Database();
$rows = $database->Query('SELECT update_id, build_number, build_display, stage, preview, notes, min_mac_version, min_win_version, EXTRACT(epoch FROM published) AS release_date, CASE WHEN UPPER_INC(lock_versions) THEN UPPER(lock_versions) ELSE UPPER(lock_versions) - 1 END AS critical_version FROM updates WHERE stage >= $1 AND update_id IN (SELECT DISTINCT update_id FROM download_urls WHERE (architectures & $2) = $2) ORDER BY build_number DESC;', $stage, $arch);
while ($rows->EOF() === false) {
	$update_id = $rows->Field('update_id');
	$downloads = $database->Query('SELECT download_urls.url, download_urls.platform, download_signatures.format, download_signatures.signature, download_urls.architectures FROM download_urls INNER JOIN download_signatures ON (download_signatures.download_id = download_urls.download_id) WHERE download_urls.update_id = $1 AND (download_urls.architectures & $2) = $2 AND ((download_urls.platform = \'macOS\' AND download_signatures.format = \'ed25519\') OR (download_urls.platform = \'Windows\' AND download_signatures.format = \'DSA\'));', $update_id, $arch);
	if ($downloads->RecordCount() === 0) {
		$rows->MoveNext();
		continue;
	}
	
	echo "\t\t<item>\n";
	echo "\t\t\t<title>Beacon " . $rows->Field('build_display') . "</title>\n";
	echo "\t\t\t<link>https://usebeacon.app</link>\n";
	echo "\t\t\t<description><![CDATA[" . $parser->text($rows->Field('notes')) . "]]></description>\n";
	echo "\t\t\t<pubDate>" . date('r', $rows->Field('release_date')) . "</pubDate>\n";
	/*echo "\t\t\t<sparkle:channel>";
	switch ($rows->Field('stage')) {
	case 1:
		echo 'alpha';
		break;
	case 2:
		echo 'beta';
		break;
	case 3:
		echo 'stable';
		break;
	}
	echo "</sparkle:channel>\n";*/
	echo "\t\t\t<sparkle:version>" . BuildNumberToCFBundleVersion($rows->Field('build_number')) . "</sparkle:version>\n";
	echo "\t\t\t<sparkle:shortVersionString>" . $rows->Field('build_display') . "</sparkle:shortVersionString>\n";
	echo "\t\t\t<sparkle:minimumSystemVersion>" . $rows->Field('min_mac_version') . "</sparkle:minimumSystemVersion>\n";
	
	if (is_null($rows->Field('critical_version')) === false) {
		echo "\t\t\t<sparkle:criticalUpdate sparkle:version=\"" . BuildNumberToCFBundleVersion($rows->Field('critical_version')) . "\"></sparkle:criticalUpdate>\n";
	}
	
	$best_downloads = [];
	$lowest_architectures = [];
	while ($downloads->EOF() === false) {
		$url = $downloads->Field('url');
		$platform = $downloads->Field('platform');
		$format = $downloads->Field('format');
		$signature = $downloads->Field('signature');
		$architectures = $downloads->Field('architectures');
		$num_architectures = NumberOfArchitectures($architectures);
		
		if ($num_architectures === 1) {
			$lowest_count = $num_architectures;
			$lowest_architectures[$platform] = $num_architectures;
		} else {
			if (array_key_exists($platform, $lowest_architectures) === true) {
				$lowest_count = $lowest_architectures[$platform];
			} else {
				$lowest_count = $num_architectures;
				$lowest_architectures[$platform] = $num_architectures;
			}
			if ($num_architectures < $lowest_count) {
				$lowest_architectures[$platform] = $num_architectures;
				$lowest_count = $num_architectures;
			}
		}
		if ($num_architectures === $lowest_count) {
			$best_downloads[$platform] = [
				'url' => $url,
				'format' => $format,
				'signature' => $signature
			];
		}
		
		$downloads->MoveNext();
	}
	
	foreach ($best_downloads as $platform => $download) {
		echo "\t\t\t" . '<enclosure url="' . $download['url'] . '" type="application/octet-stream"';
		switch ($platform) {
		case 'macOS':
			echo ' sparkle:os="macos"';
			break;
		case 'Windows':
			echo ' sparkle:os="windows"';
			break;
		case 'Linux':
			echo ' sparkle:os="linux"';
			break;
		}
		switch ($download['format']) {
		case 'DSA':
			echo ' sparkle:dsaSignature="' . $download['signature'] . '"';
			break;
		case 'ed25519':
			echo ' sparkle:edSignature="' . $download['signature'] . '"';
			break;
		}
		
		echo " />\n";
	}
	
	echo "\t\t</item>\n";
	$rows->MoveNext();
}

echo "\t</channel>\n";
echo "</rss>\n";

function NumberOfArchitectures(int $mask): int {
	$c = 0;
	if (($mask & 1) === 1) {
		$c++;
	}
	if (($mask & 2) === 2) {
		$c++;
	}
	if (($mask & 4) === 4) {
		$c++;
	}
	if (($mask & 8) === 8) {
		$c++;
	}
	return $c;
}

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

?>
