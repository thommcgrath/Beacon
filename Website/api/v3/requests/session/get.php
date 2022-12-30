<?php

BeaconAPI::Authorize();
	
function handle_request(array $context): void {
	$user_id = BeaconAPI::UserID();
	$session_id = $context['path_parameters']['session_id'];
	$session = BeaconSession::GetBySessionID($session_id);
	if (($session === null) || ($session->UserID() !== $user_id) || $session->User()->CanSignIn() === false) {
		BeaconAPI::ReplyError('Session not found', ['code' => 'NOT_FOUND'], 404);
	}
	
	BeaconAPI::ReplySuccess($session);
}

?>