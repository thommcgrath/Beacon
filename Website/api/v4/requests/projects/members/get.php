<?php

use BeaconAPI\v4\{Core, Project, ProjectMember, Response, User};
	
function handleRequest(array $context): Response {
	$projectId = $context['pathParameters']['projectId'];
	$userId = $context['pathParameters']['userId']; // Could be a UUID, email address, or username
	$authorizedUserId = Core::UserId();
		
	$project = Project::FetchForUser($projectId, $authorizedUserId);
	if (is_null($project)) {
		return Response::NewJsonError('Project not found.', null, 404);
	}
	$user = User::Fetch($userId);
	if (is_null($user)) {
		return Response::NewJsonError('User not found.', $userId, 404);
	}
	if ($project->Permissions() < 80) {
		return Response::NewJsonError('Only the project owner and admins may view project guests.', null, 403);
	}
	
	$member = ProjectMember::Fetch($projectId, $user->UserId());
	if (is_null($member)) {
		return Response::NewJsonError('User is not a member of this project.', null, 404);
	}
	
	return Response::NewJson($member, 200);
}

?>
