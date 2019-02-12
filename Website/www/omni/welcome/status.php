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
$obj['email'] = email_for_intent_id($intent_id);

$users = $database->Query('SELECT user_id FROM users WHERE email_id = $1;', $email_id);
if ($users->RecordCount() == 1) {
	$obj['user_id'] = $users->Field('user_id');
} else {
	$obj['user_id'] = null;
}

echo json_encode($obj);

function email_for_intent_id(string $intent_id) {
	$api_secret = BeaconCommon::GetGlobal('Stripe_Secret_Key');
	
	$curl = curl_init('https://api.stripe.com/v1/payment_intents/' . $intent_id);
	$headers = array('Authorization: Bearer ' . $api_secret);
	curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
	$pi_body = curl_exec($curl);
	$pi_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
	curl_close($curl);
	
	if ($pi_status != 200) {
		return null;
	}
	$pi_json = json_decode($pi_body, true);
	if (is_null($pi_json)) {
		return null;
	}
	$source_id = $pi_json['source'];
	
	$curl = curl_init('https://api.stripe.com/v1/sources/' . $source_id);
	$headers = array('Authorization: Bearer ' . $api_secret);
	curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
	$source_body = curl_exec($curl);
	$source_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
	curl_close($curl);
	
	if ($source_status != 200) {
		return null;
	}
	$source_json = json_decode($source_body, true);
	if (is_null($source_json)) {
		return null;
	}
	
	$owner = $source_json['owner'];
	return $owner['email'];
}

?>