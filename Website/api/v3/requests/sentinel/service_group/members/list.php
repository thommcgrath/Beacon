<?php

BeaconAPI::Authorize();
	
function handle_request(array $context): void {
	$group_id = $context['path_parameters']['group_id'];
	$group = Sentinel\ServiceGroup::GetByGroupID($context['path_parameters']['group_id']);
	if (is_null($group) || $group->HasPermission(BeaconAPI::UserID(), Sentinel\ServiceGroup::PermissionView) === false) {
		BeaconAPI::ReplyError('Unauthorized', null, 401);
	}
	
	
	$detailed_results = isset($_GET['detailed_results']) && boolval($_GET['detailed_results']);
	$services = $group->LoadServices($detailed_results);
	BeaconAPI::ReplySuccess($services);
}

?>