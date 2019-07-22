<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
	http_response_code(405);
	echo json_encode(array('error' => true, 'message' => 'This endpoint will only accept GET requests.'));
	exit;
}

if (!BeaconCommon::HasAllKeys($_GET, 'requestid')) {
	http_response_code(400);
	echo json_encode(array('error' => true, 'message' => 'Request is missing the requestid parameter.'));
	exit;
}

$request_id = $_GET['requestid'];

if (!BeaconCommon::IsUUID($request_id)) {
	http_response_code(400);
	echo json_encode(array('error' => true, 'message' => 'The provided id is not valid.'));
	exit;
}

$database = BeaconCommon::Database();
$results = $database->Query('SELECT encrypted_payload, encrypted_symmetric_key FROM oauth_requests WHERE expiration > CURRENT_TIMESTAMP AND request_id = $1;', $request_id);
if ($results->RecordCount() === 0) {
	http_response_code(400);
	echo json_encode(array('error' => true, 'message' => 'The provided id is not valid.'));
	exit;
}

$response = array(
	'error' => false,
	'encrypted_payload' => $results->Field('encrypted_payload'),
	'encrypted_symmetric_key' => $results->Field('encrypted_symmetric_key')
);

http_response_code(200);
echo json_encode($response);

?>