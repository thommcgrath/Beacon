<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');
header('Content-Type: application/json');

$client_refernce_id = $_GET['client_reference_id'];
$database = BeaconCommon::Database();
$results = $database->Query('SELECT purchaser_email, merchant_reference FROM purchases WHERE client_reference_id = $1 ORDER BY purchase_date DESC LIMIT 1;', $client_refernce_id);
if ($results->RecordCount() == 0) {
	http_response_code(404);
	echo '{}';
	exit;
}

$email_id = $results->Field('purchaser_email');
$obj = array(
	'email_id' => $email_id
);

$intent_id = $results->Field('merchant_reference');
$api = New BeaconStripeAPI(BeaconCommon::GetGlobal('Stripe_Secret_Key'));
$obj['email'] = $api->EmailForPaymentIntent($intent_id);

$users = $database->Query('SELECT user_id FROM users WHERE email_id = $1;', $email_id);
if ($users->RecordCount() == 1) {
	$obj['user_id'] = $users->Field('user_id');
} else {
	$obj['user_id'] = null;
}

echo json_encode($obj);

?>