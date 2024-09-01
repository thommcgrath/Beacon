<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{Service};

$requiredScopes[] = Application::kScopeSentinelServicesRead;

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$service = Service::Fetch($context['pathParameters']['serviceId']);
	if ($service && $service->HasPermission($userId, Service::PermissionView)) {
		return Response::NewJSON($service, 200);
	} else {
		return Response::NewJsonError('Service not found', null, 404);
	}
}

?>
