<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');
$output_type = BeaconCommon::BestResponseContentType(['application/json', 'text/html']);
if (is_null($output_type)) {
	$output_type = 'text/html';
}
header('Content-Type: ' . $output_type);
header('Cache-Control: no-cache');

if (strtoupper($_SERVER['REQUEST_METHOD']) != 'POST') {
	ExitWithError(405, 'Must use POST request');
}

if (empty($_POST['sessionHash'])) {
	ExitWithError(400, 'Missing sessionHash parameter');
}

BeaconAPI::Authorize();

$session = BeaconSession::GetBySessionHash($_POST['sessionHash']);
if (is_null($session)) {
	ExitWithError(404, 'Unknown session');
}
if ($session->UserID() !== BeaconAPI::UserID()) {
	ExitWithError(403, 'Unauthorized');
}

$session->Delete();

echo json_encode(['error' => false, 'message' => 'Session revoked'], JSON_PRETTY_PRINT);

function ExitWithError(int $status, string $message) {
	global $output_type;
	
	http_response_code($status);
	switch ($output_type) {
	case 'application/json':
		echo json_encode(['error' => true, 'message' => $message], JSON_PRETTY_PRINT);
		break;
	default:
		echo '<h1>There was an error generating your activation file</h1><p>' . htmlentities($message) . '</p>';
		break;
	}
	exit;
}

?>