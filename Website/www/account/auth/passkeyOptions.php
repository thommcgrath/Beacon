<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Content-Type: application/json');

use BeaconAPI\v4\{Application, UserCredential};

$existingPasskeyIds = [];
$activeSession = BeaconCommon::GetSession();
if (is_null($activeSession) === false) {
	if ($activeSession->HasScope(Application::kScopeUsersCredentials) === false) {
		Response::NewJsonError('Forbidden', null, 403);
		exit;
	}

	$passkeys = UserCredential::Search(['userId' => $activeSession->UserId(), 'type' => UserCredential::TypePasskey], true);
	foreach ($passkeys as $passkey) {
		try {
			$metadata = $passkey->Metadata();
			if (array_key_exists('credentialId', $metadata)) {
				$existingPasskeyIds[] = BeaconCommon::Base64UrlDecode($metadata['credentialId']);
			}
		} catch (Exception $err) {
		}
	}
}

BeaconCommon::StartSession();

use ReportUri\Passkeys\WebAuthn;
$auth = new WebAuthn('Beacon', 'usebeacon.app');
$args = $auth->getGetArgs($existingPasskeyIds, 300, true, true, true, true, true, false);
$_SESSION['challenge'] = $auth->getChallenge();

http_response_code(200);
echo json_encode($args, JSON_PRETTY_PRINT);

?>
