<?php

use BeaconAPI\v4\{Core, Project, ProjectGuest, Response, User};
	
function handleRequest(array $context): Response {
	$projectId = $context['pathParameters']['projectId'];
	$userId = $context['pathParameters']['userId']; // Could be a UUID, email address, or username
	$authorizedUserId = Core::UserId();
		
	$project = Project::Fetch($projectId);
	if (is_null($project)) {
		return Response::NewJsonError('Project not found.', null, 404);
	}
	if ($project->OwnerId() !== $authorizedUserId) {
		return Response::NewJsonError('Only the project owner may add users to a project.', null, 403);
	}
	
	$user = User::Fetch($userId);
	if (is_null($user)) {
		return Response::NewJsonError('User not found.', $userId, 404);
	}
	
	$guest = ProjectGuest::Create($projectId, $user->UserId());
	if (is_null($guest)) {
		return Response::NewJsonError('User was not added to project.', null, 500);
	}
	
	return Response::NewJson($guest, 200);
}

?>
