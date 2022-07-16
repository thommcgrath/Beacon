<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');
header('Content-Type: text/css');

if (!isset($_GET['path'])) {
	http_response_code(404);
	return;
}

$path = $_SERVER['DOCUMENT_ROOT'] . $_GET['path'];
$extension = pathinfo($_SERVER['DOCUMENT_ROOT'] . $_GET['path'], PATHINFO_EXTENSION);
if ($extension !== 'css') {
	http_response_code(404);
	return;
}

$css_path = realpath($path);
$scss_path = realpath(substr_replace($path, 'scss', -3));
if ($scss_path != false) {
	$path = $scss_path;
} elseif ($css_path != false) {
	$path = $css_path;
} else {
	http_response_code(404);
	return;
}

if (strpos($path, $_SERVER['DOCUMENT_ROOT']) !== 0) {
	http_response_code(404);
	return;
}

$timestamp = filemtime($path);
$cached = BeaconCache::Get($path);
if (is_array($cached)) {
	$cache_timestamp = $cached['timestamp'];
	if ($timestamp <= $cache_timestamp) {
		echo $cached['content'];
		exit;
	}
}

$cmd = BeaconCommon::FrameworkPath() . '/dart-sass/' . BeaconCommon::GetGlobal('SASS_Filename', 'sass') . ' --style=compressed ' . escapeshellarg($path) . ' 2>&1';
$content = trim(shell_exec($cmd));

$cached = array(
	'timestamp' => $timestamp,
	'content' => $content
);

BeaconCache::Set($path, $cached);
echo $cached['content'];
exit;