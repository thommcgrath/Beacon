<?php

use BeaconAPI\v4\{Core, Project, ProjectMember, Response, User};
	
function handleRequest(array $context): Response {
	if (Core::IsJsonContentType() === false) {
		return Response::NewJsonError('Send JSON object with a application/json Content-Type header.', null, 400);
	}
	
	$projectId = $context['pathParameters']['projectId'];
	$userId = strtolower($context['pathParameters']['userId']); // Could be a UUID, email address, or username
	$body = Core::BodyAsJson();
	$role = $body['role'] ?? '';
	$encryptedPassword = $body['encryptedPassword'] ?? null;
	$fingerprint = $body['fingerprint'] ?? null;
	$authorizedUserId = Core::UserId();
	
	if ($role === ProjectMember::kRoleOwner) {
		return Response::NewJsonError('A project cannot have two owners.', null, 400);
	}
	if ($userId === $authorizedUserId) {
		return Response::NewJsonError('Cannot change own permissions.', null, 400);
	}
	
	$project = Project::FetchForUser($projectId, $authorizedUserId);
	if (is_null($project)) {
		return Response::NewJsonError('Project not found.', null, 404);
	}
	if ($project->Permissions() < 80) {
		return Response::NewJsonError('Only the project owner and admins may add users to a project.', null, 403);
	}
	
	$user = User::Fetch($userId);
	if (is_null($user)) {
		return Response::NewJsonError('User not found.', $userId, 404);
	}
	
	$member = ProjectMember::Create($projectId, $user->UserId(), $role, $encryptedPassword, $fingerprint);
	if (is_null($member)) {
		return Response::NewJsonError('User was not added to project.', null, 500);
	}
	
	return Response::NewJson($member, 200);
}

?>
