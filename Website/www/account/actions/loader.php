<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');

header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

function Finish(int $status, string $message = '', $obj = null) {
	http_response_code($status);
	echo json_encode(['error' => ($status < 200 || $status >= 400), 'message' => $message, 'obj' => $obj], JSON_PRETTY_PRINT);
	exit;
}

function RequestMethod() {
	return strtoupper($_SERVER['REQUEST_METHOD']);
}

function RequestObjectID(int $place = 0) {
	if (!isset($_SERVER['PATH_INFO'])) {
		return null;
	}
	
	$request = explode('/', trim($_SERVER['PATH_INFO'],'/'));
	if ((is_array($request) === false) || (count($request) == 0)) {
		return null;
	}
	
	if (empty($request[$place])) {
		return null;
	}
	
	return $request[$place];
}

function RequestBody() {
	$body = null;
	if (RequestMethod() == 'GET') {
		$body = $_SERVER['QUERY_STRING'];
	} else {
		$body = file_get_contents('php://input');
	}
	if (isset($_SERVER['HTTP_CONTENT_ENCODING']) && $_SERVER['HTTP_CONTENT_ENCODING'] == 'gzip') {
		$body = gzdecode($body);
	}
	return $body;
}

?>
