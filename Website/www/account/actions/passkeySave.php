<?php

header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

require(dirname(__FILE__, 4) . '/framework/loader.php');

use BeaconAPI\v4\{Application, Response, Session, User, UserCredential};

$activeSession = BeaconCommon::GetSession();
if (is_null($activeSession)) {
	Response::NewJsonError('Unauthorized', null, 401)->Flush();
	exit;
}
if ($activeSession->HasScope(Application::kScopeUsersCredentials) === false) {
	Response::NewJsonError('Forbidden', null, 403);
	exit;
}

$passkeyRawData = file_get_contents('php://input');
$passkeyData = json_decode($passkeyRawData, true);
$passkeyData['response']['clientDataJSON'] = json_decode(BeaconCommon::Base64UrlDecode($passkeyData['response']['clientDataJSON']), true);
$authenticatorData = BeaconCommon::Base64UrlDecode($passkeyData['response']['authenticatorData']);

$aaguid = bin2hex(substr($authenticatorData, 37, 16));
$database = BeaconCommon::Database();
$rows = $database->Query('SELECT name FROM public.fido_names WHERE authenticator_id = $1;', $aaguid);
if ($rows->RecordCount() === 1) {
	$passkeyName = $rows->Field('name');
} else {
	$passkeyName = 'Device';
}

try {
	$passkey = UserCredential::CreatePasskey($activeSession->UserId(), $passkeyName, $passkeyRawData);
	Response::NewNoContent()->Flush();
} catch (Exception $err) {
	Response::NewJsonError($err->getMessage(), null, 500)->Flush();
}

?>
