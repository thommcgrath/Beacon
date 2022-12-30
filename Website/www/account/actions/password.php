<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');

$active_session = BeaconSession::GetFromCookie();
if (is_null($active_session)) {
	exit;
}

header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

if (empty($_POST['current_password']) || empty($_POST['password'])) {
	http_response_code(400);
	echo json_encode(['message' => 'Missing parameters.'], JSON_PRETTY_PRINT);
	exit;
}

$current_password = $_POST['current_password'];
$password = $_POST['password'];
$allow_vulnerable = isset($_POST['allow_vulnerable']) ? filter_var($_POST['allow_vulnerable'], FILTER_VALIDATE_BOOLEAN) : false;
$regenerate_key = isset($_POST['regenerate_key']) ? filter_var($_POST['regenerate_key'], FILTER_VALIDATE_BOOLEAN) : false;
$terminate_sessions = isset($_POST['terminate_sessions']) ? filter_var($_POST['terminate_sessions'], FILTER_VALIDATE_BOOLEAN) : false;

$database = BeaconCommon::Database();

if (!BeaconUser::ValidatePassword($password)) {
	http_response_code(437);
	echo json_encode(['message' => 'Password must be at least 8 characters and you should avoid repeating characters.'], JSON_PRETTY_PRINT);
	exit;
}

if ($allow_vulnerable == false) {
	$hash = strtolower(sha1($password));
	$prefix = substr($hash, 0, 5);
	$suffix = substr($hash, 5);
	$url = 'https://api.pwnedpasswords.com/range/' . $prefix;
	$hashes = explode("\n", file_get_contents($url));
	foreach ($hashes as $hash) {
		$count = intval(substr($hash, 36));
		$hash = strtolower(substr($hash, 0, 35));
		if ($hash == $suffix && $count > 0) {
			// vulnerable
			http_response_code(438);
			echo json_encode(['message' => 'Password is listed as vulnerable according to haveibeenpwned.com'], JSON_PRETTY_PRINT);
			exit;
		}
	}
}

$database = BeaconCommon::Database();
$database->BeginTransaction();

$user = BeaconUser::GetByUserID($active_session->UserID());
if ($user->ChangePassword($current_password, $password, $regenerate_key) === false) {
	http_response_code(500);
	echo json_encode(['message' => 'There was an error updating authentication parameters.'], JSON_PRETTY_PRINT);
	$database->Rollback();
	exit;
}

if ($user->Commit() === false) {
	http_response_code(500);
	echo json_encode(['message' => 'There was an error saving the user.'], JSON_PRETTY_PRINT);
	$database->Rollback();
	exit;
}

if ($regenerate_key) {
	$user->UntrustAllDevices();
	
	if ($terminate_sessions) {
		$sessions = BeaconSession::GetForUser($user);
		foreach ($sessions as $session) {
			if ($session->SessionID() === $active_session->SessionID()) {
				continue;
			}
			
			$session->Delete();
		}
	}
}

$database->Commit();

$response = [];

http_response_code(200);
echo json_encode($response, JSON_PRETTY_PRINT);

?>