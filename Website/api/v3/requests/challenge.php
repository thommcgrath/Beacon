<?php

// These challenges are used for signing in with a signature, but Beacon never
// makes a request for a challenge. That could be a bug, but this feature looks
// to be unused at the moment.

function handle_request(array $context): void {
	$user_id = $context['path_parameters']['user_id'];
	if (is_null(BeaconUser::GetByUserID($user_id))) {
		BeaconAPI::ReplyError('User not found', $user_id, 404);
	}
	$challenge = \BeaconCommon::GenerateUUID();

	$database = \BeaconCommon::Database();
	$database->BeginTransaction();
	$database->Query('INSERT INTO user_challenges (user_id, challenge) VALUES ($1, $2) ON CONFLICT (user_id) DO UPDATE SET challenge = $2;', $user_id, $challenge);
	$database->Commit();

	BeaconAPI::ReplySuccess(['user_id' => $user_id, 'challenge' => $challenge]);
}

?>