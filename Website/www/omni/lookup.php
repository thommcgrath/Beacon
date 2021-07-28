<?php

header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

require(dirname(__FILE__, 3) . '/framework/loader.php');

$email = isset($_GET['email']) ? $_GET['email'] : '';
$response = [
	'error' => false,
	'email' => $email,
	'omni' => false,
	'child' => false,
	'verified' => false,
];

lookupEmail($email, $response);

http_response_code(200);
echo json_encode($response, JSON_PRETTY_PRINT);
exit;

// Allows logic to be aborted easily.
function lookupEmail($email, &$response) {
	// Check it the address looks like an address
	if (BeaconEmail::IsEmailValid($email) === false) {
		return;
	}
	
	// Then see if we have a user account, as that went through manual
	// verification already.
	$user = null;
	try {
		$user = BeaconUser::GetByEmail($email);
		if (is_null($user) === false) {
			$response['verified'] = true;
			$response['omni'] = $user->OmniVersion() >= 1;
			$response['child'] = $user->IsChildAccount();
			return;
		}
	} catch (Exception $e) {
	}
	
	// Ask CleanTalk to connect to the server and see if the mailbox exists.
	$cache_key = sha1('CleanTalk Result ' . strtolower($email));
	$url = 'https://api.cleantalk.org/?method_name=email_check&auth_key=' . urlencode(BeaconCommon::GetGlobal('CleanTalk Email Check Key')) . '&email=' . urlencode($email);
	$body = BeaconCache::Get($cache_key);
	if (is_null($body)) {
		$curl = curl_init($url);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		$body = curl_exec($curl);
		$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		if ($status !== 200) {
			// This isn't really true, but err on the side of caution
			$response['verified'] = true;
			return;
		}
		BeaconCache::Set($cache_key, $body);
	}
	
	$parsed = json_decode($body, TRUE);
	$data = $parsed['data'];
	$result = $data[$email]['result'];
	switch ($result) {
	case 'NOT_EXISTS':
	case 'MX_FAIL':
	case 'MX_FAIL':
		// Confirmed failure
		return;
	}
	
	$response['verified'] = true;
}

?>