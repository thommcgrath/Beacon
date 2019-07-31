<?php

// Anybody can GET information about any document without authorization. Other
// actions require authentication.

require(dirname(__FILE__) . '/loader.php');

$document_id = BeaconAPI::ObjectID();
$method = BeaconAPI::Method();
$database = BeaconCommon::Database();

switch ($method) {
case 'HEAD':
	header('Content-Type: application/json');
	
	if ($document_id !== null) {
		$results = $database->Query('SELECT document_id, user_id FROM documents WHERE document_id = $1;', $document_id);
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
	$user_id = BeaconAPI::UserID();
	
	if ($document_id === null) {
		// query documents
		$params = array();
		$clauses = array();
		if (isset($_GET['user_id'])) {
			$clauses[] = 'user_id = ::limit_user_id::';
			$params['limit_user_id'] = $_GET['user_id'];
		}
		if (isset($user_id)) {
			$clauses[] = '(user_id = ::current_user_id:: OR published = \'Approved\')';
			$params['current_user_id'] = $user_id;
		} else {
			$clauses[] = 'published = \'Approved\'';
		}
		$sql = 'SELECT ' . implode(', ', BeaconDocument::DatabaseColumns()) . ' FROM documents WHERE ' . implode(' AND ', $clauses);
		
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
		$documents = BeaconDocument::GetFromResults($results);
		BeaconAPI::ReplySuccess($documents);
	} else {
		$simple = isset($_GET['simple']);
		
		// specific document(s)
		$documents = BeaconDocument::GetByDocumentID($document_id);
		if (count($documents) === 0) {
			BeaconAPI::ReplyError('No document found', null, 404);
		}
		
		if (!$simple) {
			$database->BeginTransaction();
			$database->Query('UPDATE documents SET download_count = download_count + 1 WHERE document_id = ANY($1) AND user_id != $2;', '{' . $document_id . '}', BeaconAPI::UserID());
			$database->Commit();
		}
		
		if (BeaconAPI::ObjectCount() == 1) {
			if ($simple) {
				BeaconAPI::ReplySuccess($documents[0]);
			} else {
				header('Content-Type: application/octet-stream');
				header('Content-Disposition: attachment; filename="' . preg_replace('/[^a-z09\-_ \(\)]/i', '', $documents[0]->Name()) . '.beacon"');
				http_response_code(200);
				
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
				echo $documents[0]->Content($compressed, false);
				exit;
			}
		} else {
			BeaconAPI::ReplySuccess($documents);
		}
	}
	break;
case 'PUT':
case 'POST':
	BeaconAPI::Authorize();
	if (BeaconAPI::ContentType() !== 'application/json') {
		BeaconAPI::ReplyError('Send a JSON payload');
	}
	
	$payload = BeaconAPI::JSONPayload();
	if (BeaconCommon::IsAssoc($payload)) {
		// single
		$items = array($payload);
		$single_mode = true;
	} else {
		// multiple
		if ($document_id !== null) {
			BeaconAPI::ReplyError('Do not specify a class when saving multiple documents.');
		}
		$items = $payload;
		$single_mode = false;
	}
	
	$user_id = strtolower(BeaconAPI::UserID());
	$documents = array();
	$database->BeginTransaction();
	foreach ($items as $document) {
		if ($single_mode) {
			$this_document_id = $document_id;
		} else {
			$this_document_id = $document['Identifier'];
		}
		$reason = '';
		$saved = BeaconDocument::SaveFromContent($this_document_id, $user_id, $document, $reason, false);
		if ($saved === false) {
			$database->Rollback();
			BeaconAPI::ReplyError($reason, $document);
		}
		$documents[] = BeaconDocument::GetByDocumentID($this_document_id)[0];
	}
	$database->Commit();
	
	BeaconAPI::ReplySuccess($documents);
	
	break;
case 'DELETE':
	BeaconAPI::Authorize();
	if (($document_id === null) && (BeaconAPI::ContentType() === 'text/plain')) {
		$document_id = BeaconAPI::Body();
	}
	if (($document_id === null) || ($document_id === '')) {
		BeaconAPI::ReplyError('No document specified');
	}
	
	$paths = array();
	$results = $database->Query('SELECT user_id, document_id FROM documents WHERE document_id = ANY($1);', '{' . $document_id . '}');
	while (!$results->EOF()) {
		if ($results->Field('user_id') !== BeaconAPI::UserID()) {
			BeaconAPI::ReplyError('Document ' . $results->Field('document_id') . ' does not belong to you.');
		}
		$paths[] = BeaconDocument::GenerateCloudStoragePath($results->Field('user_id'), $results->Field('document_id'));
		$results->MoveNext();
	}
		
	$database->BeginTransaction();
	$database->Query('DELETE FROM documents WHERE document_id = ANY($1);', '{' . $document_id . '}');
	$database->Commit();
	
	foreach ($paths as $path) {
		BeaconCloudStorage::DeleteFile($path);
	}
	
	BeaconAPI::ReplySuccess();
	
	break;
}

?>