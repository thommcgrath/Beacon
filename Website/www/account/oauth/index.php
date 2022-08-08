<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');

header('Cache-Control: no-cache');

BeaconTemplate::SetBodyClass('purple');

if (BeaconCommon::HasAllKeys($_GET, 'requestid', 'provider', 'pubkey') === false) {
	http_response_code(400);
	echo '<h1>Error</h1>';
	echo '<p>This url was called incorrectly. You will need to try again.</p>';
	exit;
}

if (BeaconCommon::StartSession() === false) {
	http_response_code(500);
	echo '<h1>Error</h1>';
	echo '<p>Session did not start</p>';
	exit;
}

$provider = strtolower($_GET['provider']);
$public_key = BeaconEncryption::PublicKeyToPEM($_GET['pubkey']);
$auth_state = BeaconCommon::GenerateUUID();
$request_id = $_GET['requestid'];

if (BeaconCommon::IsUUID($request_id) === false) {
	http_response_code(400);
	echo '<h1>Error</h1>';
	echo '<p>Request ID should be a v4 UUID.</p>';
	exit;
}

try {
	$encrypted = BeaconEncryption::RSAEncrypt($public_key, 'encryptme');
} catch (Exception $err) {
	http_response_code(400);
	echo '<h1>Error</h1>';
	echo '<p>Provided public key is not suitable for encryption.</p>';
	exit;
}

$_SESSION['OAUTH_PROVIDER'] = $provider;
$_SESSION['OAUTH_AUTH_STATE'] = $auth_state;
$_SESSION['OAUTH_REQUEST_ID'] = $request_id;
$_SESSION['OAUTH_PUBLIC_KEY'] = $public_key;

$redirect_uri = 'https://' . $_SERVER['HTTP_HOST'] . '/account/oauth/complete.php';
switch ($provider) {
case 'nitrado':
	$url = 'https://oauth.nitrado.net/oauth/v2/auth?redirect_uri=' . urlencode($redirect_uri) . '&client_id=' . urlencode(BeaconCommon::GetGlobal('Nitrado_Client_ID')) . '&response_type=code&scope=service&state=' . urlencode($auth_state);
	echo '<h1>Error</h1>';
	echo '<p>Redirecting to Nitrado…</p>';
	break;
default:
	http_response_code(400);
	echo '<h1>Error</h1>';
	echo '<p>There is nowhere to redirect to because provider "' . $provider . '" is not known!</p>';
	exit;
}

BeaconCommon::Redirect($url, true);

?>