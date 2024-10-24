<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{Script};

$requiredScopes[] = Application::kScopeSentinelServicesCreate;

function handleRequest(array $context): Response {
	$userId = Core::UserId();

	$obj = null;
	if (Core::IsJsonContentType()) {
		$obj = Core::BodyAsJson();
	}
	if (empty($obj)) {
		return Response::NewJsonError('No script objects were included.', $obj, 400);
	}
	if (BeaconCommon::IsAssoc($obj)) {
		$requests = [$obj];
		$multiResponse = false;
	} else {
		$requests = $obj;
		$multiResponse = true;
	}

	$scripts = [];
	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	foreach ($requests as $request) {
		$request['userId'] = $userId;
		try {
			$scripts[] = Script::Create($request);
		} catch (Exception $err) {
			$database->Rollback();
			return Response::NewJsonError('Could not create script: ' . $err->getMessage(), $request, 400);
		}
	}
	$database->Commit();

	if ($multiResponse) {
		return Response::NewJson($scripts, 201);
	} else {
		return Response::NewJson($scripts[0], 201);
	}
}

?>
