<?php

require($_SERVER['DOCUMENT_ROOT'] . '/php/engine.php');

$method = strtoupper($_SERVER['REQUEST_METHOD']);
$document_id = document_id();

switch ($method) {
case 'GET':
	if ($document_id === null) {
		list_documents();
	} else {
		get_document($document_id);
	}
	break;
case 'POST':
	if (array_key_exists('userid', $_GET)) {
		$user_id = $_GET['userid'];
	} else {
		$user_id = null;
	}
	if (array_key_exists('pubkey', $_GET)) {
		$public_key = $_GET['pubkey'];
	} else {
		$public_key = null;
	}
	$signature = $_GET['signature'];
	$contents = file_get_contents('php://input');
	
	post_document($contents, $user_id, $public_key, $signature);
	
	break;
case 'DELETE':
	$signature = $_GET['signature'];
	delete_document($document_id, $signature);
	break;
case 'HEAD':
	get_document_status($document_id);
	break;
default:
	http_response_code(405);
	echo('Method not allowed');
	exit;
}

function post_document ($contents, $user_id, $public_key, $signature) {
	http_response_code(400); // So the response is correct for exceptions
	
	$document = json_decode($contents, true);
	if ($document === null) {
		echo('Invalid document: bad json.');
		return;
	}
	
	$mandatory_keys = array('Identifier', 'Title', 'Description');
	foreach ($mandatory_keys as $key) {
		if (array_key_exists($key, $document) === false) {
			echo('Invalid document: no ' . strtolower($key) . ' included.');
			return;
		}
	}
	
	$document_id = $document['Identifier'];
	$title = $document['Title'];
	$description = $document['Description'];
	
	$database = ConnectionManager::BeaconDatabase();
	$results = $database->Query("SELECT users.public_key FROM users INNER JOIN documents ON (documents.user_id = users.user_id) WHERE documents.document_id = $1;", array($document_id));
	if ($results->RecordCount() == 1) {
		// Existing document
		$public_key = $results->Field('public_key');
		$new_document = false;
	} else {
		// New document
		if ($user_id === null) {
			echo('Must supply user id for new documents.');
			return;
		}
		
		$results = $database->Query("SELECT public_key FROM users WHERE user_id = $1;", array($user_id));
		if ($results->RecordCount() == 1) {
			// Existing user
			$public_key = $results->Field('public_key');
		} else {
			// New user
			if ($user_id === null) {
				echo('Must supply public key for new users.');
				return;
			}
			
			if (substr($public_key, 0, 26) == '-----BEGIN PUBLIC KEY-----') {
				// Ready for use
			} else {
				// Needs conversion
				$public_key = hex2bin($public_key);
				$public_key = trim(chunk_split(base64_encode($public_key), 64, "\n"));
				$public_key = "-----BEGIN PUBLIC KEY-----\n$public_key\n-----END PUBLIC KEY-----";
			}
			
			$database->BeginTransaction();
			$database->Query("INSERT INTO users (user_id, public_key) VALUES ($1, $2);", array($user_id, $public_key));
			$database->Commit();
		}
		
		$new_document = true;
	}
	
	// Verify the signature matches the content and public key
	$verified = openssl_verify($contents, hex2bin($signature), $public_key);
	if ($verified !== 1) {
		echo('Document signature does not match user public key.');
		return;
	}
	
	// Create or update the document as necessary
	$hash = md5($contents);
	if ($new_document) {
		$database->BeginTransaction();
		$database->Query("INSERT INTO documents (document_id, user_id, title, description, contents, contents_hash) VALUES ($1, $2, $3, $4, $5, $6);", array($document_id, $user_id, trim($title), trim($description), $contents, $hash));
		$database->Commit();
	} else {
		$database->BeginTransaction();
		$database->Query("UPDATE documents SET title = $2, description = $3, revision = revision + 1, contents = $4, contents_hash = $5, last_update = CURRENT_TIMESTAMP(0) WHERE document_id = $1;", array($document_id, trim($title), trim($description), $contents, $hash));
		$database->Commit();
	}
	
	$url = document_url($document_id);
	http_response_code(200);
	echo $url;
}

