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
$secret = $_POST['secret'] ?? '';
$nickname = $_POST['nickname'] ?? '↑↓←→';
$identityChallenge = $_POST['identityChallenge'] ?? '';
$code = $_POST['code'] ?? '';

if (empty($secret)) {
	Response::NewJsonError('Forbidden', ['code' => 'EMPTY_SECRET'], 400)->Flush();;
	exit;
}

$database = BeaconCommon::Database();
$database->BeginTransaction();
try {
	$authenticator = Authenticator::CreateTOTP($user, $secret, $nickname);
} catch (Exception $err) {
	$database->Rollback();
	Response::NewJsonError($err->getMessage(), ['code' => 'OTHER_ERROR'], 400)->Flush();
	exit;
}
if ($authenticator->TestCode($code) === false) {
	$database->Rollback();
	Response::NewJsonError('Incorrect verification code.', ['code' => 'INCORRECT_CODE'], 400)->Flush();
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
