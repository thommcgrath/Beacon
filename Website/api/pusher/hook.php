<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');
header('Content-Type: text/plain');
http_response_code(400);

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
	http_response_code(405);
	echo "Method not allowed\n";
	exit;
}

$sentPusherKey = $_SERVER['HTTP_X_PUSHER_KEY'];
$sentPusherSignature = $_SERVER['HTTP_X_PUSHER_SIGNATURE'];
$body = @file_get_contents('php://input');

$requiredPusherKey = BeaconCommon::GetGlobal('Pusher Key');
$requiredPusherSignature = hash_hmac('sha256', $body, BeaconCommon::GetGlobal('Pusher Secret'));

if ($requiredPusherKey !== $sentPusherKey || $requiredPusherSignature !== $sentPusherSignature) {
	http_response_code(403);
	echo "Forbidden\n";
	exit;
}

http_response_code(500);

$payload = json_decode($body, true);
$events = $payload['events'];
foreach ($events as $event) {
	$channelName = $event['channel'];
	$eventName = $event['name'];

	switch ($eventName) {
	case 'channel_occupied':
		BeaconRabbitMQ::SendMessage('sentinel_exchange', 'sentinel.watchers.pusherChannelOccupied', json_encode(['channelName' => $channelName]));
		break;
	case 'channel_vacated':
		BeaconRabbitMQ::SendMessage('sentinel_exchange', 'sentinel.watchers.pusherChannelVacated', json_encode(['channelName' => $channelName]));
		break;
	}
}

http_response_code(200);
echo "Received\n";
