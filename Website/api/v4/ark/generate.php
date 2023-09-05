<?php

require(dirname(__FILE__, 2) . '/loader.php');

$document_id = BeaconAPI::ObjectID();
$method = BeaconAPI::Method();
$database = BeaconCommon::Database();
BeaconAPI::Authorize(true);

if (is_null($document_id) || BeaconCommon::IsUUID($document_id) === false) {
	BeaconAPI::ReplyError('Request a specific document', null, 400);
}

$documents = Ark\Document::GetByDocumentID($document_id);
if (count($documents) != 1) {
	BeaconAPI::ReplyError('Document not found', null, 404);
}

$document = $documents[0];
if ($document->IsPublic() == false && $document->UserID() != BeaconAPI::UserID()) {
	header('WWW-Authenticate: Basic realm="Beacon API"');
	BeaconAPI::ReplyError('Unauthorized', null, 401);
}

$generator = new Ark\Generator($document);
if (array_key_exists('quality_scale', $_REQUEST)) {
	$generator->SetQualityScale(floatval($_REQUEST['quality_scale']));
}
if (array_key_exists('difficulty_value', $_REQUEST)) {
	$generator->SetDifficultyValue(floatval($_REQUEST['difficulty_value']));
}
if (array_key_exists('map_mask', $_REQUEST)) {
	$generator->SetMapMask(intval($_REQUEST['map_mask']));
}

$original_ini = '';
switch ($method) {
case 'POST':
	if (BeaconAPI::ContentType() === 'application/x-www-form-urlencoded' || BeaconAPI::ContentType() === 'multipart/form-data') {
		if (array_key_exists('content', $_POST)) {
			$original_ini = $_POST['content'];
		}
	} else {
		$original_ini = BeaconAPI::Body();
	}
	break;
}

$output = $generator->Generate($original_ini);

http_response_code(200);
header('Content-Type: text/plain');
header('Content-MD5: ' . md5($output));
ob_clean();
echo $output;

?>