<?php

require(dirname(__FILE__, 5) . '/framework/loader.php');
header('Cache-Control: no-cache, no-store, must-revalidate');
http_response_code(500);

BeaconCommon::StartSession();
$session = BeaconCommon::GetSession();
if (isset($_SESSION['authReturnURI'])) {
	$homeUrl = $_SESSION['authReturnURI'];
} elseif (is_null($session) === false) {
	$homeUrl = '/account/#security';
} else {
	$homeUrl = '/account';
}
$homeButton = '<p class="text-center"><a href="' . htmlentities($homeUrl) . '" class="button default">Back</a></p>';

$needsPKCE = false;
$scopes = [];
$provider = strtolower($_GET['provider'] ?? '');
$providerName = '';
$clientSecret = '';
switch ($provider) {
case 'nitrado':
	$clientId = BeaconCommon::GetGlobal('Nitrado_Client_ID');
	$clientSecret = BeaconCommon::GetGlobal('Nitrado_Client_Secret');
	$endpoint = 'https://oauth.nitrado.net/oauth/v2/token';
	$scopes = ['user_info', 'service'];
	$provider = 'Nitrado';
	$providerName = 'Nitrado';
	break;
default:
	http_response_code(400);
	echo '<h1>Sign In With</h1>';
	echo '<p><strong>Error</strong>: Unknown provider.</p>';
	echo $homeButton;
	exit;
}

echo '<h1>Sign In With ' . htmlentities($providerName) . '</h1>';

$code = $_GET['code'] ?? '';
$state = $_GET['state'] ?? '';
$expectedState = $_SESSION['authState'] ?? '';
$codeVerifier = $_SESSION['authVerifier'] ?? '';
if ($state !== $expectedState) {
	http_response_code(400);
	echo '<p><strong>Error</strong>: Verification has failed. This can happen if cookies are turned off. The beacon_oauth_state cookie is required to verify the authorization process has not been tampered with.</p>';
	echo $homeButton;
	exit;
}

$fields = [
	'grant_type' => 'authorization_code',
	'client_id' => $clientId,
	'code' => $code,
	'redirect_uri' => 'https://' . BeaconCommon::Domain() . '/account/oauth/v4/authenticate/' . strtolower($provider),
];
if (empty($clientSecret) === false) {
	$fields['client_secret'] = $clientSecret;
}
if (empty($codeVerifier) === false) {
	$fields['code_verifier'] = $codeVerifier;
}

$curl = curl_init($endpoint);
curl_setopt($curl, CURLOPT_POST, true);
curl_setopt($curl, CURLOPT_POSTFIELDS, http_build_query($fields));
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
$response = curl_exec($curl);
$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
curl_close($curl);
if ($status !== 200) {
	http_response_code(400);
	echo '<p><strong>Error</strong>: Invalid authorization code.</p>';
	echo '<p>HTTP Response Code: ' . htmlentities($status) . '</p>';
	echo '<pre class="m-0">' . htmlentities($response) . '</pre>';
	echo $homeButton;
	exit;
}

$response = json_decode($response, true);
$accessToken = $response['access_token'];
$refreshToken = $response['refresh_token'];
$accessTokenExpiration = time();
$refreshTokenExpiration = time();
$providerSpecific = [];
$storeAsOAuth = false;

$providerAccountId = '';
$providerAccountName = '';
$providerAccountEmail = '';
$providerDisplayName = $provider;
switch ($provider) {
case 'Nitrado':
	$curl = curl_init('https://api.nitrado.net/token');
	curl_setopt($curl, CURLOPT_HTTPHEADER, [
		'Authorization: Bearer ' . $accessToken,
	]);
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
	$response = curl_exec($curl);
	$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
	curl_close($curl);
	if ($status !== 200) {
		http_response_code(500);
		echo '<p><strong>Error</strong>: Could not get user info from Nitrado.</p>';
		echo '<p>HTTP Response Code: ' . htmlentities($status) . '</p>';
		echo '<pre class="m-0">' . htmlentities($response) . '</pre>';
		echo $homeButton;
		exit;
	}

	$response = json_decode($response, true);
	$providerAccountId = $response['data']['token']['user']['id'];
	$providerAccountName = $response['data']['token']['user']['username'];
	$providerDisplayName = $providerAccountName . ' (' . $providerAccountId . ')';
	$providerSpecific['user'] = $response['data']['token']['user'];
	$accessTokenExpiration = $response['data']['token']['expires_at'];
	$refreshTokenExpiration = $accessTokenExpiration + 2592000; // This is a guess, 30 days
	$storeAsOAuth = true;
	break;
}
if (empty($providerAccountId)) {
	echo '<p><strong>Error</strong>: Provider account has no unique ID. This is an implementation error. The developer has bee notified.</p>';
	echo $homeButton;
	exit;
}

