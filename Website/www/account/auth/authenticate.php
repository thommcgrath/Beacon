<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Content-Type: application/json');

use BeaconAPI\v4\{Application, ApplicationAuthFlow, Response, Core, Session, User, UserCredential};

$obj = Core::BodyAsJson();
$deviceId = $obj['deviceId'] ?? '';
$flowId = $obj['flowId'] ?? null;

$app = Application::Fetch(BeaconCommon::BeaconWebsiteAppId);
$challengeSecret = $app->Secret();
$challengeExpiration = $obj['challengeExpiration'] ?? 0;
$challengeRaw = $deviceId . $challengeExpiration . $challengeSecret;
if (is_null($flowId) === false) {
	$challengeRaw .= $flowId;
}

$challenge = base64_encode(hash('sha3-512', $challengeRaw, true));
$sentChallenge = $obj['challenge'] ?? '';
$challengeExpiration = $obj['challengeExpiration'] ?? 0;
if ($challengeExpiration < time() || $challenge !== $sentChallenge) {
	Response::NewJsonError('Timed Out', ['code' => 'CHALLENGE_TIMEOUT'], 400)->Flush();
	exit;
}

if (array_key_exists('clientDataJSON', $obj)) {
	// authenticate with passkey / webauthn
	BeaconCommon::StartSession();
	$auth = new ReportUri\Passkeys\WebAuthn('Beacon', 'usebeacon.app');
	$clientDataJSON = base64_decode($obj['clientDataJSON']);
	$authenticatorData = base64_decode($obj['authenticatorData']);
	$signature = base64_decode($obj['signature']);
	$userHandle = base64_decode($obj['userHandle']);
	$credentialId = base64_decode($obj['id']);
	$passkeyId = BeaconUUID::v5($credentialId);
	$challenge = $_SESSION['challenge'] ?? '';

	$passkey = UserCredential::Fetch($passkeyId);
	if (is_null($passkey)) {
		Response::NewJsonError('Passkey not found', ['code' => 'BAD_LOGIN'], 401)->Flush();
		exit;
	}
	$metadata = $passkey->Metadata();
	$publicKey = $metadata['credentialPublicKey'];

	if ($auth->processGet($clientDataJSON, $authenticatorData, $signature, $publicKey, $challenge) !== true) {
		Response::NewJsonError('Passkey not found', ['code' => 'BAD_LOGIN'], 401)->Flush();
		exit;
	}
} else {
	$email = $obj['email'] ?? '';
	$user = User::Fetch($email);
	if (is_null($user)) {
		Response::NewJsonError('Incorrect username or password', ['code' => 'BAD_LOGIN'], 401)->Flush();
		exit;
	}

	$password = $obj['password'] ?? '';
	$verificationCode = $obj['verificationCode'] ?? '';
	$trust = $obj['trust'] ?? null;

	if ($user->TestPassword($password) === false) {
		Response::NewJsonError('Incorrect username or password', ['code' => 'BAD_LOGIN'], 401)->Flush();
		exit;
	}
	if (empty($verificationCode)) {
		$verificationCode = $deviceId;
	}
	if ($user->Is2FAProtected()) {
		if ($user->Verify2FACode($verificationCode, false) === false) {
			Response::NewJsonError('Incorrect username or password', ['code' => '2FA_ENABLED'], 403)->Flush();
			exit;
		}

		if (empty($deviceId) === false) {
			if ($trust === true) {
				$user->TrustDevice($deviceId);
			} else if ($trust === false) {
				$user->TrustDevice($deviceId);
			}
		}
	}
}

$session = Session::Create($user, $app);
http_response_code(201);
echo json_encode($session, JSON_PRETTY_PRINT);

?>
