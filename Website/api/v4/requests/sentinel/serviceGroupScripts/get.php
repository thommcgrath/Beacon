<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{PermissionBits, Script, ServiceGroup, ServiceGroupScript};

$requiredScopes[] = Application::kScopeSentinelServicesRead;

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$serviceGroupScript = ServiceGroupScript::Fetch($context['pathParameters']['serviceGroupScriptId']);
	if (is_null($serviceGroupScript)) {
		return Response::NewJsonError('Service group script not found', null, 404);
	}
	$serviceGroup = ServiceGroup::Fetch($serviceGroupScript->ServiceGroupId());
	if (is_null($serviceGroup) || $serviceGroup->UserHasPermission($userId, PermissionBits::ServiceGroupUpdateContents) === false) {
		return Response::NewJsonError('Service group script not found', null, 404);
	}

	return Response::NewJson($serviceGroupScript, 200);
}

?>
