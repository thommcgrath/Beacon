<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');

$session = BeaconSession::GetFromCookie();
if (is_null($session)) {
	http_response_code(400);
	echo json_encode(['message' => 'Unauthorized.'], JSON_PRETTY_PRINT);
	exit;
}

header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

$user = $session->User();
$user->Clear2FABackupCodes(false);
$user->Create2FABackupCodes(true);
$codes = $user->Get2FABackupCodes();

http_response_code(200);
echo json_encode(['codes' => $codes], JSON_PRETTY_PRINT);
exit;

?>
