<?php

BeaconAPI::Authorize();
	
function handle_request(array $context): void {
	$user_id = BeaconAPI::UserID();
	if (strtolower($user_id) !== strtolower(BeaconAPI::UserID())) {
		BeaconAPI::ReplyError('Cannot delete another user.');
	}
	
	$user = BeaconAPI::User();
	if ($user->SetIsEnabled(false) && $user->Commit()) {
		BeaconAPI::ReplySuccess();
	} else {
		BeaconAPI::ReplyError('Could not disable user', BeaconAPI::UserID(), 400);
	}
}

?>