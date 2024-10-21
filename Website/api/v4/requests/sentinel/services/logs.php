<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{LogMessage, Service};

$requiredScopes[] = Application::kScopeSentinelServicesRead;

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$serviceId = $context['pathParameters']['serviceId'];
	$service = Service::Fetch($serviceId);
	if ($service && $service->HasPermission($userId, Service::PermissionView) === false) {
		return Response::NewJsonError('Service not found', null, 404);
	}

	$filters = $_GET;
	$filters['serviceId'] = $serviceId;

	$logs = LogMessage::Search($filters);
	return Response::NewJSON($logs, 200);
}

?>
