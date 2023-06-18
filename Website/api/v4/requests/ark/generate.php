<?php

use BeaconAPI\v4\{Core, Project, Response};
use BeaconAPI\v4\Ark\Generator;

function handleRequest(array $context): Response {
	$projectId = $context['pathParameters']['projectId'];
	if (BeaconCommon::IsUUID($projectId) === false) {
		return Response::NewJsonError('Request a specific project.', null, 400);
	}
	
	$project = Project::Fetch($projectId);
	if (is_null($project) || ($project->IsPublic() === false && $project->UserId() !== Core::UserID())) {
		return Response::NewJsonError('Project not found.', null, 404);
	}
	if ($project->GameId() !== 'Ark') {
		return Response::NewJsonError('Project is not an Ark project.', null, 400);
	}
	
	$generator = new Generator($project);
	if (isset($_REQUEST['qualityScale'])) {
		$generator->SetQualityScale(floatval($_REQUEST['qualityScale']));
	}
	if (isset($_REQUEST['difficultyValue'])) {
		$generator->SetDifficultyValue(floatval($_REQUEST['difficultyValue']));
	}
	if (isset($_REQUEST['mapMask'])) {
		$generator->SetMapMask(intval($_REQUEST['mapMask']));
	}
	
	$originalIni = '';
	if ($context['routeKey'] === 'PUT /ark/projects/{projectId}/Game.ini') {
		if (Core::ContentType() === 'application/x-www-form-urlencoded' || Core::ContentType() === 'multipart/form-data') {
			if (isset($_POST['content'])) {
				$originalIni = $_POST['content'];
			}
		} else {
			$originalIni = Core::Body();
		}
	}
	
	$output = $generator->Generate($originalIni);
	return new Response(200, $output, ['Content-Type' => 'text/plain', 'Content-MD5' => md5($output)]);
}

