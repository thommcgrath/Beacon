<?php

function handle_request(array $context): void {
	$identifier = $context['path_parameters']['userId'];
	if (BeaconCommon::IsUUID($identifier)) {
		$user = BeaconUser::GetByUserID($identifier);
	} elseif (BeaconUser::ValidateEmail($identifier)) {
		$user = BeaconUser::GetByEmail($identifier);
	} elseif (BeaconUser::IsExtendedUsername($identifier)) {
		$user = BeaconUser::GetByExtendedUsername($identifier);
	} else {
		$user = null;
	}
	
	if (is_null($user)) {
		BeaconAPI::ReplyError('User not found', $users, 404);
	}
	
	if ($user->UserID() === BeaconAPI::UserID()) {
		$user_info = $user;
	} else {
		// don't use the regular method that includes lots of values
		$user_info = [
			'user_id' => $user->UserID(),
			'username_full' => $user->Username() . '#' . $user->Suffix(),
			'public_key' => $user->PublicKey()
		];
	}
	
	BeaconAPI::ReplySuccess($user_info);
}
