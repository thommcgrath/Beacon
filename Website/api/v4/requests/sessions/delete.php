<?php

use BeaconAPI\v4\{APIResponse, Core, Session};

Core::Authorize();
	
function handle_request(array $context): APIResponse {
	$user_id = Core::UserId();
	$session_id = $context['path_parameters']['sessionId'];
	$session = Session::Fetch($session_id);
	if (($session === null) || ($session->UserId() !== $user_id) || $session->User()->CanSignIn() === false) {
		return APIResponse::NewJSONError('Session not found', ['code' => 'NOT_FOUND'], 404);
	}
	$session->Delete();
	return APIResponse::NewNoContent();
}

?>