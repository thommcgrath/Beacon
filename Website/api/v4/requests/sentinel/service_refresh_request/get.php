<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{Service, ServiceRefreshRequest};

$requiredScopes[] = Application::kScopeSentinelServicesRead;

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$requestId = $context['pathParameters']['requestId'];
	$request = ServiceRefreshRequest::Fetch($requestId);
	if (is_null($request)) {
		return Response::NewJsonError('Request not found.', null, 404);
	}

	$service = Service::Fetch($request->ServiceId());
	if (is_null($service) || $service->HasPermission($userId, Service::PermissionView) === false) {
		return Response::NewJsonError('User not authorized for this service.', null, 400);
	}

	return Response::NewJSON($request, 200);
}

?>
