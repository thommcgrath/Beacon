<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{Service};

$requiredScopes[] = Application::kScopeSentinelServicesRead;

function handleRequest(array $context): Response {
	$_GET['userId'] = Core::UserId();
	$services = Service::Search($_GET);
	return Response::NewJSON($services, 200);
}

?>
