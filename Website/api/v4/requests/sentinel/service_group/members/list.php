<?php

BeaconAPI::Authorize();
	
function handleRequest(array $context): Response {
	$group_id = $context['pathParameters']['group_id'];
	$group = Sentinel\ServiceGroup::GetByGroupID($context['pathParameters']['group_id']);
	if (is_null($group) || $group->HasPermission(BeaconAPI::UserID(), Sentinel\ServiceGroup::PermissionView) === false) {
		BeaconAPI::ReplyError('Unauthorized', null, 401);
	}
	
	
	$detailed_results = isset($_GET['detailed_results']) && boolval($_GET['detailed_results']);
	$services = $group->LoadServices($detailed_results);
	BeaconAPI::ReplySuccess($services);
}

?>