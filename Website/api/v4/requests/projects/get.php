<?php

use BeaconAPI\v4\{Response, Core, Project, User};

$authScheme = Core::kAuthSchemeNone;
$requiredScopes = [];
	
function handleRequest(array $context): Response {
	$projectId = $context['pathParameters']['projectId'];
	$authorizedUserId = Core::UserId();
		
	if (!BeaconCommon::IsUUID($projectId)) {
		return Response::NewJsonError('Must use a v4 UUID', $projectId, 400);
	}
	
	$project = Project::Fetch($projectId);
	if (is_null($project)) {
		return Response::NewJsonError('Project not found', $projectId, 404);
	}
	
	switch ($context['routeKey']) {
	case 'GET /projects/{projectId}/metadata':
		return Response::NewJson($project, 200);
	case 'GET /projects/{projectId}':
		if (is_null($authorizedUserId) || $authorizedUserId !== $project->UserId()) {
			$project->IncrementDownloadCount();
		}
		return HandleDocumentDataRequest($project, null);
	case 'GET /projects/{projectId}/versions':
		return Response::NewJson($project->Versions(), 200);
	case 'GET /projects/{projectId}/versions/{versionId}':
		$versionId = $context['pathParameters']['versionId'];
		return HandleDocumentDataRequest($project, $versionId);
	}
}

function HandleDocumentDataRequest(Project $project, $versionId = null): Response {
	$bestOption = '*';
	$accept = isset($_SERVER['HTTP_ACCEPT_ENCODING']) ? strtolower(trim($_SERVER['HTTP_ACCEPT_ENCODING'])) : '';
	if ($accept !== '') {
		$pieces = explode(',', $accept);
		$bestQuality = 0;
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
			
			if ($quality > $bestQuality && in_array($option, $supported)) {
				$bestOption = $option;
				$bestQuality = $quality;
			}
		}
	}
	
	try {
		$project->PreloadContent($versionId); // If there is an error, this one will fire the exception
		$compressOutput = ($bestOption == 'gzip');
		$content = $project->Content($compressOutput, false, $versionId);
		$compressed = BeaconCommon::IsCompressed($content);
		$isBinaryFormat = Project::IsBinaryProjectFormat($content);
		$headers = [
			'Content-Type' => $isBinaryFormat ? 'application/x-beacon-project' : 'application/octet-stream',
			'Content-Disposition' => 'attachment; filename="' . preg_replace('/[^a-z09\-_ \(\)]/i', '', $project->Name()) . '.beacon"',
		];
		if ($compressed) {
			$headers['Content-Encoding'] = 'gzip';
		}
		
		return new Response(200, $content, $headers);
	} catch (Exception $err) {
		return Response::NewJsonError($err->getMessage(), null, 500);
	}
}

?>