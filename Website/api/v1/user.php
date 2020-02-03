<?php

require(dirname(__FILE__) . '/loader.php');

$method = BeaconAPI::Method();
$database = BeaconCommon::Database();
$user_id = BeaconAPI::ObjectID();

switch ($method) {
case 'PUT':
case 'POST':
	if ($user_id !== null) {
		BeaconAPI::ReplyError('Do not specify a user when creating users.');
	}
	
	if (BeaconAPI::ContentType() !== 'application/json') {
		BeaconAPI::ReplyError('Send a JSON payload');
	}
	
	$payload = BeaconAPI::JSONPayload();
	if (BeaconCommon::IsAssoc($payload)) {
		// single
		$items = array($payload);
	} else {
		// multiple
		$items = $payload;
	}
	
	BeaconAPI::Authorize(true);
	
	$users = array();
	$database->BeginTransaction();
	foreach ($items as $item) {
		$reason = '';
		$user = SaveUser($item, $reason);
		if (is_null($user)) {
			$database->Rollback();
			BeaconAPI::ReplyError($reason, $item);
		}
		$users[] = $user;
	}
	$database->Commit();
	
	BeaconAPI::ReplySuccess($users);
	
	break;
case 'GET':
	if (is_null(BeaconAPI::ObjectID())) {
		BeaconAPI::Authorize();
		
		$user = BeaconUser::GetByUserID(BeaconAPI::UserID());
		if (isset($_GET['hardware_id'])) {
			$user->PrepareSignatures(trim($_GET['hardware_id']));
		}
		if ($user->AssignUsercloudKey()) {
			$user->Commit();
		}
		BeaconAPI::ReplySuccess($user);
	} else {
		// lookup support
		$identifiers = BeaconAPI::ObjectID();
		$identifiers = str_replace(',,', '78d6b5c4-7069-42c2-9f81-c6408baefc05', $identifiers);
		$identifiers = explode(',', $identifiers);
		for ($i = 0; $i < count($identifiers); $i++) {
			$identifiers[$i] = str_replace('78d6b5c4-7069-42c2-9f81-c6408baefc05', ',', $identifiers[$i]);
		}
		$users = array();
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
	}
	
	break;
case 'DELETE':
	BeaconAPI::Authorize();
	if (strtolower($user_id) !== strtolower(BeaconAPI::UserID())) {
		BeaconAPI::ReplyError('Cannot delete another user.');
	}
	
	$database->BeginTransaction();
	$database->Query('DELETE FROM documents WHERE user_id = $1;', BeaconAPI::UserID());
	$database->Query('DELETE FROM mods WHERE user_id = $1;', BeaconAPI::UserID());
	$database->Query('DELETE FROM users WHERE user_id = $1;', BeaconAPI::UserID());
	$database->Commit();
	
	BeaconAPI::ReplySuccess();
	
	break;
}

