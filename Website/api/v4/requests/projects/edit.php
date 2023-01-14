<?php

http_response_code(500); // So that a memory error doesn't report 200
BeaconAPI::Authorize();
	
function handle_request(array $context): void {
	$project_id = $context['path_parameters']['project_id'];
	
	if (BeaconCommon::IsUUID($project_id) === false) {
		BeaconAPI::ReplyError('Specify exactly one UUID to save a document.', null, 400);
	}
	
	$user = BeaconAPI::User();
	$content_type = BeaconAPI::ContentType();
	switch ($content_type) {
	case 'multipart/form-data':
		if (isset($_POST['game_id']) === false) {
			BeaconAPI::ReplyError('Must include game_id variable.');
		}
		
		$game_id = $_POST['game_id'];
		switch ($game_id) {
		case 'Ark':
			$class_name = '\Ark\Project';
			break;
		default:
			BeaconAPI::ReplyError('Unknown game ' . $game_id);
		}
		
		$reason = '';
		if ($class_name::SaveFromMultipart($user, $reason) === false) {
			BeaconAPI::ReplyError($reason);
		}
		break;
	default:
		BeaconAPI::ReplyError('Content-Type must be multipart/form-data.');
		break;
	}
	
	BeaconAPI::ReplySuccess();
}

?>