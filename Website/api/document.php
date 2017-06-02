<?php

// Anybody can GET information about any document without authorization. Other
// actions require authentication.

require($_SERVER['DOCUMENT_ROOT'] . '/php/engine.php');

$document_id = BeaconAPI::ObjectID();
$method = BeaconAPI::Method();
$database = ConnectionManager::BeaconDatabase();

switch ($method) {
case 'GET':
	if ($document_id === null) {
		// query documents
		$params = array();
		$sql = 'SELECT ' . implode(', ', BeaconDocumentMetadata::DatabaseColumns()) . ' FROM documents';
		if (isset($_GET['user_id'])) {
			$sql .= ' WHERE user_id = ::user_id::';
			$params['user_id'] = $_GET['user_id'];
		}
		
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
			$sort_direction = ($_GET['direction'] === 'desc' ? 'DESC' : 'ASC');
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
		$documents = BeaconDocumentMetadata::GetFromResults($results);
		BeaconAPI::ReplySuccess($documents);
	} else {
		// specific document(s)
		$documents = BeaconDocument::GetByDocumentID($document_id);
		if (count($documents) === 0) {
			BeaconAPI::ReplyError('No document found', null, 404);
		}
		
		$database->BeginTransaction();
		$database->Query('UPDATE documents SET download_count = download_count + 1 WHERE document_id = ANY($1);', '{' . $document_id . '}');
		$database->Commit();
		
		if (BeaconAPI::ObjectCount() == 1) {
			BeaconAPI::ReplySuccess($documents[0]);
		} else {
			BeaconAPI::ReplySuccess($documents);
		}
	}
	break;
case 'PUT':
case 'POST':
	BeaconAPI::Authorize();
	if ($document_id !== null) {
		BeaconAPI::ReplyError('Do not specify a class when saving documents.');
	}
	
	if (BeaconAPI::ContentType() !== 'application/json') {
		BeaconAPI::ReplyError('Send a JSON payload');
	}
	
	$payload = BeaconAPI::JSONPayload();
	if (ZirconCommon::IsAssoc($payload)) {
		// single
		$items = array($payload);
	} else {
		// multiple
		$items = $payload;
	}
	
	$database->BeginTransaction();
	foreach ($items as $document) {
		if (!ZirconCommon::HasAllKeys($document, 'Description', 'Identifier', 'Title', 'LootSources')) {
			$database->Rollback();
			BeaconAPI::ReplyError('Not all keys are present.', $document);
		}
		
		$document_id = $document['Identifier'];
		$description = $document['Description'];
		$title = $document['Title'];
		
		// make sure this document is either new or owner by the server
		$results = $database->Query('SELECT user_id FROM documents WHERE document_id = $1;', $document_id);
		if ($results->RecordCount() == 1 && $results->Field('user_id') !== BeaconAPI::UserID()) {
			BeaconAPI::ReplyError('Document ' . $document_id . ' does not belong to you.');
		}
		
		// insert
		$contents = json_encode($document);
		$hash = md5($contents);
		$database->Query('INSERT INTO documents (document_id, user_id, title, description, contents, contents_hash) VALUES ($1, $2, $3, $4, $5, $6) ON CONFLICT (document_id) DO UPDATE title = $3, description = $4, contents = $5, contents_hash = $6, revision = revision + 1, last_update = CURRENT_TIMESTAMP(0);', $document_id, BeaconAPI::UserID(), $title, $description, $contents, $hash);
	}
	$database->Commit();
	
	BeaconAPI::ReplySuccess();
	
	break;
case 'DELETE':
	BeaconAPI::Authorize();
	if ($engram_class === null) {
		BeaconAPI::ReplyError('No document specified');
	}
	
	$results = $database->Query('SELECT user_id, document_id FROM documents WHERE document_id = ANY($1);', '{' . $document_id . '}');
	while (!$results->EOF()) {
		if ($results->Field('user_id') !== BeaconAPI::UserID()) {
			BeaconAPI::ReplyError('Document ' . $results->Field('document_id') . ' does not belong to you.');
		}
		$results->MoveNext();
	}
		
	$database->BeginTransaction();
	$database->Query('DELETE FROM documents WHERE document_id = ANY($1);', '{' . $document_id . '}');
	$database->Commit();
	
	BeaconAPI::ReplySuccess();
	
	break;
}

?>