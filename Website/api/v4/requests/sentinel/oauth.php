<?php

BeaconAPI::Authorize();
	
function handleRequest(array $context): APIResponse {
	$user_id = BeaconAPI::UserID();
	$provider = $context['pathParameters']['provider'];
	
	$oauth = Sentinel\OAuth::Lookup($user_id, $provider);
	if ($oauth && $oauth->Test(true)) {
		\BeaconAPI::ReplySuccess($oauth);
	} else {
		\BeaconAPI::ReplyError('Token not found.', null, 404);
	}
}

?>