use BeaconAPI\v4\{ServiceToken, Session, User, UserCredential, UserGenerator};

$database = BeaconCommon::Database();
$database->BeginTransaction();

try {
	$credentialId = BeaconUUID::v5($provider . ':' . $providerAccountId);
	$credential = UserCredential::Fetch($credentialId);
	$userId = '';
	$user = null;
	if (is_null($credential) === false) {
		if (is_null($session)) {
			$userId = $credential->UserId();
			$user = User::Fetch($userId);
		} elseif ($session->UserId() !== $credential->UserId()) {
			$database->Rollback();
			http_response_code(400);
			echo '<p><strong>Error</strong>: Another Beacon account has already setup &quot;Sign In With ' . htmlentities($providerName) . '&quot; with this ' . htmlentities($providerName) . ' account.</p>';
			echo $homeButton;
			exit;
		} else {
			$user = $session->User();
			$userId = $user->UserId();
		}

		$metadata = $credential->Metadata();
		if (empty($providerAccountName) === false) {
			$metadata['accountName'] = $providerAccountName;
		}
		if (empty($providerAccountEmail) === false) {
			$metadata['accountEmail'] = $providerAccountEmail;
		}

		$credential->Edit([
			'name' => $providerDisplayName,
			'metadata' => $metadata,
		]);
	} elseif (empty($providerAccountEmail)) {
		$providerAccountEmail = $provider . '+' . $providerAccountId . '@oauth.usebeacon.app';
	}

	if (is_null($user)) {
		// See if we have a user with the same email address.
		$user = User::Fetch($providerAccountEmail);
		if (is_null($user)) {
			if (empty($providerAccountName)) {
				$providerAccountName = BeaconLogin::GenerateUsername();
			}
			$user = UserGenerator::CreateNamed($providerAccountEmail, $providerAccountName);
		}
		$userId = $user->UserId();
	}

	if (is_null($credential)) {
		$credential = UserCredential::Create([
			'credentialId' => $credentialId,
			'userId' => $userId,
			'type' => $provider,
			'name' => $providerDisplayName,
			'metadata' => [
				'accountName' => $providerAccountName,
				'accountId' => $providerAccountId,
				'accountEmail' => $providerAccountEmail,
			],
		]);
	}

	if ($storeAsOAuth) {
		ServiceToken::StoreOAuth($userId, $provider, $accessToken, $refreshToken, $accessTokenExpiration, $refreshTokenExpiration, $providerSpecific, true);
	}

	if (is_null($session)) {
		$session = Session::Create($user, BeaconCommon::BeaconWebsiteAppId);

	}
	$database->Commit();

	$queryParams = [
		'session_id' => $session->AccessToken(),
		'return' => $_SESSION['authReturnURI'] ?? 'https://' . BeaconCommon::Domain(),
		'temporary' => ($_SESSION['authRemember'] ?? 'false') !== 'true',
	];
	$url = 'https://' . BeaconCommon::Domain() . '/account/auth/redeem?' . http_build_query($queryParams);
	unset($_SESSION['authState'], $_SESSION['authVerifier'], $_SESSION['authReturnURI'], $_SESSION['authRemember']);

	http_response_code(302);
	header('Location: ' . $url);
} catch (Exception $err) {
	$database->Rollback();
	echo '<p><strong>Error</strong>: ' . htmlentities($err->getMessage()) . '</p>';
	echo json_encode(['message' => $err->getMessage()]);
	echo $homeButton;
	exit;
}

?>
