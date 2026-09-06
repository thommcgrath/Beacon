<?php

header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

require(dirname(__FILE__, 4) . '/framework/loader.php');

use BeaconAPI\v4\{Application, Authenticator, Response, User};

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
$authenticatorId = $_GET['authenticatorId'] ?? '';
$identityChallenge = $_GET['identityChallenge'] ?? '';

$database = BeaconCommon::Database();
$database->BeginTransaction();
try {
	$authenticator = Authenticator::RemoveAuthenticator($user, $authenticatorId);
} catch (Exception $err) {
	$database->Rollback();
	Response::NewJsonError($err->getMessage(), ['code' => 'OTHER_ERROR'], 400)->Flush();
	exit;
}
if (BeaconCommon::VerifyIdentityChallenge($activeSession, $identityChallenge) === false) {
	$database->Rollback();
	Response::NewJsonError('Identity not confirmed.' . $identityChallenge, ['code' => 'INCORRECT_CHALLENGE'], 400)->Flush();
	exit;
}
$database->Commit();

Response::NewNoContent()->Flush();
exit;

?>
