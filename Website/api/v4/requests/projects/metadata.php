<?php

use BeaconAPI\v4\{Response, Core, Project, User};

function handleRequest(array $context): Response {
	$projectId = $context['pathParameters']['projectId'];
	$authorizedUserId = Core::UserId();
	
	if (Core::IsJsonContentType() === false) {
		return Response::NewJsonError('Send application/json', $projectId, 400);
	}
		
	if (!BeaconCommon::IsUUID($projectId)) {
		return Response::NewJsonError('Must use a v4 UUID', $projectId, 400);
	}
	
	$project = Project::FetchForUser($projectId, Core::User());
	if (is_null($project)) {
		return Response::NewJsonError('Project not found', $projectId, 404);
	}
	
	if ($project->OwnerId() !== $authorizedUserId) {
		return Response::NewJsonError('Only the project owner can change the sharing status.', null, 403);
	}
	
	$body = Core::BodyAsJson();
	$project->SetPublishStatus($body['communityStatus'] ?? 'Private');
	return Response::NewJson($project, 200);
}
?>
