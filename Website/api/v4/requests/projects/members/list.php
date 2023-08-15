<?php

use BeaconAPI\v4\{Core, Project, ProjectMember, Response};
	
function handleRequest(array $context): Response {
	$projectId = $context['pathParameters']['projectId'];
	$authorizedUserId = Core::UserId();
		
	$project = Project::FetchForUser($projectId, $authorizedUserId);
	if (is_null($project)) {
		return Response::NewJsonError('Project not found.', null, 404);
	}
	if ($project->Permissions() < 80) {
		return Response::NewJsonError('Only the project owner and admins may view project members.', null, 403);
	}
	
	$members = ProjectMember::List($projectId);
	return Response::NewJson($members, 200);
}

?>
