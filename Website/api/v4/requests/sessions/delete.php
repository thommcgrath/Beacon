<?php

use BeaconAPI\v4\{Response, Core, Session};
	
function handleRequest(array $context): Response {
	$user_id = Core::UserId();
	$sessionId = $context['pathParameters']['sessionId'];
	$session = Session::Fetch($sessionId);
	if (is_null($session) || ($session->UserId() !== $user_id) || $session->User()->CanSignIn() === false) {
		return Response::NewJsonError('Session not found', ['code' => 'NOT_FOUND'], 404);
	}
	$session->Delete();
	return Response::NewNoContent();
}

?>