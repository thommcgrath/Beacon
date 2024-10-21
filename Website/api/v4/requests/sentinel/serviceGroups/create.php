<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{ServiceGroup};

$requiredScopes[] = Application::kScopeSentinelServicesCreate;

function handleRequest(array $context): Response {
	$userId = Core::UserId();

	$obj = null;
	if (Core::IsJsonContentType()) {
		$obj = Core::BodyAsJson();
	}
	if (empty($obj)) {
		return Response::NewJsonError('No service group objects were included.', $obj, 400);
	}
	if (BeaconCommon::IsAssoc($obj)) {
		$serviceGroupRequests = [$obj];
		$multiResponse = false;
	} else {
		$serviceGroupRequests = $obj;
		$multiResponse = true;
	}

	$newGroups = [];
	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	foreach ($serviceGroupRequests as $serviceGroupRequest) {
		$serviceGroupRequest['userId'] = $userId;
		try {
			$newGroups[] = ServiceGroup::Create($serviceGroupRequest);
		} catch (Exception $err) {
			$database->Rollback();
			return Response::NewJsonError('Could not register service group: ' . $err->getMessage(), $serviceGroupRequest, 400);
		}
	}
	$database->Commit();

	if ($multiResponse) {
		return Response::NewJson($newGroups, 201);
	} else {
		return Response::NewJson($newGroups[0], 201);
	}
}

?>
