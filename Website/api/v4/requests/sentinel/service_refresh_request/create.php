<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{Service, ServiceRefreshRequest};

$requiredScopes[] = Application::kScopeSentinelServicesRead;

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
	if (is_null($service) || $service->HasPermission($userId, Service::PermissionView) === false) {
		return Response::NewJsonError('User not authorized for this service.', null, 400);
	}

	$requests = ServiceRefreshRequest::Search(['serviceId' => $serviceId, 'isPending' => true], true);
	if (count($requests) !== 0) {
		return Response::NewJsonError('There is already a pending refresh request for this service.', null, 400);
	}

	try {
		$request = ServiceRefreshRequest::Create([
			'serviceId' => $serviceId,
			'userId' => $userId,
		]);
		return Response::NewJSON($request, 201);
	} catch (Exception $err) {
		return Response::NewJsonError($err->getMessage(), null, 400);
	}
}

?>
