<?php

// Anybody can GET information about any document without authorization. Other
// actions require authentication.

require(dirname(__FILE__) . '/loader.php');

$project_id = BeaconAPI::ObjectID();
$method = BeaconAPI::Method();
$database = BeaconCommon::Database();
$user_id = null;

$subobject = BeaconAPI::ObjectID(1);
if (is_null($subobject) == false) {
	if (!BeaconCommon::IsUUID($project_id)) {
		BeaconAPI::ReplyError('Must use a v4 UUID', null, 400);
	}
	
	BeaconAPI::Authorize(true);
	
	$project = \Ark\Document::GetSharedDocumentByID($project_id, BeaconAPI::UserID());
	if (is_null($project) || count($project) != 1) {
		BeaconAPI::ReplyError('Document not found', null, 404);
	}
	$project = $project[0];
	
	$subject = strtolower($subobject);
	switch ($subobject) {
	case 'publish':
		switch ($method) {
		case 'GET':
			BeaconAPI::ReplySuccess(array('document_id' => $project_id, 'status' => $project->PublishStatus()));
			break;
		case 'POST':
		case 'PUT':
			if ($project->UserID() != BeaconAPI::UserID()) {
				BeaconAPI::ReplyError('Not authorized', null, 403);
			}
			
			$payload = BeaconAPI::JSONPayload();
			$desired_status = $payload['status'];
			$project->SetPublishStatus($desired_status);
			BeaconAPI::ReplySuccess(array('document_id' => $project_id, 'status' => $project->PublishStatus()));
			
			break;
		default:
			BeaconAPI::ReplyError('Method not allowed', null, 405);
			break;
		}
		break;
	default:
		BeaconAPI::ReplyError('Action not found', null, 404);
		break;
	}
	exit;
}

