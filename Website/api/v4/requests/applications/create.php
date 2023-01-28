<?php

use BeaconAPI\v4\{APIResponse, Application, Core};

Core::Authorize('apps:write');

function handle_request(array $context): APIResponse {
	if (Core::IsJsonContentType() === false) {
		return APIResponse::NewJsonError('Send a JSON body', null, 400);
	}
	
	$obj = Core::BodyAsJson();
	$obj['userId'] = Core::UserId();
	try {
		$app = Application::Create($obj);
		return ApiResponse::NewJson($app, 201);
	} catch (Exception $err) {
		return ApiResponse::NewJsonError($err->getMessage(), $obj, 400);
	}
}

?>
