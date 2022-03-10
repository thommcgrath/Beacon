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
	'purchases' => [],
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
			$response['purchases'] = $user->Licenses();
			return;
		}
	} catch (Exception $e) {
	}
	
	// Ask CleanTalk to connect to the server and see if the mailbox exists.
	$response['verified'] = BeaconEmail::QuickVerify($email);
}

?>