<?php

header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

require(dirname(__FILE__, 4) . '/framework/loader.php');

use BeaconAPI\v4\{Response, Session, User};

$activeSession = BeaconCommon::GetSession();
if (is_null($activeSession)) {
	Response::NewJsonError('Unauthorized', null, 401)->Flush();
	exit;
}

$user = $activeSession->User();
$obj = [
	'challenge' => BeaconCommon::Base64UrlEncode(random_bytes(128)),
	'rp' => [
		'Beacon',
		'usebeacon.app',
	],
	'user' => [
		'id' => $user->UserId(),
		'name' => $user->Username(true),
		'displayName' => $user->Username(false),
	],
	'pubKeyCredParams' => [
		[
			'alg' => -7,
			'type' => 'public-key',
		],
		[
			'alg' => -257,
			'type' => 'public-key',
		],
	],
	'excludeCredentials' => [
	],
	'authenticatorSelection' => [
		'authenticatorAttachment' => 'platform',
		'requireResidentKey' => true,
	],
];

http_response_code(200);
echo json_encode($obj, JSON_PRETTY_PRINT);

?>
