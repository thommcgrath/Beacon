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
	$results = $database->Query('UPDATE public.projects SET published = $2 WHERE project_id = $1 RETURNING title;', $document_id, $new_status);
	$title = $results->Field('title');
	$database->Commit();

	echo json_encode(array('text' => 'Request to publish document `' . $title . '` has been ' . $new_status . '.'));
	BeaconPusher::SharedInstance()->TriggerEvent(channelName: BeaconPusher::PrivateProjectChannelName($document_id), eventName: 'publishStatusUpdated', eventBody: $new_status);

	break;
case 'sentinel_script':
	if (is_null($callback_value)) {
		ReplyError('No hash provided');
	}
	if (!isset($buttons['status'])) {
		ReplyError('No status button provided');
	}

	$revisionId = $callback_value;
	$newStatus = $buttons['status'];

	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	$results = $database->Query('UPDATE sentinel.script_revisions SET approval_status = $2 WHERE script_revision_id = $1;', $revisionId, $newStatus);
	$database->Commit();

	echo json_encode(['text' => 'The script has been ' . strtolower($newStatus) . '.']);

	break;
default:
	ReplyError('I don\'t know what to do with this callback id');
	break;
}

?>
