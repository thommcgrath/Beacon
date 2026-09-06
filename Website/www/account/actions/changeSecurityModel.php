<?php

header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

require(dirname(__FILE__, 4) . '/framework/loader.php');

use BeaconAPI\v4\{Application, Response, User};

$activeSession = BeaconCommon::GetSession();
if (is_null($activeSession)) {
	Response::NewJsonError('Unauthorized', ['code' => 'UNAUTHORIZED'], 401)->Flush();
	exit;
}
if ($activeSession->HasScope(Application::kScopeUsersCredentials) === false) {
	Response::NewJsonError('Forbidden', ['code' => 'FORBIDDEN'], 403)->Flush();;
	exit;
}

$password = $_POST['password'] ?? '';
$secret = $_POST['secret'] ?? '';
$newSecurityModel = $_POST['securityModel'] ?? null;
$identityChallenge = $_POST['identityChallenge'] ?? '';

if (is_null($newSecurityModel)) {
	Response::NewJsonError('A new security model was not requested.', ['code' => 'NO_MODEL'], 400)->Flush();;
	exit;
}

$database = BeaconCommon::Database();
$database->BeginTransaction();
$user = $session->User();
try {
	$user->ChangeSecurityModel($newSecurityModel, $password, $secret);

	if (BeaconCommon::VerifyIdentityChallenge($activeSession, $identityChallenge, 'changeSecurityModel') === false) {
		$database->Rollback();
		Response::NewJsonError('Identity not confirmed.' . $identityChallenge, ['code' => 'INCORRECT_CHALLENGE'], 400)->Flush();
		exit;
	}

	$database->Commit();

	Response::NewJson([
		'securityModel' => $newSecurityModel,
		'secret' => $secret,
	], 200)->Flush();
	exit;
} catch (Exception $err) {
	$database->Rollback();
	Response::NewJsonError($err->getMessage(), ['code' => 'OTHER_ERROR'], 400)->Flush();
	exit;
}

?>
