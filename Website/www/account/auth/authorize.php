<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');
header('Cache-Control: no-cache');
header('Content-Type: application/json');

use BeaconAPI\v4\{Application, ApplicationAuthFlow, APIResponse, Core, Session, User};

$session = Session::GetFromCookie();
if (is_null($session)) {
	APIResponse::NewJsonError('Unauthorized', ['code' => 'NO_LOGIN'], 401)->Flush();
	exit;
}

$obj = Core::BodyAsJson();
$deviceId = $obj['deviceId'] ?? '';
$flowId = $obj['flowId'] ?? null;
$challenge = $obj['challenge'] ?? null;
$challengeExpiration = $obj['challengeExpiration'] ?? 0;

if (empty($flowId) || is_null($flow = ApplicationAuthFlow::Fetch($flowId)) || $flow->IsCompleted()) {
	APIResponse::NewJsonError('This authentication flow has already been completed', ['code' => 'COMPLETED'], 400)->Flush();
	exit;
}

try {
	$callback = $flow->Authorize($deviceId, $challenge, $challengeExpiration, $session->User());
	http_response_code(200);
	echo json_encode(['callback' => $callback], JSON_PRETTY_PRINT);
} catch (Exception $err) {
	APIResponse::NewJsonError('Authorization could not be completed. It may have expired. Please try again.', ['code' => 'EXPIRED', 'exception' => $err->getMessage()], 400)->Flush();
}

?>
