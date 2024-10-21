<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{RCONCommand};

$requiredScopes[] = Application::kScopeSentinelServicesRead;
$requiredScopes[] = Application::kScopeSentinelLogsRead;

function handleRequest(array $context): Response {
	$_GET['userId'] = Core::UserId();
	$commands = RCONCommand::Search($_GET);
	return Response::NewJSON($commands, 200);
}

?>
