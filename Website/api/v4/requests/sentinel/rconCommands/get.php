<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{PermissionBits, RCONCommand, Service};

$requiredScopes[] = Application::kScopeSentinelServicesRead;
$requiredScopes[] = Application::kScopeSentinelLogsRead;

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$command = RCONCommand::Fetch($context['pathParameters']['logId']);
	if (is_null($command)) {
		return Response::NewJsonError('Command not found', null, 404);
	}
	$service = Service::Fetch($command->ServiceId());
	if ($service && $service->HasPermission($userId, PermissionBits::ServiceRead)) {
		return Response::NewJSON($command, 200);
	} else {
		return Response::NewJsonError('Command not found', null, 404);
	}
}

?>
