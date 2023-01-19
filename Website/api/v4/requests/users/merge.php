<?php

// These challenges are used for signing in with a signature, but Beacon never
// makes a request for a challenge. That could be a bug, but this feature looks
// to be unused at the moment.

use BeaconAPI\v4\{APIResponse, Core, Project, User};

function handle_request(array $context): APIResponse {
	$identifier = $context['path_parameters']['userId'];
	$authenticated_user = User::Fetch($identifier);
	if (is_null($authenticated_user)) {
		return APIResponse::NewJSONError('User not found', $identifier, 404);
	}
	
	$body = Core::BodyAsJSON();
	if (BeaconCommon::IsAssoc($body)) {
		$anonymous_users = [$body];
		$multi = false;
	} else {
		$anonymous_users = $body;
		$multi = true;
	}
	
	$reply = [];
	$status_counts = [];
	$database = BeaconCommon::Database();
	foreach ($anonymous_users as $anonymous_user) {
		$reason = '';
		$status = MergeUser($authenticated_user, $anonymous_user, $reason);
		if (array_key_exists($status, $status_counts) === false) {
			$status_counts[$status] = 1;
		} else {
			$status_counts[$status]++;
		}
		$member = [
			'sent_object' => $anonymous_user,
			'status' => $status,
			'reason' => $reason
		];
		$reply[] = $member;
	}
	
	if ($multi) {
		switch (count($status_counts)) {
		case 1:
			$status = array_key_first($status_counts);
			break;
		case 0:
			$status = 200;
			break;
		default:
			if (array_key_exists(200, $status_counts)) {
				$status = 207;
			} else {
				$status = 400;
			}
			break;
		}
		return APIResponse::NewJSON($reply, $status);
	} else {
		$member = $reply[0];
		if ($member['success']) {
			return APIResponse::NewJSON($member, 200);
		} else {
			return APIResponse::NewJSONError($member['reason'], $member['sent_object'], 400);
		}
	}
}

// Returns an HTTP status
function MergeUser(User $authenticated_user, array $anonymous_user, string &$reason): int {
	if (BeaconCommon::HasAllKeys($anonymous_user, 'user_id', 'private_key') === false) {
		$reason = 'Must include user_id and private_key properties.';
		return 400;
	}
	
	$user_id = $anonymous_user['user_id'];
	$private_key = $anonymous_user['private_key'];
	$user = User::Fetch($user_id);
	if (is_null($user)) {
		$reason = 'User not found';
		return 404;
	}
	if ($user->IsAnonymous() === false) {
		$reason = 'User is not anonymous';
		return 403;
	}
	
	// To confirm ownership, we're going to try to encrypt something with the user's public key and decrypt it with the private
	$pem_private_key = null;
	$pem_public_key = null;
	try {
		$pem_private_key = BeaconEncryption::PrivateKeyToPEM($private_key); // Will do nothing if already pem-encoded
		$pem_public_key = BeaconEncryption::PublicKeyToPEM($user->PublicKey());
		$test_value = BeaconCommon::GenerateUUID();
		$encrypted = BeaconEncryption::RSAEncrypt($pem_public_key, $test_value);
		$decrypted = BeaconEncryption::RSADecrypt($pem_private_key, $encrypted);
		if ($decrypted !== $test_value) {
			throw new Exception('Could not confirm ownership of user.');	
		}
	} catch (Exception $err) {
		$reason = $err->getMessage();
		return 400;
	}
	
	$authenticated_user_id = $authenticated_user->UserId();
	$single_tables = ['public.user_backup_codes', 'public.user_challenges'];
	$multi_tables = ['public.affiliate_links', 'public.exception_comments', 'public.exception_users', 'public.gift_code_log', 'public.projects', 'public.trusted_devices', 'public.user_authenticators'];
	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	foreach ($single_tables as $table) {
		$rows = $database->Query('SELECT EXISTS(SELECT 1 FROM ' . $table . ' WHERE user_id = $1);', $authenticated_user_id);
		if ($rows->Field('exists')) {
			$database->Query('DELETE FROM ' . $table . ' WHERE user_id = $1;', $user_id);
		} else {
			$database->Query('UPDATE ' . $table . ' SET user_id = $1 WHERE user_id = $2;', $authenticated_user_id, $user_id);
		}
	}
	foreach ($multi_tables as $table) {
		$database->Query('UPDATE ' . $table . ' SET user_id = $1 WHERE user_id = $2;', $authenticated_user_id, $user_id);
	}
	$database->Query('UPDATE public.guest_projects SET user_id = $1 WHERE user_id = $2 AND project_id NOT IN (SELECT project_id FROM public.projects WHERE user_id = $1);', $authenticated_user_id, $user_id);
	$database->Query('DELETE FROM public.guest_projects WHERE user_id = $1;', $user_id);
	$database->Query('DELETE FROM public.users WHERE user_id = $1;', $user_id);
	$database->Commit();
	
	return 200;
}

?>