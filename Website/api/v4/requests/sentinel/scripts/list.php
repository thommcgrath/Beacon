<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{Script};

$requiredScopes[] = Application::kScopeSentinelServicesRead;

function handleRequest(array $context): Response {
	$_GET['userId'] = Core::UserId();
	$scripts = Script::Search($_GET);
	return Response::NewJSON($scripts, 200);
}

?>
