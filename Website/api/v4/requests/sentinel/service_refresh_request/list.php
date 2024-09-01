<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{Service, ServiceRefreshRequest};

$requiredScopes[] = Application::kScopeSentinelServicesRead;

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$_GET['userId'] = Core::UserId();
	$requests = ServiceRefreshRequest::Search($_GET);
	return Response::NewJSON($requests, 200);
}

?>
