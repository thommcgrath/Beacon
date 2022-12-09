<?php

BeaconAPI::Authorize();
	
function handle_request(array $context): void {
	$user_id = BeaconAPI::UserID();
	$provider = $context['path_parameters']['provider'];
	
	$oauth = Sentinel\OAuth::Lookup($user_id, $provider);
	if ($oauth && $oauth->Test(true)) {
		\BeaconAPI::ReplySuccess($oauth);
	} else {
		\BeaconAPI::ReplyError('Token not found.', null, 404);
	}
}

?>
