<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');
header('Content-Type: application/json');

if (isset($_SERVER['HTTP_X_SLACK_REQUEST_TIMESTAMP']) === false || isset($_SERVER['HTTP_X_SLACK_SIGNATURE']) === false) {
	http_response_code(400);
	echo "No signature data included";
	exit;
}

$request_timestamp = $_SERVER['HTTP_X_SLACK_REQUEST_TIMESTAMP'];
if (abs(time() - $request_timestamp) > 300) {
	http_response_code(400);
	echo "Request is expired";
	exit;
}

$body = file_get_contents('php://input');
$signing_content = 'v0:' . $request_timestamp . ':' . $body;
$computed_hash = 'v0=' . hash_hmac('sha256', $signing_content, BeaconCommon::GetGlobal('Slack_Signing_Secret'));
$expected_hash = $_SERVER['HTTP_X_SLACK_SIGNATURE'];

if ($computed_hash != $expected_hash) {
	http_response_code(400);
	echo "Hash $computed_hash does not match expected hash of $expected_hash";
	BeaconCommon::PostSlackMessage("Hash $computed_hash does not match expected hash of $expected_hash");
	BeaconCommon::PostSlackMessage($signing_content);
	exit;
}

$command = $_POST['command'];
$text = $_POST['text'];
$response_url = $_POST['response_url'];
$env = BeaconCommon::EnvironmentName();

switch ($command) {
case '/confirm':
case '/confirm-' . $env:
	include('commands/confirm.php');
	break;
case '/changeemail':
case '/changeemail-' . $env:
	include('commands/changeemail.php');
	break;
case '/grant':
case '/grant-' . $env:
	include('commands/grant.php');
	break;
default:
	http_response_code(404);
	echo "Unknown command";
	break;
}

function PostReply(string $reply) {
	http_response_code(200);
	echo json_encode(array('text' => $reply));
}

?>