<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');

use BeaconAPI\v4\{Application, Authenticator, UserCredential};

http_response_code(500);
header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');

$session = BeaconCommon::GetSession();
if (is_null($session)) {
	http_response_code(401);
	echo json_encode(['message' => 'Unauthorized.'], JSON_PRETTY_PRINT);
	exit;
}
if ($session->HasScope(Application::kScopeUsersCredentials) === false) {
	http_response_code(403);
	echo json_encode(['message' => 'Forbidden.'], JSON_PRETTY_PRINT);
	exit;
}

$password = $_POST['password'] ?? '';
$secret = $_POST['secret'] ?? '';
$totp = $_POST['totp'] ?? '';
$newSecurityModel = $_POST['securityModel'] ?? null;

if (is_null($newSecurityModel)) {
	http_response_code(400);
	echo json_encode(['message' => 'A new security model was not requested.'], JSON_PRETTY_PRINT);
	exit;
}

$user = $session->User();
try {
	if (Authenticator::VerifyCode($user, $totp, Authenticator::VerifyOptionAllowTOTP) === false) {
		http_response_code(403);
		echo json_encode(['message' => 'Incorrect authenticator code'], JSON_PRETTY_PRINT);
		exit;
	}

	$user->ChangeSecurityModel($newSecurityModel, $password, $secret);

	http_response_code(200);
	echo json_encode(['securityModel' => $newSecurityModel, 'secret' => $secret], JSON_PRETTY_PRINT);
} catch (Exception $err) {
	http_response_code(403);
	echo json_encode(['message' => $err->getMessage()], JSON_PRETTY_PRINT);
	exit;
}

?>
