<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{Service, RCONCommand};
use PhpAmqpLib\Connection\AMQPStreamConnection;
use PhpAmqpLib\Message\AMQPMessage;

$requiredScopes[] = Application::kScopeSentinelLogsUpdate;

function handleRequest(array $context): Response {
	$userId = Core::UserId();

	if (Core::IsJsonContentType()) {
		$obj = Core::BodyAsJson();
	} else {
		$obj = $_POST;
	}
	$serviceId = $obj['serviceId'] ?? null;
	if (BeaconCommon::IsUUID($serviceId) === false) {
		return Response::NewJsonError('Must include a serviceId UUID.', $obj, 400);
	}

	$service = Service::Fetch($serviceId);
	if (is_null($service) || $service->HasPermission($userId, Service::PermissionEdit) === false) {
		return Response::NewJsonError('User not authorized for this service.', null, 400);
	}

	$obj['userId'] = $userId;
	$database = BeaconCommon::Database();
	try {
		$database->BeginTransaction();
		$command = RCONCommand::Create($obj);

		// Send the command to RabbitMQ
		$connection = new AMQPStreamConnection(BeaconCommon::GetGlobal('RabbitMQ Host'), BeaconCommon::GetGlobal('RabbitMQ Port'), BeaconCommon::GetGlobal('RabbitMQ User'), BeaconCommon::GetGlobal('RabbitMQ Password'), BeaconCommon::GetGlobal('RabbitMQ Virtual Host'));
		$channel = $connection->channel();
		$channel->queue_declare('', false, false, false, true);
		$channel->basic_publish(new AMQPMessage(json_encode([
			'serviceId' => $serviceId,
			'rconCommand' => $obj['command'],
			'commandId' => $command->LogId(),
		])), 'sentinel_watcher', 'com.thezaz.beacon.sentinel.rconCommand');
		$channel->close();
		$connection->close();
		$database->Commit();

		return Response::NewJSON($command, 201);
	} catch (Exception $err) {
		$database->Rollback();
		return Response::NewJsonError($err->getMessage(), null, 400);
	}
}

?>
