#!/usr/bin/php -q
<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

while (ob_get_level() > 0) {
	ob_end_clean();
}

$database = BeaconCommon::Database();
$rows = $database->Query('SELECT * FROM sentinel.watcher_releases ORDER BY release_id DESC LIMIT 1;');
if ($rows->RecordCount() === 0) {
	echo "No releases yet\n";
	exit;
}
$latestReleaseId = $rows->Field('release_id');

$watcherRoot = dirname(__FILE__, 2) . '/watcher';
$installPath = $watcherRoot . '/bin';
$installPathExists = file_exists($installPath);
$installPathIsDirectory = $installPath && is_dir($installPath);

$releaseFile = $installPath . '/release';
$installedReleaseId = 0;
if (file_exists($releaseFile) && is_dir($releaseFile) === false) {
	// Good
	$installedReleaseId = intval(file_get_contents($releaseFile));
}

if ($latestReleaseId <= $installedReleaseId) {
	echo "Already up to date\n";
	exit;
}

if ($installPathExists === false || $installPathIsDirectory === false) {
	if ($installPathExists) {
		unlink($installPath);
	}
	mkdir($installPath, 0755, true);
}

$downloadUrl = $rows->Field('download_url');
$downloadType = $rows->Field('content_type');
switch ($downloadType) {
case 'application/x-gzip':
case 'application/gzip':
	$downloadFilename = 'sentinelwatcher.tgz';
	break;
default:
	echo "Unknown content type {$downloadType}\n";
	exit;
}
$downloadPath = tempnam(sys_get_temp_dir(), 'sentinelwatcher');

$authToken = BeaconCommon::GetGlobal('GitHub Watcher Token', '');

set_time_limit(0);
$handle = fopen($downloadPath, 'wb+');
$curl = curl_init($downloadUrl);
curl_setopt($curl, CURLOPT_TIMEOUT, 600);
curl_setopt($curl, CURLOPT_FILE, $handle);
curl_setopt($curl, CURLOPT_FOLLOWLOCATION, true);
curl_setopt($curl, CURLOPT_USERAGENT, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.5 Safari/605.1.15');
curl_setopt($curl, CURLOPT_HTTPHEADER, [
	'Accept: application/octet-stream',
	'X-GitHub-Api-Version: 2022-11-28',
	"Authorization: Bearer $authToken",
]);
curl_exec($curl);
$downloadStatus = curl_getinfo($curl, CURLINFO_HTTP_CODE);
curl_close($curl);
fclose($handle);

if ($downloadStatus !== 200) {
	echo "Failed to download archive: {$downloadStatus}\n";
	echo file_get_contents($downloadPath);
	unlink($downloadPath);
	exit;
}

$lockFile = $installPath . '/lock';
exec('killall sentinelwatcher');
exec('cd ' . escapeshellarg($watcherRoot) . ';rm -rf bin;mkdir bin;chmod 0755 bin;touch bin/lock');

$configPrefix = BeaconCommon::GetGlobal('Config Prefix');
$archivePath = "{$installPath}/{$downloadFilename}";
rename($downloadPath, $archivePath);

$extracted = false;
switch ($downloadType) {
case 'application/x-gzip':
case 'application/gzip':
	exec(command: 'cd ' . escapeshellarg($installPath) . ';tar -xzf ' . escapeshellarg($downloadFilename), result_code: $resultCode);
	$extracted = ($resultCode === 0);
	break;
}

if ($extracted) {
	symlink("{$watcherRoot}/configs/{$configPrefix}.json", "{$installPath}/config.json");
	chmod("{$installPath}/startwatcher.sh", 0744);
	file_put_contents($releaseFile, $latestReleaseId);
}
unlink($archivePath);
unlink($lockFile);

// Just to make sure everything is cleaned up
sleep(1);

exec(escapeshellarg("{$installPath}/startwatcher.sh"));

?>
