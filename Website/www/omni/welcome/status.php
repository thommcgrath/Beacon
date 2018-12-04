<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');
header('Content-Type: application/json');

$client_refernce_id = $_GET['client_reference_id'];
$database = BeaconCommon::Database();
$results = $database->Query('SELECT purchaser_email FROM purchases WHERE client_reference_id = $1 ORDER BY purchase_date DESC LIMIT 1;', $client_refernce_id);
if ($results->RecordCount() == 0) {
	http_response_code(404);
	echo '{}';
	exit;
}

$email = $results->Field('purchaser_email');
$obj = array(
	'email' => $email
);

$users = $database->Query('SELECT user_id FROM users WHERE login_key = $1;', $email);
if ($users->RecordCount() == 1) {
	$obj['user_id'] = $users->Field('user_id');
} else {
	$obj['user_id'] = null;
}

echo json_encode($obj);

?>