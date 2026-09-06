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

$user = $activeSession->User();

BeaconCommon::StartSession();
$challenge = $_SESSION['challenge'];

use ReportUri\Passkeys\WebAuthn;
$auth = new WebAuthn('Beacon', 'usebeacon.app');

$passkeyRawData = trim(file_get_contents('php://input'));
if ($passkeyRawData) {
	$passkeyRawData = json_decode($passkeyRawData, true, 512, JSON_THROW_ON_ERROR);
}
$clientDataJSON = base64_decode($passkeyRawData['clientDataJSON']);
$attestationObject = base64_decode($passkeyRawData['attestationObject']);

try {
	$data = $auth->processCreate($clientDataJSON, $attestationObject, $challenge, true, true);
} catch (Exception $err) {
	Response::NewJsonError($err->getMessage(), null, 500)->Flush();
	exit;
}

$aaguid = bin2hex($data->AAGUID);
if (BeaconUUID::Validate($aaguid)) {
	$data->AAGUID = $aaguid;
}
$passkeyId = BeaconUUID::v5($data->credentialId);
$data->credentialId = BeaconCommon::Base64UrlEncode($data->credentialId);
$passkeyData = json_encode($data);

$database = BeaconCommon::Database();
$rows = $database->Query('SELECT name FROM public.fido_names WHERE authenticator_id = $1;', $data->AAGUID);
if ($rows->RecordCount() === 1) {
	$passkeyName = $rows->Field('name');
} else {
	$passkeyName = 'Device';
}

try {
	$passkey = UserCredential::CreatePasskey($activeSession->UserId(), $passkeyId, $passkeyName, $passkeyData);
	Response::NewNoContent()->Flush();
} catch (Exception $err) {
	Response::NewJsonError($err->getMessage(), null, 500)->Flush();
}

?>
