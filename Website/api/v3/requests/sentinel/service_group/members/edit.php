<?php

BeaconAPI::Authorize();
	
function handle_request(array $context): void {
	$user_id = BeaconAPI::UserID();
	$group_id = $context['path_parameters']['group_id'];
	$group = Sentinel\ServiceGroup::GetByGroupID($context['path_parameters']['group_id']);
	if (is_null($group) || $group->HasPermission($user_id, Sentinel\ServiceGroup::PermissionEdit) === false) {
		BeaconAPI::ReplyError('Unauthorized', null, 401);
	}
	
	$added = [];
	$removed = [];
	$skipped = [];
	$body = BeaconAPI::JSONPayload();
	if (isset($body['add'])) {
		$additions = $body['add'];
		foreach ($additions as $service_id) {
			if ($group->AddService($service_id, $user_id)) {
				$added[] = $service_id;
			} else {
				$skipped[] = $service_id;
			}
		}
	}
	if (isset($body['remove'])) {
		$removals = $body['remove'];
		foreach ($removals as $service_id) {
			if ($group->RemoveService($service_id, $user_id)) {
				$removed[] = $service_id;
			} else {
				$skipped[] = $service_id;
			}
		}
	}
	
	$results = [
		'added' => $added,
		'removed' => $removed,
		'skipped' => $skipped,
		'members' => $group->LoadServices(false)
	];
	BeaconAPI::ReplySuccess($results);
}

?>