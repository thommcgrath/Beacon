<?php

use BeaconAPI\v4\{APIResponse, Core, Project, User};
Core::Authorize();
	
function handle_request(array $context): APIResponse {
	switch ($context['route_key']) {
	case 'PUT /projects/{projectId}':
		$project_id = strtolower($context['path_parameters']['projectId']);
		$project = Project::Fetch($project_id);
		if (is_null($project) === false && $project->UserId() !== Core::UserId()) {
			return APIResponse::NewJSONError('Forbidden', $project_id, 403);
		}
		
		if (isset($_POST['project_id']) && $_POST['project_id'] !== $project_id) {
			return APIResponse::NewJSONError('Do not include project_id property', $project_id, 400);
		}
		
		// Since this is a replace operation, the project needs to be removed and replaced
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		try {
			$database->Query('DELETE FROM public.projects WHERE project_id = $1;', $project_id);
			$failure_reason = '';
			$saved = Project::SaveFromMultipart(Core::User(), $failure_reason);
			if ($saved === false) {
				$database->Rollback();
				return APIResponse::NewJSONError($failure_reason, $project_id, 400);
			}
			$project = Project::Fetch($project_id);
			if (is_null($project)) {
				$database->Rollback();
				return APIResponse::NewJSONError('No object added to database', $project_id, 500);
			}
			$database->Commit();
			return APIResponse::NewJSON($project, 201);
		} catch (Exception $err) {
			$database->Rollback();
			return APIResponse::NewJSONError($err->getMessage(), $project_id, 500);
		}
	case 'POST /projects':
		if (isset($_POST['project_id']) && empty($_POST['project_id']) === false) {
			return APIResponse::NewJSONError('Do not include project_id property', $_POST['project_id'], 400);
		}
		
		$saved = Project::SaveFromMultipart(Core::User(), $failure_reason);
		if ($saved === false) {
			return APIResponse::NewJSONError($failure_reason, null, 400);
		}
		$project = Project::Fetch($project_id);
		if (is_null($project)) {
			return APIResponse::NewJSONError('No object added to database', null, 500);
		}
		return APIResponse::NewJSON($project, 201);
	default:
		return APIResponse::NewJSONError('Unknown route', $context['route_key'], 500);
	}
}

?>
