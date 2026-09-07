<?php

require(dirname(__FILE__, 5) . '/framework/loader.php');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Content-Type: application/json');
http_response_code(500);

$needsPKCE = false;
$scopes = [];
$provider = strtolower($_GET['provider'] ?? '');
switch ($provider) {
case 'nitrado':
	$clientId = BeaconCommon::GetGlobal('Nitrado_Client_ID');
	$endpoint = 'https://oauth.nitrado.net/oauth/v2/auth';
	$scopes = ['user_info', 'service'];
	break;
default:
	http_response_code(400);
	echo json_encode(['message' => 'Unknown provider.']);
	exit;
}

BeaconCommon::StartSession();

$session = BeaconCommon::GetSession();
if (is_null($session) === false) {
	$identityChallenge = $_GET['identityChallenge'] ?? '';
	if (BeaconCommon::VerifyIdentityChallenge($session, $identityChallenge, 'signInWith') === false) {
		http_response_code(400);
		echo json_encode(['message' => 'Invalid identity challenge.']);
		exit;
	}
}

$state = BeaconCommon::GenerateUUID();
$_SESSION['authState'] = $state;

if (isset($_GET['return'])) {
	$_SESSION['authReturnURI'] = $_GET['return'];
}
if (isset($_GET['remember'])) {
	$_SESSION['authRemember'] = $_GET['remember'];
}

$queryParams = [
	'redirect_uri' => 'https://' . BeaconCommon::Domain() . '/account/oauth/v4/authenticate/' . strtolower($provider),
	'client_id' => $clientId,
	'response_type' => 'code',
	'scope' => implode(' ', $scopes),
	'state' => $state,
];

if ($needsPKCE) {
	$codeVerifier = BeaconEncryption::GeneratePKCE(128);
	$_SESSION['authVerifier'] = $codeVerifier;
	$queryParams['code_challenge'] = BeaconCommon::Base64UrlEncode(hash('sha256', $codeVerifier, true));
	$queryParams['code_challenge_method'] = 'S256';
}

$url = $endpoint . '?' . http_build_query($queryParams);

http_response_code(302);
header('Location: ' . $url);

?>