function SaveUser(array $values, string &$message) {
	if (array_key_exists('user_id', $values) == false || BeaconCommon::IsUUID($values['user_id']) == false) {
		$message = 'User ID is missing or not a v4 UUID.';
		return null;
	}
	$user_id = $values['user_id'];
	$user = BeaconUser::GetByUserID($user_id);
	$database = BeaconCommon::Database();
	
	$authenticated_user = null;
	if (BeaconAPI::Authenticated()) {
		$authenticated_user = BeaconUser::GetByUserID(BeaconAPI::UserID());
	}
	
	if (isset($values['action']) && strtolower($values['action']) === 'merge') {
		// merge an anonymous user into the currently authenticated user
		
		$message = 'This feature is currently disabled.';
		return null;
		
		if (is_null($user)) {
			$message = 'Target user does not exist.';
			return null;
		}
		
		if (is_null($user->LoginKey()) == false) {
			$message = 'Target user already has a password.';
			return null;
		}
		
		if (BeaconCommon::HasAllKeys($values, 'signed_value', 'signature') == false) {
			$message = 'Missing signature and signed_value keys.';
			return null;
		}
		
		$signed_value = $values['signed_value'];
		$signature = $values['signature'];
		
		if (BeaconEncryption::RSAVerify($user->PublicKey(), $signed_value, hex2bin($signature)) == false) {
			$message = 'Ownership of user ' . $user_id . ' could not be proven.';
			return null;
		}
		
		try {
			$database->BeginTransaction();
			$database->Query('UPDATE documents SET user_id = $1 WHERE user_id = $2;', $authenticated_user->UserID(), $user->UserID());
			$database->Query('UPDATE mods SET user_id = $1 WHERE user_id = $2;', $authenticated_user->UserID(), $user->UserID());
			$database->Query('UPDATE sessions SET user_id = $1 WHERE user_id = $2;', $authenticated_user->UserID(), $user->UserID());
			$database->Query('DELETE FROM users WHERE user_id = $1;', $user->UserID());
			$database->Commit();
			return $authenticated_user;
		} catch (Exception $e) {
			$message = $e->getMessage();
			return null;
		}
	}
	
	if (array_key_exists('login_key', $values)) {
		// wants to save a named user
		if (is_null($authenticated_user) == false && strtolower($authenticated_user->UserID()) == strtolower($user_id)) {
			// we are authenticated as the user we are trying to edit, this is simple
			$changes = array();
			if (strtolower($authenticated_user->LoginKey()) != strtolower($values['login_key'])) {
				$changes['login_key'] = $values['login_key'];
			}
			
			// if any of these keys are included, all are required
			// if the login_key is currently blank, then require these too
			if (empty($authenticated_user->LoginKey()) || array_key_exists('private_key', $values) || array_key_exists('private_key_salt', $values) || array_key_exists('private_key_iterations', $values)) {
				if (BeaconCommon::HasAllKeys($values, 'private_key', 'private_key_salt', 'private_key_iterations') == false) {
					$message = 'Incomplete private key information.';
					return null;
				}
				
				if (strtolower($authenticated_user->PrivateKey()) != strtolower($values['private_key'])) {
					$changes['private_key'] = $values['private_key'];
				}
				if (strtolower($authenticated_user->PrivateKeySalt()) != strtolower($values['private_key_salt'])) {
					$changes['private_key_salt'] = $values['private_key_salt'];
				}
				if ($authenticated_user->PrivateKeyIterations() != intval($values['private_key_iterations'])) {
					$changes['private_key_iterations'] = $values['private_key_iterations'];
				}
			}
			
			if (count($changes) > 0) {
				try {
					$database->Update('users', $changes, array('user_id' => $authenticated_user->UserID()));
				} catch (Exception $e) {
					$message = $e->getMessage();
					return null;
				}
			}
			
			return BeaconUser::GetByUserID($user_id);
		}
		
		if (array_key_exists('public_key', $values) == false) {
			$message = 'Public key is missing.';
			return null;
		}
		$public_key = BeaconEncryption::PublicKeyToPEM($values['public_key']);
		if (BeaconCommon::HasAllKeys($values, 'private_key', 'private_key_salt', 'private_key_iterations') == false) {
			$message = 'Missing private key information.';
			return null;
		}
		
		if (is_null($user)) {
			try {
				$database->BeginTransaction();
				$database->Query('INSERT INTO users (user_id, login_key, public_key, private_key, private_key_salt, private_key_iterations) VALUES ($1, $2, $3, $4, $5, $6);', $user_id, $values['login_key'], $public_key, $values['private_key'], $values['private_key_salt'], $values['private_key_iterations']);
				$database->Commit();
			} catch (Exception $e) {
				$message = $e->getMessage();
				return null;
			}
			return BeaconUser::GetByUserID($user_id);
		} else {
			$message = 'User ID or email already exists.';
			return null;
		}		
	} else {
		// wants to save an anonymous user
		if (is_null($user) == false) {
			$message = 'User ' . $user_id . ' already exists.';
			return null;
		}
		if (array_key_exists('public_key', $values) == false) {
			$message = 'Public key is missing.';
			return null;
		}
		$public_key = BeaconEncryption::PublicKeyToPEM($values['public_key']);
		
		try {
			$database->BeginTransaction();
			$database->Query('INSERT INTO users (user_id, public_key) VALUES ($1, $2);', $user_id, $public_key);
			$database->Commit();
		} catch (Exception $e) {
			$message = $e->getMessage();
			return null;
		}
		
		return BeaconUser::GetByUserID($user_id);;
	}
}

?>
