<?php

header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

require(dirname(__FILE__, 3) . '/framework/loader.php');

use BeaconAPI\v4\{License, User};

$email = isset($_GET['email']) ? $_GET['email'] : '';
$response = [
	'error' => false,
	'email' => $email,
	'userId' => null,
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
		$response['debug'] = 'invalid email';
		return;
	}

	// Then see if we have a user account, as that went through manual
	// verification already.
	$user = null;
	try {
		$user = User::Fetch($email);
		if (is_null($user) === false) {
			$response['verified'] = true;
			$response['userId'] = $user->UserId();
			$response['purchases'] = $user->Licenses();
			return;
		} else {
			$database = BeaconCommon::Database();
			$rows = $database->Query('SELECT uuid_for_email($1) AS email_id;', $email);
			$emailId = $rows->Field('email_id');
			$licenses = License::Search(['emailId' => $emailId], true);
			$response['purchases'] = $licenses;
		}
	} catch (Exception $e) {
		$response['debug'] = 'exception';
	}

	// Ask CleanTalk to connect to the server and see if the mailbox exists.
	$response['verified'] = BeaconEmail::QuickVerify($email);
}

?>
