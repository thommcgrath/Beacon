<?php

BeaconAPI::Authorize();

function handleRequest(array $context): APIResponse {
	$user_id = BeaconAPI::UserID();
		
	$group = Sentinel\ServiceGroup::GetByGroupID($context['pathParameters']['group_id']);
	if ($group && $group->HasPermission($user_id, Sentinel\ServiceGroup::PermissionEdit)) {
		$group->Edit(BeaconAPI::JSONPayload());
		BeaconAPI::ReplySuccess($group);
	} else {
		BeaconAPI::ReplyError('Service group not found', null, 404);
	}
}

?>