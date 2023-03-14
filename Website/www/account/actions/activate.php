<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');

use BeaconAPI\v4\{Session, User};

$output_type = BeaconCommon::BestResponseContentType(['application/json', 'text/html']);
if (is_null($output_type)) {
	$output_type = 'text/html';
}
header('Content-Type: ' . $output_type);
header('Cache-Control: no-cache');

if (strtoupper($_SERVER['REQUEST_METHOD']) != 'POST') {
	ExitWithError(400, 'Must use POST request');
}

$session = BeaconCommon::GetSession();
if (is_null($session)) {
	ExitWithError(403, 'Unauthorized');
}

if (!isset($_FILES['file']['error']) || is_array($_FILES['file']['error'])) {
	ExitWithError(400, 'Invalid parameters');
}

switch ($_FILES['file']['error']) {
case UPLOAD_ERR_OK:
	break;
case UPLOAD_ERR_NO_FILE:
	ExitWithError(400, 'No file included');
	break;
case UPLOAD_ERR_INI_SIZE:
case UPLOAD_ERR_FORM_SIZE:
	ExitWithError(400, 'File too large');
	break;
default:
	ExitWithError(400, 'Unknown other error');
	break;
}

$info = new finfo(FILEINFO_MIME_TYPE);
if ($info->file($_FILES['file']['tmp_name']) != 'application/json') {
	ExitWithError(400, 'Wrong file content');
}

$user = $session->User();
$user_id = strtolower($user->UserId());

$content = file_get_contents($_FILES['file']['tmp_name']);
$json = json_decode($content, true);
if (is_null($json) || BeaconCommon::HasAllKeys($json, 'UserID', 'Signed', 'Device') === false) {
	ExitWithError(400, 'Uploaded file is not valid authorization file.');
}
$sent_user_id = strtolower($json['UserID']);
if (BeaconCommon::IsUUID($sent_user_id) === false) {
	ExitWithError(400, 'UserID is not a v4 UUID');
}

$signature = hex2bin($json['Signed']);
$device_id = $json['Device'];
$signing_data = $json['Device'];

if ($user_id != $sent_user_id) {
	// Potentially need to merge users
	$other_user = User::Fetch($sent_user_id);
	if ($other_user instanceof BeaconAPI\v4\User) {
		// Definitely know the other user
		if (!$other_user->CheckSignature($signing_data, $signature)) {
			ExitWithError(400, 'Not authorized to merge user');
		}
		
		if (!$user->MergeUsers($other_user->UserID())) {
			ExitWithError(400, 'Unable to merge other user');
		}
	}
} else {
	if (!$user->CheckSignature($signing_data, $signature)) {
		ExitWithError(400, 'Request signature is not correct');
	}
}

$user->PrepareSignatures($device_id);
$reply = json_encode($user, JSON_PRETTY_PRINT);

header('Content-Type: application/octet-stream');
header('Content-Disposition: attachment; filename="' . preg_replace('/[^a-z09\-_ \(\)]/i', '', $user->Username()) . '.beaconidentity"');
header('Content-MD5: ' . md5($reply));
echo $reply;

function ExitWithError(int $status, string $message) {
	global $output_type;
	
	http_response_code($status);
	switch ($output_type) {
	case 'application/json':
		echo json_encode(['message' => $message], JSON_PRETTY_PRINT);
		break;
	default:
		echo '<h1>There was an error generating your activation file</h1><p>' . htmlentities($message) . '</p>';
		break;
	}
	exit;
}

?>