<?php

use BeaconAPI\v4\{Response, Core, Project, User};
	
function handleRequest(array $context): Response {
	if (Core::ContentType() !== 'multipart/form-data') {
		return Response::NewJsonError('Unsupported media type', 'Send multipart/form-data', 415);
	}
	
	$projectId = $context['pathParameters']['projectId'];
	$project = Project::Fetch($projectId);
	$errorDetails = ['projectId' => $projectId];
	$newProject = is_null($project);
	$userId = Core::UserId();
	
	if ($newProject === false && $project->UserId() !== $userId) {
		return Response::NewJsonError('Forbidden.', $errorDetails, 403);
	}
	
	$name = $_POST['name'] ?? '';
	$errorDetails['name'] = $name;
	if (empty($name)) {
		return Response::NewJsonError('Project name should not be empty.', $errorDetails, 400);
	}
	
	$existingProjects = Project::Search(['name' => $name, 'userId' => $userId], true);
	if (count($existingProjects) > 0) {
		$nameError = true;
		if ($newProject === false) {
			foreach ($existingProjects as $existingProject) {
				if ($existingProject->ProjectId() === $projectId) {
					$nameError = false;
					break;
				}
			}
		}
		if ($nameError) {
			return Response::NewJsonError('There is already a project with this name. Please choose another.', $errorDetails, 400);
		}
	}

	return Response::NewJsonError('Not implemented yet', $errorDetails, 500);
}

?>
