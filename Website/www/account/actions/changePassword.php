<?php

header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

require(dirname(__FILE__, 4) . '/framework/loader.php');

use BeaconAPI\v4\{Application, Response, Session, User, UserGenerator};

$activeSession = BeaconCommon::GetSession();
if (is_null($activeSession)) {
	Response::NewJsonError('Unauthorized', ['code' => 'UNAUTHORIZED'], 401)->Flush();
	exit;
}
if ($activeSession->HasScope(Application::kScopeUsersCredentials) === false) {
	Response::NewJsonError('Forbidden', ['code' => 'FORBIDDEN'], 403)->Flush();;
	exit;
}

$currentPassword = $_POST['currentPassword'] ?? '';
$newPassword = $_POST['newPassword'] ?? '';
$allowVulnerable = filter_var($_POST['allowVulnerable'] ?? false, FILTER_VALIDATE_BOOLEAN);
$identityChallenge = $_POST['identityChallenge'] ?? '';

if (!User::ValidatePassword($newPassword)) {
	Response::NewJsonError('Password must be at least 8 characters and you should avoid repeating characters.', ['code' => 'BAD_PASSWORD'], 400)->Flush();
	exit;
}
if (str_contains(strtolower($newPassword), 'at least 8 characters')) {
	Response::NewJsonError('Good one', ['code' => 'FUNNY_PASSWORD'], 400)->Flush();
	exit;
}

if ($allowVulnerable == false) {
	$hash = strtolower(sha1($newPassword));
	$prefix = substr($hash, 0, 5);
	$suffix = substr($hash, 5);
	$url = 'https://api.pwnedpasswords.com/range/' . $prefix;
	$hashes = explode("\n", file_get_contents($url));
	foreach ($hashes as $hash) {
		$count = intval(substr($hash, 36));
		$hash = strtolower(substr($hash, 0, 35));
		if ($hash == $suffix && $count > 0) {
			// vulnerable
			Response::NewJsonError('Password is listed as vulnerable according to haveibeenpwned.com.', ['code' => 'VULNERABLE_PASSWORD'], 400)->Flush();
			exit;
		}
	}
}

$database = BeaconCommon::Database();
$database->BeginTransaction();
try {
	$user = $activeSession->User();

	if (UserGenerator::GracefulPasswordChange($user, $currentPassword, $newPassword) === false) {
		$database->Rollback();
		Response::NewJsonError('Incorrect current password', ['code' => 'INCORRECT_PASSWORD'], 400)->Flush();
		exit;
	}

	if (BeaconCommon::VerifyIdentityChallenge($activeSession, $identityChallenge, 'changePassword') === false) {
		$database->Rollback();
		Response::NewJsonError('Identity not confirmed.', ['code' => 'INCORRECT_CHALLENGE'], 400)->Flush();
		exit;
	}

	$database->Commit();
	Response::NewNoContent()->Flush();
	exit;
} catch (Exception $err) {
	$database->Rollback();
	Response::NewJsonError($err->getMessage(), null, 400)->Flush();
	exit;
}

?>
