<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{ServiceGroup};

$requiredScopes[] = Application::kScopeSentinelServicesUpdate;

function handleRequest(array $context): Response {
	$userId = Core::UserId();
	$groupId = $context['pathParameters']['serviceGroupId'];
	$group = ServiceGroup::Fetch($groupId);
	if (is_null($group) || $group->HasPermission($userId, ServiceGroup::PermissionEdit) === false) {
		return Response::NewJsonError('Service group not found', null, 404);
	}

	$added = [];
	$removed = [];
	$skipped = [];
	$body = Core::BodyAsJson();
	if (isset($body['add'])) {
		$additions = $body['add'];
		foreach ($additions as $serviceId) {
			if ($group->AddService($serviceId, $userId)) {
				$added[] = $serviceId;
			} else {
				$skipped[] = $serviceId;
			}
		}
	}
	if (isset($body['remove'])) {
		$removals = $body['remove'];
		foreach ($removals as $serviceId) {
			if ($group->RemoveService($serviceId, $userId)) {
				$removed[] = $serviceId;
			} else {
				$skipped[] = $serviceId;
			}
		}
	}

	$results = [
		'added' => $added,
		'removed' => $removed,
		'skipped' => $skipped,
		'members' => $group->LoadServices(false)
	];
	return Response::NewJson($results, 200);
}

?>
