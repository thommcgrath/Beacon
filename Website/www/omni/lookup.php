<?php

header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

require(dirname(__FILE__, 3) . '/framework/loader.php');

if (strtoupper($_SERVER['REQUEST_METHOD'] !== 'GET')) {
	http_response_code(405);
	echo json_encode(['error' => true, 'message' => 'Method not allowed'], JSON_PRETTY_PRINT);
	exit;
}

if (empty($_GET['email'])) {
	http_response_code(400);
	echo json_encode(['error' => true, 'message' => 'Bad request'], JSON_PRETTY_PRINT);
	exit;
}

$user = null;
try {
	$user = BeaconUser::GetByEmail($_GET['email']);
} catch (Exception $e) {
	http_response_code(500);
	echo json_encode(['error' => true, 'message' => 'Internal server error'], JSON_PRETTY_PRINT);
	exit;
}

http_response_code(200);
if (is_null($user)) {
	echo json_encode(['error' => false, 'email' => $_GET['email'], 'omni' => false], JSON_PRETTY_PRINT);
} else {
	echo json_encode(['error' => false, 'email' => $_GET['email'], 'omni' => ($user->OmniVersion() >= 1)], JSON_PRETTY_PRINT);
}

?>