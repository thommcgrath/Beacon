<?php

use BeaconAPI\v4\{APIResponse, Core, Project, User};
Core::Authorize();
	
function handle_request(array $context): APIResponse {
	$project_id = $context['path_parameters']['projectId'];
	
	if (!BeaconCommon::IsUUID($project_id)) {
		return APIResponse::NewJSONError('Must use a v4 UUID', $project_id, 400);
	}
	
	$project = Project::Fetch($project_id);
	if (is_null($project)) {
		return APIResponse::NewJSONError('Project not found', $project_id, 404);
	}
	
	$user_id = Core::UserId();
	if ($project->UserId() !== $user_id) {
		return APIResponse::NewJSONError('Forbidden', $project_id, 403);
	}
	
	$project->Delete();
	return APIResponse::NewNoContent();
}

?>