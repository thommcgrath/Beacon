<?php

use BeaconAPI\v4\{Core, Project, ProjectMember, Response};
	
function handleRequest(array $context): Response {
	$projectId = $context['pathParameters']['projectId'];
	$authorizedUserId = Core::UserId();
		
	$project = Project::FetchForUser($projectId, $authorizedUserId);
	if (is_null($project)) {
		return Response::NewJsonError('Project not found.', null, 404);
	}
	
	$members = ProjectMember::List($projectId);
	return Response::NewJson($members, 200);
}

?>
