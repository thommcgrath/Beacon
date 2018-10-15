<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');

header('Content-Type: text/plain');

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
	http_response_code(405);
	echo 'Method not allowed. Make only GET requests.';
	exit;
}

if (!BeaconCommon::HasAllKeys($_GET, 'code', 'state')) {
	http_response_code(400);
	echo 'This method requires code `provider` and `state` keys.';
	exit;
}

BeaconCommon::StartSession();

$code = $_GET['code'];
$sent_state = $_GET['state'];

if ($sent_state !== $_SESSION['OAUTH_AUTH_STATE']) {
	http_response_code(400);
	echo 'Invalid auth state';
	exit;
}

$fields = array(
	'grant_type=authorization_code',
	'client_id=' . urlencode(BeaconCommon::GetGlobal('Nitrado_Client_ID')),
	'client_secret=' . urlencode(BeaconCommon::GetGlobal('Nitrado_Client_Secret')),
	'code=' . urlencode($code),
	'redirect_url=' . urlencode('https://' . $_SERVER['HTTP_HOST'] . '/oauth/callback.php')
);

switch ($_SESSION['OAUTH_PROVIDER']) {
case 'nitrado':
	$curl = curl_init('https://oauth.nitrado.net/oauth/v2/token');
	break;
default:
	http_response_code(500);
	echo 'Unknown provider `' . $_SESSION['OAUTH_PROVIDER'] . '`';
	exit;
}

curl_setopt($curl, CURLOPT_POST, true);
curl_setopt($curl, CURLOPT_POSTFIELDS, implode('&', $fields));
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
$response = curl_exec($curl);
$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
curl_close($curl);

if ($status == 200) {
	$response = json_decode($response, true);
	$forward_to = 'beacon://oauth/' . urlencode($_SESSION['OAUTH_PROVIDER']) . '?access_token=' . urlencode($response['access_token']) . '&refresh_token=' . urlencode($response['refresh_token']) . '&expires_in=' . urlencode($response['expires_in']);
	BeaconCommon::Redirect($forward_to);
} else {
	http_response_code($status);
	header('Content-Type: application/json');
	echo $response;
}

?>