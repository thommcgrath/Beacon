<?php

use BeaconAPI\v4\{Response, BatchResponse, Core, Project, User};
	
function handleRequest(array $context): Response {
	if ($context['routeKey'] === 'DELETE /projects') {
		$project_ids = Core::BodyAsJSON();
		if (is_array($project_ids) === false || BeaconCommon::IsAssoc($project_ids)) {
			return Response::NewJsonError('Send an array of project uuids', $project_ids, 400);
		}
		
		$user_id = Core::UserId();
		$responses = new BatchResponse('project_id');
		foreach ($project_ids as $project_id) {
			$responses->AddResponse($project_id, DeleteProject($project_id, $user_id));
		}
		return $responses;
	} else {
		return DeleteProject($context['pathParameters']['projectId'], Core::UserId());
	}
}

function DeleteProject(string $project_id, string $user_id): Response {
	if (!BeaconCommon::IsUUID($project_id)) {
		return Response::NewJsonError('Must use a v4 UUID', null, 400);
	}
	
	$project = Project::Fetch($project_id);
	if (is_null($project)) {
		return Response::NewJsonError('Project not found', null, 404);
	}
	
	if ($project->UserId() !== $user_id) {
		return Response::NewJsonError('Forbidden', null, 403);
	}
	
	try {
		$project->Delete();
		return Response::NewNoContent();
	} catch (Exception $err) {
		return Response::NewJsonError($err->getMessage(), null, 500);
	}
}

?>
