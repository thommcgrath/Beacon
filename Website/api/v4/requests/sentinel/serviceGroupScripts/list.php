<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{ServiceGroupScript};

$requiredScopes[] = Application::kScopeSentinelServicesRead;

function handleRequest(array $context): Response {
	$_GET['userId'] = Core::UserId();
	$scripts = ServiceGroupScript::Search($_GET);
	return Response::NewJSON($scripts, 200);
}

?>
