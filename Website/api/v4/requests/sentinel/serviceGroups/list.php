<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{ServiceGroup};

$requiredScopes[] = Application::kScopeSentinelServicesRead;

function handleRequest(array $context): Response {
	$_GET['userId'] = Core::UserId();
	$serviceGroups = ServiceGroup::Search($_GET);
	return Response::NewJSON($serviceGroups, 200);
}

?>
