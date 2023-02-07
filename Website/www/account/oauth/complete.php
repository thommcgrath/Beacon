<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');
header('Cache-Control: no-cache');

BeaconTemplate::SetBodyClass('purple');

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
	http_response_code(405);
	echo '<h1>Error</h1>';
	echo '<p>Method not allowed. Make only GET requests.</p>';
	exit;
}

if (!BeaconCommon::HasAllKeys($_GET, 'code', 'state')) {
	http_response_code(400);
	echo '<h1>Error</h1>';
	echo '<p>This method requires <code>code</code> and <code>state</code> keys.</p>';
	exit;
}

if (BeaconCommon::StartSession() === false) {
	http_response_code(500);
	echo '<h1>Error</h1>';
	echo '<p>Session was not started</p>';
	exit;
}

if (!BeaconCommon::HasAllKeys($_SESSION, 'OAUTH_REQUEST_ID', 'OAUTH_AUTH_STATE', 'OAUTH_PROVIDER', 'OAUTH_PUBLIC_KEY')) {
	http_response_code(400);
	echo '<h1>Error</h1>';
	echo '<p>Session was not properly setup.</p>';
	exit;
}

$code = $_GET['code'];
$sent_state = $_GET['state'];

if ($sent_state !== $_SESSION['OAUTH_AUTH_STATE']) {
	http_response_code(400);
	echo '<h1>Error</h1>';
	echo '<p>Invalid auth state.</p>';
	exit;
}

$fields = [
	'grant_type=authorization_code',
	'client_id=' . urlencode(BeaconCommon::GetGlobal('Nitrado_Client_ID')),
	'client_secret=' . urlencode(BeaconCommon::GetGlobal('Nitrado_Client_Secret')),
	'code=' . urlencode($code),
	'redirect_url=' . urlencode('https://' . $_SERVER['HTTP_HOST'] . '/account/oauth/complete.php')
];

switch ($_SESSION['OAUTH_PROVIDER']) {
case 'nitrado':
	$curl = curl_init('https://oauth.nitrado.net/oauth/v2/token');
	break;
default:
	http_response_code(400);
	echo '<h1>Error</h1>';
	echo '<p>Unknown provider <code>' . $_SESSION['OAUTH_PROVIDER'] . '</code>.</p>';
	exit;
}

curl_setopt($curl, CURLOPT_POST, true);
curl_setopt($curl, CURLOPT_POSTFIELDS, implode('&', $fields));
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
$response = curl_exec($curl);
$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
curl_close($curl);

if ($status == 200) {
	$request_id = $_SESSION['OAUTH_REQUEST_ID'];
	$public_key = $_SESSION['OAUTH_PUBLIC_KEY'];
	$response = json_decode($response, true);
	
	$access_token = $response['access_token'];
	$refresh_token = $response['refresh_token'];
	$expires_in = $response['expires_in'];
	
	try {
		// need to lookup information about the token, such as the user it belongs to
		$curl = curl_init('https://api.nitrado.net/token');
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_HTTPHEADER, array('Authorization: Bearer ' . $access_token));
		$token_info = json_decode(curl_exec($curl), true);
		$token_info_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);
		if ($token_info_status != 200 || $token_info === false) {
			http_response_code(500);
			echo '<h1>Error</h1>';
			echo '<p>Nitrado did not authorize the request. The response was:</p>';
			echo '<pre>' . nl2br(htmlentities(var_export($token_info, true))) . '</pre>';
			exit;
		}
		$token_user = $token_info['data']['token']['user'];
		$nitrado_user_id = $token_user['id'];
		$nitrado_user_name = $token_user['username'];
	
		$payload = json_encode(array('access_token' => $access_token, 'refresh_token' => $refresh_token, 'expires_in' => $expires_in, 'user_id' => $nitrado_user_id, 'username' => $nitrado_user_name));
		$symmetric_key = BeaconCommon::GenerateUUID();
	} catch (Exception $err) {
		http_response_code(500);
		echo '<h1>Error</h1>';
		echo '<p>There was an error while loading Nitrado account information.</p>';
		exit;
	}
	
	try {
		$payload_encrypted = BeaconEncryption::SymmetricEncrypt($symmetric_key, $payload);
		$symmetric_key_encrypted = BeaconEncryption::RSAEncrypt($public_key, $symmetric_key);
	} catch (Exception $err) {
		http_response_code(500);
		echo '<h1>Error</h1>';
		echo '<p>Payload data cannot be encrypted with the supplied public key.</p>';
		echo '<pre>' . htmlentities($payload) . '</pre>';
		exit;
	}
	
	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	try {
		$database->Query('DELETE FROM oauth_requests WHERE expiration <= CURRENT_TIMESTAMP;');
		$database->Query('INSERT INTO oauth_requests (request_id, encrypted_payload, encrypted_symmetric_key, expiration) VALUES ($1, $2, $3, CURRENT_TIMESTAMP + \'6 hours\'::INTERVAL);', $request_id, base64_encode($payload_encrypted), base64_encode($symmetric_key_encrypted));
		$database->Commit();
	} catch (Exception $err) {
		$database->Rollback();
		http_response_code(500);
		echo '<h1>Error</h1>';
		echo '<p>Unable to store authorization in database.</p>';
		exit;
	}
	
	unset($_SESSION['OAUTH_REQUEST_ID'], $_SESSION['OAUTH_AUTH_STATE'], $_SESSION['OAUTH_PROVIDER'], $_SESSION['OAUTH_PUBLIC_KEY']);
	
	http_response_code(200);
	echo '<h1>Authorization Complete</h1>';
	echo '<p>The process is complete. You may now close this window. Beacon will download the authorization code in a moment.</p>';
} else {
	http_response_code(500);
	echo '<h1>Error</h1>';
	echo '<p>Nitrado did not authorize the request. The response was:</p>';
	echo '<pre>' . nl2br(htmlentities($response)) . '</pre>';
	exit;
}

?>