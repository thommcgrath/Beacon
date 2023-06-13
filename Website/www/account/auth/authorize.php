<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');
header('Cache-Control: no-cache');
header('Content-Type: application/json');

use BeaconAPI\v4\{Application, ApplicationAuthFlow, Response, Core, Session, User};

$session = BeaconCommon::GetSession();
if (is_null($session)) {
	Response::NewJsonError('Unauthorized', ['code' => 'NO_LOGIN'], 401)->Flush();
	exit;
}

$obj = Core::BodyAsJson();
$deviceId = $obj['deviceId'] ?? '';
$flowId = $obj['flowId'] ?? null;
$challenge = $obj['challenge'] ?? null;
$challengeExpiration = $obj['challengeExpiration'] ?? 0;
$userPassword = $obj['password'] ?? null;

if (empty($flowId) || is_null($flow = ApplicationAuthFlow::Fetch($flowId)) || $flow->IsCompleted()) {
	Response::NewJsonError('This authentication flow has already been completed', ['code' => 'COMPLETED'], 400)->Flush();
	exit;
}

try {
	$callback = $flow->Authorize($deviceId, $challenge, $challengeExpiration, $session->User(), $userPassword);
	http_response_code(200);
	echo json_encode(['callback' => $callback], JSON_PRETTY_PRINT);
} catch (Exception $err) {
	Response::NewJsonError($err->getMessage(), ['code' => 'FAILED_AUTHORIZE'], 400)->Flush();
}

?>
