<?php

$actions = $payload['actions'];
$buttons = array();
foreach ($actions as $action) {
	switch (strtolower($action['type'])) {
	case 'button':
		$button_name = $action['name'];
		$button_value = $action['value'];
		$buttons[$button_name] = $button_value;
		break;
	}
}

switch ($callback_id) {
case 'publish_document':
	if (is_null($callback_value)) {
		ReplyError('No Document ID provided');
	}
	if (!BeaconCommon::IsUUID($callback_value)) {
		ReplyError('Document ID is not a UUID');
	}
	if (!isset($buttons['status'])) {
		ReplyError('No status button provided');
	}
	
	$document_id = $callback_value;
	$new_status = $buttons['status'];
	
	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	$database->Query('UPDATE ark.projects SET published = $2 WHERE document_id = $1;', $document_id, $new_status);
	$results = $database->Query('SELECT title FROM ark.projects WHERE document_id = $1;', $document_id);
	$title = $results->Field('title');
	$database->Commit();
	
	echo json_encode(array('text' => 'Request to publish document `' . $title . '` has been ' . $new_status . '.'));
	
	break;
default:
	ReplyError('I don\'t know what to do with this callback id');
	break;
}

?>