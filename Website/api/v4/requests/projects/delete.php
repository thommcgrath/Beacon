<?php

use BeaconAPI\v4\{Response, BatchResponse, Core, Project, User};
	
function handleRequest(array $context): Response {
	if ($context['routeKey'] === 'DELETE /projects') {
		$projectIds = Core::BodyAsJSON();
		if (is_array($projectIds) === false || BeaconCommon::IsAssoc($projectIds)) {
			return Response::NewJsonError('Send an array of project uuids', $projectIds, 400);
		}
		
		$userId = Core::UserId();
		$responses = new BatchResponse('projectId');
		foreach ($projectIds as $projectId) {
			$responses->AddResponse($projectId, DeleteProject($projectId, $userId));
		}
		return $responses;
	} else {
		return DeleteProject($context['pathParameters']['projectId'], Core::UserId());
	}
}

function DeleteProject(string $projectId, string $userId): Response {
	if (!BeaconCommon::IsUUID($projectId)) {
		return Response::NewJsonError('Must use a v4 UUID', null, 400);
	}
	
	$project = Project::Fetch($projectId);
	if (is_null($project)) {
		return Response::NewJsonError('Project not found', null, 404);
	}
	
	if ($project->UserId() !== $userId) {
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
