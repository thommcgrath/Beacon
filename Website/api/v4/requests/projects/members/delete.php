<?php

use BeaconAPI\v4\{Core, Project, ProjectMember, Response, User};
	
function handleRequest(array $context): Response {
	$projectId = $context['pathParameters']['projectId'];
	$userId = strtolower($context['pathParameters']['userId']); // Could be a UUID, email address, or username
	$authorizedUserId = Core::UserId();
		
	$project = Project::FetchForUser($projectId, $authorizedUserId);
	if (is_null($project)) {
		return Response::NewJsonError('Project not found.', null, 404);
	}
	if ($userId === $authorizedUserId) {
		$project->Delete();
		return Response::NewJson('You have been removed from the project.', 200);
	}
	
	$user = User::Fetch($userId);
	if (is_null($user)) {
		return Response::NewJsonError('User not found.', $userId, 404);
	}
	if ($project->UserId() !== $authorizedUserId && $project->Permissions() < 80) {
		return Response::NewJsonError('A member can only be removed from a project by the member, an admin, or the owner of the project.', null, 403);
	}
	
	$guest = ProjectMember::Fetch($projectId, $user->UserId());
	if (is_null($guest)) {
		return Response::NewJsonError('User is not a member of this project.', null, 404);
	}
	$guest->Delete();
	
	return Response::NewJson('Member has been removed from the project.', 200);
}

?>
