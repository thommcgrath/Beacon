<?php

BeaconAPI::Authorize();
	
function handle_request(array $context): void {
	$user_id = BeaconAPI::UserID();
	$type = null;
	if (isset($_GET['type']) && empty($_GET['type']) === false) {
		$type = $_GET['type'];
	}
	
	$authenticators = Authenticator::GetForUserID($user_id, $type);
	BeaconAPI::ReplySuccess($authenticators);
}

?>