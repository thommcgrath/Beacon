<?php

header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

require(dirname(__FILE__, 4) . '/framework/loader.php');

use BeaconAPI\v4\{Application, Response, User, UserCredential};

$activeSession = BeaconCommon::GetSession();
if (is_null($activeSession)) {
	Response::NewJsonError('Unauthorized', ['code' => 'UNAUTHORIZED'], 401)->Flush();
	exit;
}
if ($activeSession->HasScope(Application::kScopeUsersCredentials) === false) {
	Response::NewJsonError('Forbidden', ['code' => 'FORBIDDEN'], 403)->Flush();;
	exit;
}

$user = $activeSession->User();
$credentialId = $_POST['credentialId'] ?? '';
$identityChallenge = $_POST['identityChallenge'] ?? '';

$database = BeaconCommon::Database();
$database->BeginTransaction();
try {
	$credential = UserCredential::Fetch($credentialId);
} catch (Exception $err) {
	$database->Rollback();
	Response::NewJsonError($err->getMessage(), ['code' => 'OTHER_ERROR'], 400)->Flush();
	exit;
}

if (is_null($credential) || $credential->UserId() !== $user->UserId()) {
	$database->Rollback();
	Response::NewJsonError($err->getMessage(), ['code' => 'NOT_FOUND'], 404)->Flush();
	exit;
}

try {
	$credential->Delete();
} catch (Exception $err) {
	$database->Rollback();
	Response::NewJsonError($err->getMessage(), ['code' => 'OTHER_ERROR'], 400)->Flush();
	exit;
}

if (BeaconCommon::VerifyIdentityChallenge($activeSession, $identityChallenge, 'deleteCredential') === false) {
	$database->Rollback();
	Response::NewJsonError('Identity not confirmed.', ['code' => 'INCORRECT_CHALLENGE'], 400)->Flush();
	exit;
}
$database->Commit();

$response = [];
if ($credential->Type() === UserCredential::TypePasskey) {
	$metadata = $passkey->Metadata();
	$response['rpId'] = 'usebeacon.app';
	$response['credentialId'] = $metadata['credentialId'];
}

Response::NewJson($response, 200)->Flush();
exit;

?>
