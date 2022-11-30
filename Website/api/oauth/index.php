<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');

header('Content-Type: text/plain');

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
	http_response_code(405);
	echo 'Method not allowed. Make only GET requests.';
	exit;
}

if (!BeaconCommon::HasAllKeys($_GET, 'provider')) {
	http_response_code(400);
	echo 'This method requires a `provider` key.';
	exit;
}

BeaconCommon::StartSession();

$provider = $_GET['provider'];
$_SESSION['OAUTH_PROVIDER'] = $provider;
$auth_state = BeaconCommon::GenerateUUID();
$_SESSION['OAUTH_AUTH_STATE'] = $auth_state;
$_SESSION['OAUTH_USE_SENTINEL'] = false;

if (isset($_GET['return_uri'])) {
	// Modern Sentinel logic
	try {
		\BeaconAPI::Authorize(false);
		$return_uri = $_GET['return_uri'];
		$oauth = \BeaconAPI\Sentinel\OAuth::Lookup(\BeaconAPI::UserID(), $provider);
		if ($oauth && $oauth->Test(true)) {
			\BeaconCommon::Redirect($return_uri, true);
		}
		$redirect_uri = \BeaconAPI\Sentinel\OAuth::Begin($provider, $auth_state);
		$_SESSION['OAUTH_RETURN_URI'] = $return_uri;
		$_SESSION['OAUTH_USE_SENTINEL'] = true;
		\BeaconCommon::Redirect($redirect_uri, true);
	} catch (\Exception $err) {
		echo $err->getMessage();
		exit;
	}
}

$provider = strtolower($provider);
$_SESSION['OAUTH_PROVIDER'] = $provider;
$_SESSION['OAUTH_REQUESTID'] = isset($_GET['requestid']) ? $_GET['requestid'] : '';

$redirect_uri = 'https://' . $_SERVER['HTTP_HOST'] . '/oauth/callback.php';
switch ($provider) {
case 'nitrado':
	$url = 'https://oauth.nitrado.net/oauth/v2/auth?redirect_uri=' . urlencode($redirect_uri) . '&client_id=' . urlencode(BeaconCommon::GetGlobal('Nitrado_Client_ID')) . '&response_type=code&scope=service&state=' . urlencode($auth_state);
	echo 'Redirecting to Nitrado…';
	break;
default:
	http_response_code(400);
	echo 'There is nowhere to redirect to because provider "' . $provider . '" is not known!';
	exit;
}

BeaconCommon::Redirect($url);

?>