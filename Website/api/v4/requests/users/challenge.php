<?php

// These challenges are used for signing in with a signature, but Beacon never
// makes a request for a challenge. That could be a bug, but this feature looks
// to be unused at the moment.

use BeaconAPI\v4\{APIResponse, Core, User};

function handleRequest(array $context): APIResponse {
	$identifier = $context['pathParameters']['userId'];
	$user = User::Fetch($identifier);
	if (is_null($user)) {
		return APIResponse::NewJsonError('User not found', $identifier, 404);
	}
	
	$challenge = BeaconCommon::GenerateUUID();

	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	$database->Query('INSERT INTO user_challenges (user_id, challenge) VALUES ($1, $2) ON CONFLICT (user_id) DO UPDATE SET challenge = $2;', $user->UserId(), $challenge);
	$database->Commit();

	return APIResponse::NewJson(['userId' => $user->UserId(), 'challenge' => $challenge], 201);
}

?>