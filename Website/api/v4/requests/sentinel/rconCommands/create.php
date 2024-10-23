<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{PermissionBits, Service, RCONCommand};

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
	if (is_null($service) || $service->HasPermission($userId, PermissionBits::ServiceUpdate) === false) {
		return Response::NewJsonError('User not authorized for this service.', null, 400);
	}

	$obj['userId'] = $userId;
	$database = BeaconCommon::Database();
	try {
		$database->BeginTransaction();
		$command = RCONCommand::Create($obj);

		// Send the command to RabbitMQ
		BeaconRabbitMQ::SendMessage('sentinel_watcher', 'com.thezaz.beacon.sentinel.rconCommand', json_encode([
			'serviceId' => $serviceId,
			'rconCommand' => $obj['command'],
			'commandId' => $command->LogId(),
		]));

		$database->Commit();
		return Response::NewJSON($command, 201);
	} catch (Exception $err) {
		$database->Rollback();
		return Response::NewJsonError($err->getMessage(), null, 400);
	}
}

?>
