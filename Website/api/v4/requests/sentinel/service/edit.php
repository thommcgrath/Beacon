<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{Service};

$requiredScopes[] = Application::kScopeSentinelServicesUpdate;

function handleRequest(array $context): Response {
	$userId = Core::UserId();

	$service = Service::Fetch($context['pathParameters']['serviceId']);
	if ($service && $service->HasPermission($userId, Service::PermissionEdit)) {
		$serviceProperties = Core::BodyAsJson();
		try {
			$service->Edit($serviceProperties);
			return Response::NewJson($service, 200);
		} catch (Exception $err) {
			return Response::NewJsonError('Could not edit service: ' . $err->getMessage(), $serviceProperties, 400);
		}
	} else {
		return Response::NewJsonError('Service not found', null, 404);
	}
}

?>
