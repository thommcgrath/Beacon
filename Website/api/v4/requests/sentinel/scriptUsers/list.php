<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{ScriptUser};

$requiredScopes[] = Application::kScopeSentinelServicesRead;

function handleRequest(array $context): Response {
	$_GET['userId'] = Core::UserId();
	$scriptUsers = ScriptUser::Search($_GET);
	return Response::NewJSON($scriptUsers, 200);
}

?>
