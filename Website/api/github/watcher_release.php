<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');
header('Content-Type: text/plain');
http_response_code(500);

if (isset($_SERVER['HTTP_X_HUB_SIGNATURE_256']) === false) {
	echo "No signature provided\n";
	exit;
}

$secret = BeaconCommon::GetGlobal('GitHub WebHook Secret', '');
$body = file_get_contents('php://input');
$computed_hash = 'sha256=' . hash_hmac('sha256', $body, $secret);
$provided_hash = $_SERVER['HTTP_X_HUB_SIGNATURE_256'];

if ($computed_hash !== $provided_hash) {
	echo "Hashes do not match. Sent $provided_hash, computed $computed_hash.\n";
	exit;
}

$webhook = json_decode($body, true);
if ($webhook['action'] !== 'published') {
	// We don't care
	http_response_code(200);
	echo "Ignored\n";
	exit;
}

$release = $webhook['release'];
$releaseId = $release['id'];
if ($release['prerelease'] === BeaconCommon::InProduction()) {
	http_response_code(200);
	echo "Incorrect release for this server.\n";
	exit;
}

$typeWhitelist = ['application/x-gzip', 'application/gzip'];
$assets = $release['assets'];
foreach ($assets as $asset) {
	$assetName = $asset['name'];
	$assetType = $asset['content_type'];
	$assetUrl = $asset['url'];
	if ((str_starts_with($assetName, 'sentinelwatcher') && in_array($assetType, $typeWhitelist)) === false) {
		continue;
	}

	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	$database->Query('INSERT INTO sentinel.watcher_releases (release_id, download_url, content_type) VALUES ($1, $2, $3) ON CONFLICT (release_id) DO UPDATE SET download_url = EXCLUDED.download_url, content_type = EXCLUDED.content_type;', $releaseId, $assetUrl, $assetType);
	$database->Commit();

	http_response_code(200);
	echo "Release added to database\n";
	exit;
}

echo "Did not find an asset to track\n";
