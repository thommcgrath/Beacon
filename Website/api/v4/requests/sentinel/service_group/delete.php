<?php

BeaconAPI::Authorize();

function handleRequest(array $context): Response {
	$user_id = BeaconAPI::UserID();
		
	$group = Sentinel\ServiceGroup::GetByGroupID($context['pathParameters']['group_id']);
	if ($group && $group->HasPermission($user_id, Sentinel\ServiceGroup::PermissionDelete)) {
		$group->Delete();
		BeaconAPI::ReplySuccess('', 204);
	} else {
		BeaconAPI::ReplyError('Service group not found', null, 404);
	}
}

?>