switch ($method) {
case 'HEAD':
	header('Content-Type: application/json');
	
	if ($project_id !== null) {
		$results = $database->Query('SELECT project_id, user_id FROM ' . Ark\Project::SchemaName() . '.' . Ark\Project::SchemaName() . '.' . Ark\Project::AllowedTableName() . ' WHERE project_id = $1 AND deleted = FALSE;', $project_id);
		if ($results->RecordCount() == 1) {
			http_response_code(200);
		} else {
			http_response_code(404);
		}
	} else {
		http_response_code(405);
	}
	
	break;
case 'GET':
	BeaconAPI::Authorize(true);
	if (BeaconAPI::Authenticated()) {
		$user_id = BeaconAPI::UserID();
	}
	
	if ($project_id === null) {
		// query documents
		$params = array();
		$clauses = array();
		if (isset($_GET['user_id'])) {
			$clauses[] = 'user_id = ::limit_user_id::';
			$params['limit_user_id'] = $_GET['user_id'];
		}
		if (isset($user_id)) {
			$clauses[] = '(user_id = ::current_user_id:: OR (published = \'Approved\' AND role = \'Owner\'))';
			$params['current_user_id'] = $user_id;
		} else {
			$clauses[] = 'published = \'Approved\' AND role = \'Owner\'';
		}
		$sql = 'SELECT ' . implode(', ', \Ark\Document::DatabaseColumns()) . ' FROM ' . Ark\Project::SchemaName() . '.' . Ark\Project::AllowedTableName() . ' WHERE ' . implode(' AND ', $clauses);
		
		$sort_column = 'last_update';
		$sort_direction = 'DESC';
		if (isset($_GET['sort'])) {
			switch ($_GET['sort']) {
			case 'download_count':
				$sort_column = 'download_count';
				break;
			}
		}
		if (isset($_GET['direction'])) {
			$sort_direction = (strtolower($_GET['direction']) === 'desc' ? 'DESC' : 'ASC');
		}
		$sql .= ' ORDER BY ' . $sort_column . ' ' . $sort_direction;
			
		if (isset($_GET['count'])) {
			$sql .= ' LIMIT ::limit::';
			$params['limit'] = $_GET['count'];
		}
		if (isset($_GET['offset'])) {
			$sql .= ' OFFSET ::offset::';
			$params['offset'] = $_GET['offset'];
		}
		$keys = array_keys($params);
		$values = array_values($params);
		for ($i = 0; $i < count($keys); $i++) {
			$sql = str_replace('::' . $keys[$i] . '::', '$' . ($i + 1), $sql);
		}
		
		$results = $database->Query($sql, $values);
		$projects = \Ark\Document::GetFromResults($results);
		BeaconAPI::ReplySuccess($projects);
	} else {
		$simple = isset($_GET['simple']);
		
		// specific document(s)
		$projects = \Ark\Document::GetSharedDocumentByID($project_id, $user_id);
		if (count($projects) === 0) {
			BeaconAPI::ReplyError('No document found', null, 404);
		} elseif (count($projects) > 1) {
			$simple = true;
		}
		
		if ($simple === false) {
			$database->BeginTransaction();
			if (is_null($user_id)) {
				$database->Query('UPDATE ' . Ark\Project::SchemaName() . '.' . Ark\Project::SchemaName() . '.' . Ark\Project::AllowedTableName() . ' SET download_count = download_count + 1 WHERE project_id = ANY($1);', '{' . $project_id . '}');
			} else {
				foreach ($projects as $project) {
					if ($project->UserID() !== $user_id) {
						$database->Query('UPDATE ' . Ark\Project::SchemaName() . '.' . Ark\Project::SchemaName() . '.' . Ark\Project::AllowedTableName() . ' SET download_count = download_count + 1 WHERE project_id = $1;', $project->ProjectID());
					}
				}
			}
			$database->Commit();
		}
		
		if (BeaconAPI::ObjectCount() == 1) {
			if ($simple) {
				BeaconAPI::ReplySuccess($projects[0]);
			} else {
				$best_option = '*';
				$accept = isset($_SERVER['HTTP_ACCEPT_ENCODING']) ? strtolower(trim($_SERVER['HTTP_ACCEPT_ENCODING'])) : '';
				if ($accept !== '') {
					$pieces = explode(',', $accept);
					$best_quality = 0;
					$supported = array('gzip', '*');
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
					$projects[0]->PreloadContent(); // If there is an error, this one will fire the exception
					echo $projects[0]->Content($compressed, false); // This one returns an empty string on error, but will call the preload if needed.
					header('Content-Type: application/octet-stream');
					header('Content-Disposition: attachment; filename="' . preg_replace('/[^a-z09\-_ \(\)]/i', '', $projects[0]->Name()) . '.beacon"');
					http_response_code(200);
				} catch (Exception $err) {
					http_response_code(500);
					header('Content-Type: application/json');
					echo json_encode(['message' => $err->getMessage(), 'error' => true, 'code' => $err->getCode()]);
				}
				exit;
			}
		} else {
			BeaconAPI::ReplySuccess($projects);
		}
	}
	break;
case 'PUT':
case 'POST':
	BeaconAPI::Authorize();
	if (BeaconAPI::ContentType() !== 'application/json') {
		BeaconAPI::ReplyError('Send a JSON payload');
	}
	
	/* 2021-03-11: Had to force this to save one file at a time, no longer
		and it no longer returns the saved document. This was done because
		php JSON is very memory intensive, and Beacon projects have become
		complex enough that limits were being hit. */
		
	if (BeaconCommon::IsUUID($project_id) === false) {
		BeaconAPI::ReplyError('Specify exactly one UUID to save a document.');
	}
	
	$file_content = BeaconAPI::Body();
	$user = BeaconAPI::User();
	$reason = '';
	if (\Ark\Document::SaveFromContent($project_id, $user, $file_content, $reason) === false) {
		BeaconAPI::ReplyError($reason);
	}
	
	BeaconAPI::ReplySuccess();
	
	break;
case 'DELETE':
	BeaconAPI::Authorize();
	if (($project_id === null) && (BeaconAPI::ContentType() === 'text/plain')) {
		$project_id = BeaconAPI::Body();
	}
	if (($project_id === null) || ($project_id === '')) {
		BeaconAPI::ReplyError('No document specified');
	}
	
	$paths = array();
	$user_id = BeaconAPI::UserID();
	$success = false;
	$results = $database->Query('SELECT project_id, role FROM ' . Ark\Project::SchemaName() . '.' . Ark\Project::AllowedTableName() . ' WHERE project_id = ANY($1) AND user_id = $2;', '{' . $project_id . '}', $user_id);
	while (!$results->EOF()) {
		try {
			$project_id = $results->Field('project_id');
			$role = $results->Field('role');
			
			// When a file is deleted, if it is shared with another user, ownership transfers to another user. Which user
			// is not particularly important.
			if ($role === 'Owner' || $role === 'Team') {
				$database->BeginTransaction();
				$guest_results = $database->Query('SELECT user_id FROM ' . Ark\Project::SchemaName() . '.' . Ark\Project::GuestTableName() . ' WHERE project_id = $1;', $project_id);
				if ($guest_results->RecordCount() == 0) {
					$database->Query('UPDATE ' . Ark\Project::SchemaName() . '.' . Ark\Project::SchemaName() . '.' . Ark\Project::AllowedTableName() . ' SET deleted = TRUE WHERE project_id = $1;', $project_id);
				} else {
					$guest_user_id = $guest_results->Field('user_id');
					$database->Query('UPDATE ' . Ark\Project::SchemaName() . '.' . Ark\Project::SchemaName() . '.' . Ark\Project::AllowedTableName() . ' SET user_id = $1 WHERE project_id = $2;', $guest_user_id, $project_id);
					$database->Query('DELETE FROM ' . Ark\Project::SchemaName() . '.' . Ark\Project::GuestTableName() . ' WHERE project_id = $2 AND user_id = $1;', $guest_user_id, $project_id);
				}
				$database->Commit();
				$success = true;
			}
		} catch (Exception $e) {
		}
		
		$results->MoveNext();
	}
	
	if ($success) {
		BeaconAPI::ReplySuccess();
	} else {
		BeaconAPI::ReplyError('No document was deleted.');
	}
	
	break;
}

?>