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

$curl = curl_init('https://api.github.com/repos/thommcgrath/beacon/branches');
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
curl_setopt($curl, CURLOPT_USERAGENT, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.5 Safari/605.1.15');
$response = curl_exec($curl);
$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
curl_close($curl);

if ($status !== 200) {
	echo "Unable to branches\n";
	echo "$response\n";
	if (BeaconCommon::InProduction()) {
		BeaconCommon::PostSlackMessage('Webhook was unable to get branches.');
	}
	exit;
}

$branches = [];
try {
	$branches = json_decode($response, true);
} catch (Exception $e) {
	echo $e->getMessage();
	if (BeaconCommon::InProduction()) {
		BeaconCommon::PostSlackMessage('Webhook was unable to decode branches: ' . $response);
	}
	exit;
}

$database = BeaconCommon::Database();

$existingHashes = [];
$rows = $database->Query('SELECT branch, hash FROM public.endpoint_git_hashes;');
while (!$rows->EOF()) {
	$existingHashes[$rows->Field('branch')] = $rows->Field('hash');
	$rows->MoveNext();
}

$database->BeginTransaction();
foreach ($branches as $branch) {
	try {
		$branchName = $branch['name'];
		$branchHash = $branch['commit']['sha'];
		if (array_key_exists($branchName, $existingHashes)) {
			if ($existingHashes[$branchName] !== $branchHash) {
				$database->Query('UPDATE public.endpoint_git_hashes SET hash = $2 WHERE branch = $1;', $branchName, $branchHash);
			}
			unset($existingHashes[$branchName]);
		} else {
			$database->Query('INSERT INTO public.endpoint_git_hashes (branch, hash) VALUES ($1, $2);', $branchName, $branchHash);
		}
	} catch (Exception $e) {
		$database->Rollback();
		echo $e->getMessage();
		if (BeaconCommon::InProduction()) {
			BeaconCommon::PostSlackMessage('Webhook was unable to update branch hashes: ' . $e->getMessage());
		}
		exit;
	}
}
foreach ($existingHashes as $branchName => $branchHash) {
	$database->Query('DELETE FROM public.endpoint_git_hashes WHERE branch = $1;', $branchName);
}
$database->Commit();

echo "Success\n";
exit;

?>
