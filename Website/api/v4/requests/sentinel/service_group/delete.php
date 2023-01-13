<?php

BeaconAPI::Authorize();

function handle_request(array $context): void {
	$user_id = BeaconAPI::UserID();
		
	$group = Sentinel\ServiceGroup::GetByGroupID($context['path_parameters']['group_id']);
	if ($group && $group->HasPermission($user_id, Sentinel\ServiceGroup::PermissionDelete)) {
		$group->Delete();
		BeaconAPI::ReplySuccess('', 204);
	} else {
		BeaconAPI::ReplyError('Service group not found', null, 404);
	}
}

?>