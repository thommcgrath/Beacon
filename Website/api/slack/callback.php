<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
	ReplyError('Method not allowed', 405);
}

if (!isset($_POST['payload'])) {
	ReplyError('Payload not included');
}

$payload = json_decode($_POST['payload'], true);
if (is_null($payload)) {
	ReplyError('Invalid payload JSON');
}

$type = $payload['type'];
$callback_id = $payload['callback_id'];
if (strstr($callback_id, ':')) {
	list($callback_id, $callback_value) = explode(':', $callback_id, 2);
} else {
	$callback_value = null;
}

switch ($type) {
case 'interactive_message':
	include('message_reply.php');
	break;
}

function ReplyError(string $message, int $http_status = 400) {
	header('Content-Type: application/json');
	http_response_code($http_status);
	echo json_encode(array('response_type' => 'ephemeral', 'replace_original' => false, 'text' => $message));
	exit;
}

?>