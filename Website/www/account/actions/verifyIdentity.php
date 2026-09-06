<?php

header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

require(dirname(__FILE__, 4) . '/framework/loader.php');

use BeaconAPI\v4\{Application, Core, Response, Session, User, UserCredential};

$activeSession = BeaconCommon::GetSession();
if (is_null($activeSession)) {
	Response::NewJsonError('Unauthorized', null, 401)->Flush();
	exit;
}
if ($activeSession->HasScope(Application::kScopeUsersCredentials) === false) {
	Response::NewJsonError('Forbidden', null, 403);
	exit;
}

$user = $activeSession->User();
$userId = $user->UserId();
$obj = Core::BodyAsJson();

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
	if (is_null($passkey) || $passkey->UserId() != $userId) {
		Response::NewJsonError('Passkey not found', null, 401)->Flush();
		exit;
	}
	$metadata = $passkey->Metadata();
	$publicKey = $metadata['credentialPublicKey'];

	if ($auth->processGet($clientDataJSON, $authenticatorData, $signature, $publicKey, $challenge) !== true) {
		Response::NewJsonError('Passkey not verified', null, 401)->Flush();
		exit;
	}
} else {
	if ($user->Is2FAProtected()) {
		$verificationCode = $obj['verificationCode'] ?? '';
		if ($user->Verify2FACode(code: $verificationCode, verifyOnly: true, verificationOptions: User::VerifyWithAuthenticators) === false) {
			Response::NewJsonError('Incorrected authenticator code. Backup codes are not allowed here.', null, 401)->Flush();
			exit;
		}
	} else {
		$password = $obj['password'] ?? '';
		if ($user->TestPassword($password, true) === false) {
			Response::NewJsonError('Incorrect username or password.', null, 401)->Flush();
			exit;
		}
	}
}

Response::NewJson([
	'identityChallenge' => BeaconCommon::GetIdentityChallenge($activeSession),
], 201)->Flush();
exit;

?>
