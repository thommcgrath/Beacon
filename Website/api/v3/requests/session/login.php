<?php

BeaconAPI::Authorize();
	
function handle_request(array $context): void {
	$user = BeaconAPI::User();
	if (is_null($user) || $user->CanSignIn() === false) {
		BeaconAPI::ReplyError('Invalid user', null, 400);
	}
	
	$session = BeaconSession::Create($user->UserID());
	BeaconAPI::ReplySuccess($session);
}

?>