function list_documents () {
	$database = ConnectionManager::BeaconDatabase();
	$results = $database->Query("SELECT document_id, title, description, last_update, revision, download_count, contents_hash FROM documents;");
	$response = array();
	while (!$results->EOF()) {
		$document = array(
			'id' => $results->Field('document_id'),
			'title' => $results->Field('title'),
			'description' => $results->Field('description'),
			'last_update' => $results->Field('last_update'),
			'revision' => $results->Field('revision'),
			'download_count' => $results->Field('download_count'),
			'hash' => $results->Field('contents_hash'),
			'url' => document_url($results->Field('document_id'))
		);
		$response[] = $document;
		$results->MoveNext();
	}
	echo(json_encode($response, JSON_PRETTY_PRINT));
}

function get_document ($document_id) {
	http_response_code(404);
	
	$database = ConnectionManager::BeaconDatabase();
	$results = $database->Query("SELECT documents.contents_hash, users.user_id, documents.last_update AT TIME ZONE 'UTC' AS last_update, documents.contents, documents.title FROM documents INNER JOIN users ON (documents.user_id = users.user_id) WHERE documents.document_id = $1;", array($document_id));
	if ($results->RecordCount() == 0) {
		echo('File not found');
		return;
	}
	
	$database->BeginTransaction();
	$database->Query("UPDATE documents SET download_count = download_count + 1 WHERE document_id = $1;", array($document_id));
	$database->Commit();
	
	http_response_code(200);
	header('X-Beacon-MD5: ' . $results->Field('contents_hash'));
	header('X-Beacon-UserID: ' . $results->Field('user_id'));
	header('X-Beacon-Date: ' . $results->Field('last_update'));
	header('Content-Type: application/octet-stream');
	header('Content-Disposition: attachment; filename="' . $results->Field('title') . '.beacon"');
	echo($results->Field('contents'));
}

function get_document_status ($document_id) {
	http_response_code(404);
	
	$database = ConnectionManager::BeaconDatabase();
	$results = $database->Query("SELECT documents.contents_hash, users.user_id, documents.last_update AT TIME ZONE 'UTC' AS last_update FROM documents INNER JOIN users ON (documents.user_id = users.user_id) WHERE documents.document_id = $1;", array($document_id));
	if ($results->RecordCount() == 0) {
		echo('File not found');
		return;
	}
	
	http_response_code(200);
	header('X-Beacon-MD5: ' . $results->Field('contents_hash'));
	header('X-Beacon-UserID: ' . $results->Field('user_id'));
	header('X-Beacon-Date: ' . $results->Field('last_update'));
}

function delete_document ($document_id, $signature) {
	http_response_code(400);
	
	$database = ConnectionManager::BeaconDatabase();
	$results = $database->Query("SELECT users.public_key FROM users INNER JOIN documents ON (documents.user_id = users.user_id) WHERE documents.document_id = $1;", array($document_id));
	if ($results->RecordCount() != 1) {
		http_response_code(401);
		return;
	}
	
	$public_key = $results->Field('public_key');
	
	$verified = openssl_verify($document_id, hex2bin($signature), $public_key);
	if ($verified !== 1) {
		echo('Incorrect signature');
		return;
	}
	
	$database->BeginTransaction();
	$database->Query("DELETE FROM documents WHERE document_id = $1;", array($document_id));
	$database->Commit();
	
	http_response_code(200);
}

function document_id () {
	$request = explode('/', trim($_SERVER['PATH_INFO'],'/'));
	if ((is_array($request) === false) || (count($request) == 0)) {
		return null;
	}
	
	$document_id = $request[0];
	if (preg_match('/^[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$/i', $document_id) != 1) {
		return null;
	}
	
	return $document_id;
}

function document_url ($document_id) {
	return 'https://thezaz.com/beacon/documents.php/' . strtolower($document_id);
}

?>