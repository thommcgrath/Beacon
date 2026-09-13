<?php

header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

require(dirname(__FILE__, 4) . '/framework/loader.php');

use BeaconAPI\v4\{Application, Response, Session, User, UserCredential};

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

BeaconCommon::StartSession();

use ReportUri\Passkeys\WebAuthn;
$auth = new WebAuthn('Beacon', 'usebeacon.app');

$existingPasskeyIds = [];
$passkeys = UserCredential::Search(['userId' => $user->UserId(), 'type' => UserCredential::TypePasskey], true);
foreach ($passkeys as $passkey) {
	try {
		$metadata = $passkey->Metadata();
		if (array_key_exists('credentialId', $metadata)) {
			$existingPasskeyIds[] = BeaconCommon::Base64UrlDecode($metadata['credentialId']);
		}
	} catch (Exception $err) {
	}
}

$args = $auth->getCreateArgs(userId: $user->UserId(), userName: $user->Username(true), userDisplayName: $user->Username(false), timeout: 300, excludeCredentialIds: $existingPasskeyIds);
$_SESSION['challenge'] = $auth->getChallenge();

http_response_code(200);
echo json_encode($args, JSON_PRETTY_PRINT);

?>
