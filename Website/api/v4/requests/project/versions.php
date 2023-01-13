<?php

BeaconAPI::Authorize(true);
	
function handle_request(array $context): void {
	$user_id = BeaconAPI::UserID();
	$project_id = $context['path_parameters']['project_id'];
	
	if (\BeaconCommon::IsUUID($project_id) === false) {
		BeaconAPI::ReplyError('Specify one project by UUID.', null, 400);
	}
	
	$projects = \BeaconAPI\Project::GetSharedDocumentByID($project_id, $user_id);
	if (is_null($projects) || count($projects) != 1) {
		BeaconAPI::ReplyError('Project not found', null, 404);
	}
	$project = $projects[0];
	
	$versions = $project->Versions();
	BeaconAPI::ReplySuccess($versions);
}

?>