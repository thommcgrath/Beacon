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
		
		if (isset($values['private_key']) == false) {
			$message = 'Private key not included.';
			return null;
		}
		
		return MergeUsers($authenticated_user, $user, $values['private_key'], $message);
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

function MergeUsers($into_user, $from_user, string $from_user_private_key, string &$message) {
	if (is_null($into_user) || is_null($from_user) || is_a($into_user, 'BeaconUser') == false || is_a($from_user, 'BeaconUser') == false) {
		$message = 'Merge process requires exactly two existing users.';
		return null;
	}
	if ($into_user->IsAnonymous() || $from_user->IsAnonymous() == false) {
		$message = 'Only an anonymous user may be merged into a named user.';
		return null;
	}
	
	// In order for this to work, the user must not have used their cloud storage at all, so that
	// we can copy the cloud key from the other user.
	
	$from_has_files = $from_user->HasFiles();
	if ($from_has_files && $into_user->HasEncryptedFiles()) {
		$message = 'The named user already has encrypted files so their encryption key cannot be changed.';
		return null;
	}
	
	// If it is already PEM-encoded, then nothing will happen.
	$pem_private_key = BeaconEncryption::PrivateKeyToPEM($from_user_private_key);
	$pem_public_key = BeaconEncryption::PublicKeyToPEM($from_user->PublicKey());
	
	$decrypted = '';
	try {
		// To verify the private key is correct, we're going to encrypt something with the
		// public key stored in the database and decrypt using the provided private key.
		$test_value = BeaconCommon::GenerateUUID();
		$encrypted = BeaconEncryption::RSAEncrypt($pem_public_key, $test_value);
		$decrypted = BeaconEncryption::RSADecrypt($pem_private_key, $encrypted);
	} catch (Exception $err) {
		$message = $err->getMessage();
		return null;
	}
	if ($decrypted !== $test_value) {
		$message = 'Unable to confirm ownership of the source user.';
		return null;
	}
	
	$files_to_delete = array();
	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	if ($from_has_files) {
		if ($from_user->HasEncryptedFiles()) {
			// So we're going to copy the cloud key from $from_user into $into_user
			try {
				$results = $database->Query('SELECT usercloud_key FROM users WHERE user_id = $1;', $from_user->UserID());
				$cloud_key = BeaconEncryption::RSADecrypt($pem_private_key, hex2bin($results->Field('usercloud_key')));
				$database->Query('UPDATE users SET usercloud_key = $2 WHERE user_id = $1;', $into_user->UserID(), bin2hex(BeaconEncryption::RSAEncrypt($into_user->PublicKey(), $cloud_key)));
			} catch (Exception $err) {
				$database->Rollback();
				$message = 'Unable to migrate cloud encryption key: ' . $err->getMessage();
				return null;
			}
		}
		
		$list = BeaconCloudStorage::ListFiles('/' . $from_user->UserID() . '/');
		foreach ($list as $fileinfo) {
			if ($fileinfo['size'] == 0 || $fileinfo['deleted'] == true) {
				continue;
			}
			
			$is_encrypted = is_null($fileinfo['header']) == false;
			$old_path = $fileinfo['path'];
			$new_path = str_replace('/' . $from_user->UserID() . '/', '/' . $into_user->UserID() . '/', $old_path);
			
			$contents = BeaconCloudStorage::GetFile($old_path);
			if (empty($contents)) {
				// We checked the size before, it should have something, so we need to fail.
				$database->Rollback();
				$message = 'Failed to load cloud file ' . $old_path;
				return null;
			}
			
			if (substr($old_path, -7) == '.beacon' && substr($old_path, 37, 11) == '/Documents/') {
				// This is a document. Yay. The objective here is to change the encryption key inside the file.
				if (BeaconCommon::IsCompressed($contents)) {
					$temp_contents = gzdecode($contents);
				} else {
					$temp_contents = $contents;
				}
				$document = json_decode($temp_contents, true);
				unset($temp_contents);
				
				
				if (isset($document['Version']) && $document['Version'] >= 4 && isset($document['EncryptionKeys'])) {
					$keys = $document['EncryptionKeys'];
					if (array_key_exists($from_user->UserID(), $keys)) {
						$encrypted_key = base64_decode($keys[$from_user->UserID()]);
						try {
							$decrypted_key = BeaconEncryption::RSADecrypt($pem_private_key, $encrypted_key);
							$encrypted_key = BeaconEncryption::RSAEncrypt($into_user->PublicKey(), $decrypted_key);
							$keys[$into_user->UserID()] = base64_encode($encrypted_key);
							unset($keys[$from_user->UserID()]);
							$document['EncryptionKeys'] = $keys;
							$encoded = json_encode($document);
							unset($document);
							if (is_string($encoded)) {
								$contents = gzencode($encoded);
							}
							unset($encoded);
						} catch (Exception $err) {
							// Something failed. Too bad.
							$database->Rollback();
							echo 'Exception while updating document ' . $err->getMessage();
							exit;
						}
					}
				}
			}
			
			$files_to_delete[] = $old_path;
			if (BeaconCloudStorage::PutFile($new_path, $contents) == false) {
				$database->Rollback();
				$message = 'Failed to upload cloud file to ' . $new_path;
				return null;
			}
		}
	}
	
	if ($into_user->MergeUsers($from_user->UserID()) == false) {
		$database->Rollback();
		$message = 'Failed to remove the old user from the database.';
		return null;
	}
	
	$database->Commit();
	
	foreach ($files_to_delete as $remote_path) {
		BeaconCloudStorage::DeleteFile($remote_path);
	}
	
	// Grab a fresh copy of the user object
	return BeaconUser::GetByUserID($into_user->UserID());
}

?>
