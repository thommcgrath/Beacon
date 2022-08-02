<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');
header('Content-Type: text/plain');

$secret = BeaconCommon::GetGlobal('GitHub WebHook Secret', '');
$body = file_get_contents('php://input');
$computed_hash = 'sha256=' . hash_hmac('sha256', $body, $secret);
$provided_hash = $_SERVER['HTTP_X_HUB_SIGNATURE_256'];

if ($computed_hash !== $provided_hash) {
	echo "Hashes do not match. Sent $provided_hash, computed $computed_hash.\n";
	exit;
}

try {
	$body = json_decode($body, true);
} catch (Exception $e) {
	echo $e->getMessage();
	exit;
}

if (is_null($body)) {
	echo "Body is null.\n";
	exit;
}

if (isset($body['commits']) === false) {
	echo "No commits.\n";
	exit;
}

$database = BeaconCommon::Database();
$database->BeginTransaction();
foreach ($body['commits'] as $commit) {
	$hash = $commit['id'];
	
	$curl = curl_init('https://api.github.com/repos/thommcgrath/Beacon/commits/' . $hash . '/branches-where-head');
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($curl, CURLOPT_USERAGENT, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.5 Safari/605.1.15');
	$response = curl_exec($curl);
	$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
	curl_close($curl);
	
	if ($status !== 200) {
		echo "Unable to get info about commit $hash: $status.\n";
		echo "$response\n";
		if (BeaconCommon::InProduction()) {
			BeaconCommon::PostSlackMessage('Webhook was unable to get information about commit ' . $hash . '.');
		}
		$database->Rollback();
		exit;
	}
	
	$branches = json_decode($response, true);
	foreach ($branches as $branch) {
		$database->Query('INSERT INTO public.endpoint_git_hashes (branch, hash) VALUES ($1, $2) ON CONFLICT (branch) DO UPDATE SET hash = EXCLUDED.hash;', $branch['name'], $hash);
	}
}
$database->Commit();

echo "Success.\n";
exit;

?>
