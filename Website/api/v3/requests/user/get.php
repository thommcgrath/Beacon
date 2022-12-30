<?php

function handle_request(array $context): void {
	switch ($context['route_key']) {
	case 'GET /user':
		// Fetch the current user
		BeaconAPI::Authorize();
			
		$user = BeaconAPI::User();
		if (isset($_GET['hardware_id'])) {
			$user->PrepareSignatures(trim($_GET['hardware_id']));
		}
		if (is_null($user->UsercloudKey()) && $user->SetDecryptedUsercloudKey(BeaconUser::GenerateUsercloudKey())) {
			$user->Commit();
		}
		BeaconAPI::ReplySuccess($user);
		
		break;
	case 'GET /user/{user_id}':
		// Find another user
		$identifiers = $context['path_parameters']['user_id'];
		$identifiers = str_replace(',,', '78d6b5c4-7069-42c2-9f81-c6408baefc05', $identifiers);
		$identifiers = explode(',', $identifiers);
		for ($i = 0; $i < count($identifiers); $i++) {
			$identifiers[$i] = str_replace('78d6b5c4-7069-42c2-9f81-c6408baefc05', ',', $identifiers[$i]);
		}
		$users = [];
		foreach ($identifiers as $identifier) {
			if (BeaconCommon::IsUUID($identifier)) {
				$user = BeaconUser::GetByUserID($identifier);
			} elseif (BeaconUser::ValidateEmail($identifier)) {
				$user = BeaconUser::GetByEmail($identifier);
			} elseif (BeaconUser::IsExtendedUsername($identifier)) {
				$user = BeaconUser::GetByExtendedUsername($identifier);
			} else {
				$user = null;
			}
			if (!is_null($user)) {
				// don't use the regular method that includes lots of values
				$users[] = array(
					'user_id' => $user->UserID(),
					'username_full' => $user->Username() . '#' . $user->Suffix(),
					'public_key' => $user->PublicKey()
				);
			}
		}
		if (count($users) == 1) {
			BeaconAPI::ReplySuccess($users[0]);
		} elseif (count($users) > 1) {
			BeaconAPI::ReplySuccess($users);
		} else {
			BeaconAPI::ReplyError('Users not found', $users, 404);
		}
		break;
	}
}