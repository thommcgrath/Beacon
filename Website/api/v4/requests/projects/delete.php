<?php

use BeaconAPI\v4\{APIResponse, APIResponseBatch, Core, Project, User};
Core::Authorize();
	
function handle_request(array $context): APIResponse {
	if ($context['route_key'] === 'DELETE /projects') {
		$project_ids = Core::BodyAsJSON();
		if (is_array($project_ids) === false || BeaconCommon::IsAssoc($project_ids)) {
			return APIResponse::NewJSONError('Send an array of project uuids', $project_ids, 400);
		}
		
		$user_id = Core::UserId();
		$responses = new APIResponseBatch('project_id');
		foreach ($project_ids as $project_id) {
			$responses->AddResponse($project_id, DeleteProject($project_id, $user_id));
		}
		return $responses;
	} else {
		return DeleteProject($context['path_parameters']['projectId'], Core::UserId());
	}
}

function DeleteProject(string $project_id, string $user_id): APIResponse {
	if (!BeaconCommon::IsUUID($project_id)) {
		return APIResponse::NewJSONError('Must use a v4 UUID', null, 400);
	}
	
	$project = Project::Fetch($project_id);
	if (is_null($project)) {
		return APIResponse::NewJSONError('Project not found', null, 404);
	}
	
	if ($project->UserId() !== $user_id) {
		return APIResponse::NewJSONError('Forbidden', null, 403);
	}
	
	try {
		$project->Delete();
		return APIResponse::NewNoContent();
	} catch (Exception $err) {
		return APIResponse::NewJSONError($err->getMessage(), null, 500);
	}
}

?>
