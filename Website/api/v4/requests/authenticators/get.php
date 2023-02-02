<?php

BeaconAPI::Authorize();
	
function handleRequest(array $context): APIResponse {
	$user_id = BeaconAPI::UserID();
	$authenticator_id = $context['pathParameters']['authenticator_id'];
	$authenticator = Authenticator::GetByAuthenticatorID($authenticator_id);
	if ($authenticator && $authenticator->UserID() === $user_id) {
		BeaconAPI::ReplySuccess($authenticator);
	} else {
		BeaconAPI::ReplyError('Authenticator not found', null, 404);
	}
}

?>