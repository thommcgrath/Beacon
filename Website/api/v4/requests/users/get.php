<?php

use BeaconAPI\v4\{Core, User, APIResponse};
Core::Authorize(Core::kAuthFlagOptional);

function handle_request(array $context): APIResponse {
	$identifier = $context['path_parameters']['userId'];
	$user = User::Fetch($identifier);
	if (is_null($user)) {
		return APIResponse::NewJSONError('User not found', $identifier, 404);
	}
	
	if (Core::Authenticated() && $user->UserId() === Core::UserId()) {
		$user_info = $user;
	} else {
		// don't use the regular method that includes lots of values
		$user_info = [
			'user_id' => $user->UserId(),
			'username_full' => $user->Username(true),
			'public_key' => $user->PublicKey()
		];
	}
	
	return APIResponse::NewJSON($user_info, 200);
}
