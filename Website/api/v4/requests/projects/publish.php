<?php

BeaconAPI::Authorize(true);
	
function handle_request(array $context): void {
	$project_id = $context['path_parameters']['project_id'];
	if (\BeaconCommon::IsUUID($project_id) === false) {
		BeaconAPI::ReplyError('Specify one project by UUID.', null, 400);
	}
	
	$projects = \BeaconAPI\Project::GetSharedDocumentByID($project_id, BeaconAPI::UserID());
	if (is_null($projects) || count($projects) != 1) {
		BeaconAPI::ReplyError('Document not found', null, 404);
	}
	$project = $projects[0];
	
	if ($context['route_key'] === 'POST /project/{project_id}/publish') {
		if ($project->UserID() !== BeaconAPI::UserID()) {
			BeaconAPI::ReplyError('Not authorized', null, 403);
		}
		
		$payload = BeaconAPI::JSONPayload();
		$desired_status = $payload['status'];
		$project->SetPublishStatus($desired_status);
	}
	
	BeaconAPI::ReplySuccess(['project_id' => $project_id, 'status' => $project->PublishStatus()]);
}

?>