<?php

BeaconAPI::Authorize(true);
	
function handle_request(array $context) {
	$project_id = $context['path_parameters']['project_id'];
	$user_id = BeaconAPI::UserID();
	
	switch ($context['route_key']) {
	case 'GET /project/{project_id}':
		/*if (!BeaconCommon::IsUUID($project_id)) {
			BeaconAPI::ReplyError('Must use a v4 UUID', null, 400);
		}*/
		
		$simple = isset($_GET['simple']);
		
		// specific document(s)
		$projects = \BeaconAPI\Project::GetSharedDocumentByID($project_id, $user_id);
		if (count($projects) === 0) {
			BeaconAPI::ReplyError('No document found', null, 404);
		} elseif (count($projects) > 1) {
			$simple = true;
		}
		
		if ($simple === false) {
			$database = \BeaconCommon::Database();
			$database->BeginTransaction();
			if (is_null($user_id)) {
				$database->Query('UPDATE ' . \BeaconAPI\Project::SchemaName() . '.' . \BeaconAPI\Project::TableName() . ' SET download_count = download_count + 1 WHERE project_id = ANY($1);', '{' . $project_id . '}');
			} else {
				foreach ($projects as $project) {
					if ($project->UserID() !== $user_id) {
						$database->Query('UPDATE ' . \BeaconAPI\Project::SchemaName() . '.' . \BeaconAPI\Project::TableName() . ' SET download_count = download_count + 1 WHERE project_id = $1;', $project->ProjectID());
					}
				}
			}
			$database->Commit();
		}
		
		if (str_contains($project_id, ',') === false) {
			if ($simple) {
				BeaconAPI::ReplySuccess($projects[0]);
			} else {
				HandleDocumentDataRequest($projects[0], null);
			}
		} else {
			BeaconAPI::ReplySuccess($projects);
		}
		break;
	case 'GET /project/{project_id}/versions/{version_id}':
		if (\BeaconCommon::IsUUID($project_id) === false) {
			BeaconAPI::ReplyError('Specify one project by UUID.', null, 400);
		}
		
		$projects = \BeaconAPI\Project::GetSharedDocumentByID($project_id, $user_id);
		if (is_null($projects) || count($projects) != 1) {
			BeaconAPI::ReplyError('Project not found', null, 404);
		}
		$project = $projects[0];
		
		$version_id = $context['path_parameters']['version_id'];
		HandleDocumentDataRequest($project, $version_id);
		break;
	}
}

function HandleDocumentDataRequest(\BeaconAPI\Project $project, $version_id = null) {
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
	
	$compressed = ($best_option == 'gzip');
	if ($compressed) {
		header('Content-Encoding: gzip');
	}
	try {
		$project->PreloadContent($version_id); // If there is an error, this one will fire the exception
		echo $project->Content($compressed, false, $version_id); // This one returns an empty string on error, but will call the preload if needed.
		header('Content-Type: application/octet-stream');
		header('Content-Disposition: attachment; filename="' . preg_replace('/[^a-z09\-_ \(\)]/i', '', $project->Title()) . '.beacon"');
		http_response_code(200);
	} catch (Exception $err) {
		http_response_code(500);
		header('Content-Type: application/json');
		echo json_encode(['message' => $err->getMessage(), 'error' => true, 'code' => $err->getCode()]);
	}
	exit;
}

?>