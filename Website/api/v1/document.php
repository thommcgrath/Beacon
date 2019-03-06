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
		$sql = 'SELECT ' . implode(', ', BeaconDocumentMetadata::DatabaseColumns()) . ' FROM documents WHERE ' . implode(' AND ', $clauses);
		
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
		$documents = BeaconDocumentMetadata::GetFromResults($results);
		BeaconAPI::ReplySuccess($documents);
	} else {
		$simple = isset($_GET['simple']);
		
		// specific document(s)
		if ($simple) {
			$documents = BeaconDocumentMetadata::GetByDocumentID($document_id);
		} else {
			$documents = BeaconDocument::GetByDocumentID($document_id);
		}
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
				
				if ($best_option == 'gzip') {
					echo gzencode(json_encode($documents[0]));
				} else {
					echo json_encode($documents[0], JSON_PRETTY_PRINT);
				}
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
	
	$documents = array();
	$database->BeginTransaction();
	foreach ($items as $document) {
		if (!BeaconCommon::HasAllKeys($document, 'Version', 'Identifier')) {
			$database->Rollback();
			BeaconAPI::ReplyError('Not all keys are present.', $document);
		}
		if ($single_mode && is_null(BeaconAPI::ObjectID()) == false && strtolower($document['Identifier']) !== strtolower(BeaconAPI::ObjectID())) {
			$database->Rollback();
			BeaconAPI::ReplyError('Document UUID of ' . strtolower($document['Identifier']) . ' in content does not match the resource UUID of ' . strtolower(BeaconAPI::ObjectID()) . '.');
		}
		
		$document_version = intval($document['Version']);
		if ($document_version < 2) {
			$database->Rollback();
			BeaconAPI::ReplyError('Version 1 documents are no longer not accepted.');
		}
		
		$document_id = $document['Identifier'];
		$contents = json_encode($document);
		
		// make sure this document is either new or owner by the server
		try {
			$results = $database->Query('SELECT user_id FROM documents WHERE document_id = $1;', $document_id);
			if ($results->RecordCount() == 1) {
				if (strtolower($results->Field('user_id')) !== strtolower(BeaconAPI::UserID())) {
					$database->Rollback();
					BeaconAPI::ReplyError('Document ' . $document_id . ' does not belong to you.');
				}
				
				$database->Query('UPDATE documents SET contents = $2 WHERE document_id = $1;', $document_id, $contents);
			} else {
				$database->Query('INSERT INTO documents (user_id, contents) VALUES ($1, $2);', BeaconAPI::UserID(), $contents);
			}
		} catch (Exception $e) {
			$database->Rollback();
			
			$reason = $e->getMessage();
			$user_id = BeaconAPI::UserID();
			$user = BeaconUser::GetByUserID($user_id);
			if (is_null($user)) {
				$username = $user_id;
			} else {
				$username = $user->Username() . '#' . $user->Suffix();
			}
			
			$comment = "User $username had trouble saving this document: $reason";
			$compressed = gzencode($contents, 9);
			
			$database->BeginTransaction();
			$results = $database->Query('INSERT INTO corrupt_files (contents) VALUES ($1) RETURNING file_id;', '\x' . bin2hex($compressed));
			$database->Commit();
			$file_id = $results->Field('file_id');
			$url = BeaconCommon::AbsoluteURL('/corruptfile.php?file_id=' . urlencode($file_id));
			
			BeaconCommon::PostSlackMessage("User $username had trouble saving a document: $reason\n\nDownload the file: $url");
			
			BeaconAPI::ReplyError('There was a database error while saving the document.');
		}
		
		// see if a publish request is needed
		$results = $database->Query('SELECT published FROM documents WHERE document_id = $1;', $document_id);
		$current_status = $results->Field('published');
		$new_status = $current_status;
		if ($document_version >= 3) {
			if (isset($document['Configs']['Metadata'])) {
				$metadata = $document['Configs']['Metadata'];
				$wants_publish = BeaconCommon::HasAllKeys($metadata, 'Description', 'Title', 'Public') && boolval($metadata['Public']) == true;
				$document_title = $metadata['Title'];
				$document_description = $metadata['Description'];
			} else {
				$wants_publish = false;
			}
		} else {
			$wants_publish = BeaconCommon::HasAllKeys($document, 'Description', 'Title', 'Public') && boolval($document['Public']) == true;
			$document_title = $document['Title'];
			$document_description = $document['Description'];
		}
		if ($wants_publish) {
			if ($current_status == BeaconDocumentMetadata::PUBLISH_STATUS_APPROVED_PRIVATE) {
				$new_status = BeaconDocumentMetadata::PUBLISH_STATUS_APPROVED;
			} elseif ($current_status == BeaconDocumentMetadata::PUBLISH_STATUS_PRIVATE) {
				$new_status = BeaconDocumentMetadata::PUBLISH_STATUS_REQUESTED;
				
				$obj = array(
					'text' => 'Request to publish document',
					'attachments' => array(
						array(
							'title' => $document_title,
							'text' => $document_description,
							'fallback' => 'Unable to show response buttons.',
							'callback_id' => 'publish_document:' . $document_id,
							'actions' => array(
								array(
									'name' => 'status',
									'text' => 'Approve',
									'type' => 'button',
									'value' => BeaconDocumentMetadata::PUBLISH_STATUS_APPROVED,
									'confirm' => array(
										'text' => 'Are you sure you want to approve this document?',
										'ok_text' => 'Approve'
									)
								),
								array(
									'name' => 'status',
									'text' => 'Deny',
									'type' => 'button',
									'value' => BeaconDocumentMetadata::PUBLISH_STATUS_DENIED,
									'confirm' => array(
										'text' => 'Are you sure you want to reject this document?',
										'ok_text' => 'Deny'
									)
								)
							)
						)
					)
				);
				BeaconCommon::PostSlackRaw(json_encode($obj));	
			}
		} else {
			if ($current_status == BeaconDocumentMetadata::PUBLISH_STATUS_APPROVED) {
				$new_status = BeaconDocumentMetadata::PUBLISH_STATUS_APPROVED_PRIVATE;
			} elseif ($current_status == BeaconDocumentMetadata::PUBLISH_STATUS_REQUESTED) {
				$new_status = BeaconDocumentMetadata::PUBLISH_STATUS_PRIVATE;
			}
		}
		if ($new_status != $current_status) {
			$database->Query('UPDATE documents SET published = $2 WHERE document_id = $1;', $document_id, $new_status);
		}
		
		$documents[] = BeaconDocumentMetadata::GetByDocumentID($document_id)[0];
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