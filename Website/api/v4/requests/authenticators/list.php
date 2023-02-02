<?php

BeaconAPI::Authorize();
	
function handleRequest(array $context): APIResponse {
	$user_id = BeaconAPI::UserID();
	$type = null;
	if (isset($_GET['type']) && empty($_GET['type']) === false) {
		$type = $_GET['type'];
	}
	
	$authenticators = Authenticator::GetForUserID($user_id, $type);
	BeaconAPI::ReplySuccess($authenticators);
}

?>