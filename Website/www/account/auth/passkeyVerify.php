<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Content-Type: application/json');

use BeaconAPI\v4\{Response, Session, User, UserCredential};

BeaconCommon::StartSession();

use ReportUri\Passkeys\WebAuthn;
$auth = new WebAuthn('Beacon', 'usebeacon.app');

$body = trim(file_get_contents('php://input'));
if ($body) {
	$body = json_decode($body, true, 512, JSON_THROW_ON_ERROR);
}

$clientDataJSON = base64_decode($body['clientDataJSON']);
$authenticatorData = base64_decode($body['authenticatorData']);
$signature = base64_decode($body['signature']);
$userHandle = base64_decode($body['userHandle']);
$credentialId = base64_decode($body['id']);
$passkeyId = BeaconUUID::v5($credentialId);
$challenge = $_SESSION['challenge'] ?? '';

$passkey = UserCredential::Fetch($passkeyId);
if (is_null($passkey)) {
	Response::NewJsonError('Passkey not found', null, 404)->Flush();
	exit;
}
$metadata = $passkey->Metadata();
$publicKey = $metadata['credentialPublicKey'];

if ($auth->processGet($clientDataJSON, $authenticatorData, $signature, $publicKey, $challenge) !== true) {
	Response::NewJsonError('Passkey verification failed', null, 400)->Flush();
	exit;
}

$activeSession = BeaconCommon::GetSession();
if (is_null($activeSession)) {
	// Create a session and return it
	$user = User::Fetch($passkey->UserId());
	$activeSession = Session::Create($user, BeaconCommon::BeaconWebsiteAppId);

	Response::NewJson($activeSession, 201)->Flush();
	exit;
} else {
	// Return the current session, assuming the user matches
	if ($activeSession->UserId() !== $passkey->UserId()) {
		Response::NewJsonError('Passkey belongs to another user', null, 403)->Flush();
		exit;
	}

	Response::NewJson($activeSession, 200)->Flush();
	exit;
}

?>
