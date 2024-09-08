<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{Service, ServiceRefreshRequest};

$requiredScopes[] = Application::kScopeSentinelServicesCreate;

function handleRequest(array $context): Response {
	$userId = Core::UserId();

	$obj = null;
	if (Core::IsJsonContentType()) {
		$obj = Core::BodyAsJson();
	}
	if (empty($obj)) {
		return Response::NewJsonError('No service objects were included.', $obj, 400);
	}
	if (BeaconCommon::IsAssoc($obj)) {
		$serviceRequests = [$obj];
		$multiResponse = false;
	} else {
		$serviceRequests = $obj;
		$multiResponse = true;
	}

	$newServices = [];
	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	foreach ($serviceRequests as $serviceRequest) {
		$serviceRequest['userId'] = $userId;
		try {
			$newService = Service::Create($serviceRequest);
			ServiceRefreshRequest::Create([
				'serviceId' => $newService->ServiceId(),
				'userId' => $userId,
			]);
			$newServices[] = $newService;
		} catch (Exception $err) {
			$database->Rollback();
			return Response::NewJsonError('Could not register service: ' . $err->getMessage(), $serviceRequest, 400);
		}
	}
	$database->Commit();

	if ($multiResponse) {
		return Response::NewJson($newServices, 201);
	} else {
		return Response::NewJson($newServices[0], 201);
	}
}

?>
