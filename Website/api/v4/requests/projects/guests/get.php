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
	$user = User::Fetch($userId);
	if (is_null($user)) {
		return Response::NewJsonError('User not found.', $userId, 404);
	}
	if ($project->OwnerId() !== $authorizedUserId && $user->UserId() !== $authorizedUserId) {
		return Response::NewJsonError('Only the project owner may view project guests.', null, 403);
	}
	
	$guest = ProjectGuest::Fetch($projectId, $user->UserId());
	if (is_null($guest)) {
		return Response::NewJsonError('User is not a guest of this project.', null, 404);
	}
	
	return Response::NewJson($guest, 200);
}

?>
