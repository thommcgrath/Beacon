<?php

use BeaconAPI\v4\{Core, Project, ProjectGuest, Response};
	
function handleRequest(array $context): Response {
	$projectId = $context['pathParameters']['projectId'];
	$authorizedUserId = Core::UserId();
		
	$project = Project::Fetch($projectId);
	if (is_null($project)) {
		return Response::NewJsonError('Project not found.', null, 404);
	}
	if ($project->OwnerId() !== $authorizedUserId) {
		return Response::NewJsonError('Only the project owner may view project guests.', null, 403);
	}
	
	$guests = ProjectGuest::List($projectId);
	return Response::NewJson($guests, 200);
}

?>
