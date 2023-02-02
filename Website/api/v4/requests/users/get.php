<?php

use BeaconAPI\v4\{Core, User, APIResponse};
Core::Authorize('user:read');

function handleRequest(array $context): APIResponse {
	$identifier = $context['pathParameters']['userId'];
	$user = User::Fetch($identifier);
	if (is_null($user)) {
		return APIResponse::NewJSONError('User not found', $identifier, 404);
	}
	
	if ($user->UserId() === Core::UserId()) {
		if (isset($_GET['deviceId']) && ($deviceId = $_GET['deviceId']) && BeaconCommon::IsUUID($deviceId)) {
			$user->PrepareSignatures($deviceId);
		}
		$userInfo = $user;
	} else {
		// don't use the regular method that includes lots of values
		$userInfo = [
			'userId' => $user->UserId(),
			'username' => $user->Username(false),
			'usernameFull' => $user->Username(true),
			'publicKey' => $user->PublicKey()
		];
	}
	
	return APIResponse::NewJSON($userInfo, 200);
}
