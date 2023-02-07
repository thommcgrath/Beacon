<?php

use BeaconAPI\v4\{Response, Core, Session};
	
function handleRequest(array $context): Response {
	$user_id = Core::UserId();
	$session_id = $context['pathParameters']['sessionId'];
	$session = Session::Fetch($session_id);
	if (($session === null) || ($session->UserId() !== $user_id) || $session->User()->CanSignIn() === false) {
		return Response::NewJsonError('Session not found', ['code' => 'NOT_FOUND'], 404);
	}
	$session->Delete();
	return Response::NewNoContent();
}

?>