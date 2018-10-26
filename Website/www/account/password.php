<?php

require($_SERVER['SITE_ROOT'] . '/framework/loader.php');

$session = BeaconSession::GetFromCookie();
if (is_null($session)) {
	exit;
}

header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

if (empty($_GET['current_password']) || empty($_GET['password'])) {
	http_response_code(400);
	echo json_encode(array('message' => 'Missing parameters.'), JSON_PRETTY_PRINT);
	exit;
}

$current_password = $_GET['current_password'];
$password = $_GET['password'];
$allow_vulnerable = isset($_GET['allow_vulnerable']) ? boolval($_GET['allow_vulnerable']) : false;

$database = BeaconCommon::Database();

if (!BeaconUser::ValidatePassword($password)) {
	http_response_code(437);
	echo json_encode(array('message' => 'Password must be at least 8 characters and you should avoid repeating characters.'), JSON_PRETTY_PRINT);
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
			echo json_encode(array('message' => 'Password is listed as vulnerable according to haveibeenpwned.com'), JSON_PRETTY_PRINT);
			exit;
		}
	}
}

$new_user = false;
$user = BeaconUser::GetByUserID($session->UserID());
if ($user->ChangePassword($current_password, $password) == false) {
	http_response_code(500);
	echo json_encode(array('message' => 'There was an error updating authentication parameters.'), JSON_PRETTY_PRINT);
	exit;
}
if ($user->Commit() == false) {
	http_response_code(500);
	echo json_encode(array('message' => 'There was an error saving the user.'), JSON_PRETTY_PRINT);
	exit;
}

$response = array();

http_response_code(200);
echo json_encode($response, JSON_PRETTY_PRINT);

?>