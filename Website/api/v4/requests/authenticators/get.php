<?php

BeaconAPI::Authorize();
	
function handle_request(array $context): void {
	$user_id = BeaconAPI::UserID();
	$authenticator_id = $context['path_parameters']['authenticator_id'];
	$authenticator = Authenticator::GetByAuthenticatorID($authenticator_id);
	if ($authenticator && $authenticator->UserID() === $user_id) {
		BeaconAPI::ReplySuccess($authenticator);
	} else {
		BeaconAPI::ReplyError('Authenticator not found', null, 404);
	}
}

?>