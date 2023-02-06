<?php

use BeaconAPI\v4\{Response, Core, Project, User};
Core::Authorize(Core::kAuthFlagOptional);
	
function handleRequest(array $context): Response {
	$project_id = $context['pathParameters']['projectId'];
	$authorized_user_id = Core::UserId();
		
	if (!BeaconCommon::IsUUID($project_id)) {
		return Response::NewJsonError('Must use a v4 UUID', $project_id, 400);
	}
	
	$project = Project::Fetch($project_id);
	if (is_null($project)) {
		return Response::NewJsonError('Project not found', $project_id, 404);
	}
	
	switch ($context['routeKey']) {
	case 'GET /projects/{projectId}/metadata':
		return Response::NewJson($project, 200);
	case 'GET /projects/{projectId}':
		if (is_null($authorized_user_id) || $authorized_user_id !== $project->UserId()) {
			$project->IncrementDownloadCount();
		}
		return HandleDocumentDataRequest($project, null);
	case 'GET /projects/{projectId}/versions':
		return Response::NewJson($project->Versions(), 200);
	case 'GET /projects/{projectId}/versions/{versionId}':
		$version_id = $context['pathParameters']['versionId'];
		return HandleDocumentDataRequest($project, $version_id);
	}
}

function HandleDocumentDataRequest(Project $project, $version_id = null): Response {
	$best_option = '*';
	$accept = isset($_SERVER['HTTP_ACCEPT_ENCODING']) ? strtolower(trim($_SERVER['HTTP_ACCEPT_ENCODING'])) : '';
	if ($accept !== '') {
		$pieces = explode(',', $accept);
		$best_quality = 0;
		$supported = ['gzip', '*'];
		foreach ($pieces as $piece) {
			$piece = trim($piece);
			if (strpos($piece, ';') === false) {
				$option = $piece;
				$quality = 1;
			} else {
				list($option, $quality) = explode(';', $piece, 2);
				$quality = substr($quality, 2);
			}
			
			if ($quality > $best_quality && in_array($option, $supported)) {
				$best_option = $option;
				$best_quality = $quality;
			}
		}
	}
	
	try {
		$project->PreloadContent($version_id); // If there is an error, this one will fire the exception
		$compressed = ($best_option == 'gzip');
		$headers = [
			'Content-Type' => 'application/octet-stream',
			'Content-Disposition' => 'attachment; filename="' . preg_replace('/[^a-z09\-_ \(\)]/i', '', $project->Title()) . '.beacon"',
		];
		if ($compressed) {
			$headers['Content-Encoding'] = 'gzip';
		}
		
		return new Response(200, $project->Content($compressed, false, $version_id), $headers);
	} catch (Exception $err) {
		return Response::NewJsonError($err->getMessage(), null, 500);
	}
}

?>