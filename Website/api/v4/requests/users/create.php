<?php

use BeaconAPI\v4\{APIResponse, Core, EmailVerificationCode, User};

function handle_request(array $context): APIResponse {
	if (Core::IsJSONContentType() === false) {
		return APIResponse::NewJSONError('Send a JSON payload', null, 400);
	}
	
	$payload = Core::BodyAsJSON();
	$email = null;
	if (isset($payload['email']) && empty($payload['email']) === false) {
		if (isset($payload['verification_code']) === false) {
			return APIResponse::NewJSONError('Missing verification code', $payload, 400);
		}
		
		$email = $payload['email'];
		$verification_code = $payload['verification_code'];
		if (EmailVerificationCode::IsEmailVerified($email, $verification_code) === false) {
			return APIResponse::NewJSONError('Incorrect verification code', $payload, 400);
		}
	}
	
	if (isset($payload['user_id'])) {
		return APIResponse::NewJSONError('Do not include user id', $payload, 400);
	}
	
	if ($context['route_key'] === 'PUT /users/{userId}') {
		$user_id = $context['path_parameters']['userId'];
		$user = User::Fetch($user_id);
		if (is_null($user) === false) {
			return APIResponse::NewJSONError('User already exists', $payload, 400);
		}
	} else {
		$user_id = BeaconCommon::GenerateUUID();
	}
	
	if (isset($payload['public_key']) === false || empty($payload['public_key'])) {
		return APIResponse::NewJSONError('Missing public key', $payload, 400);
	}
	
	$database = BeaconCommon::Database();
	try {
		$database->BeginTransaction();
		$user = new User($user_id);
		$user->SetPublicKey(BeaconEncryption::PublicKeyToPEM($payload['public_key']));
		$user->SetDecryptedUsercloudKey(User::GenerateUsercloudKey());
		if (is_null($email) === false) {
			$user->SetEmailAddress($email);
			$user->SetUsername($payload['username']);
			$user->SetPrivateKey($payload['private_key'], $payload['private_key_salt'], $payload['private_key_iterations']);
			EmailVerificationCode::Clear($email);
		}
		$user->Commit();
		$user = User::Fetch($user_id); // Reload the object
		$database->Commit();
		return APIResponse::NewJSON($user, 201);
	} catch (Exception $err) {
		$database->Rollback();
		return APIResponse::NewJSONError($err->getMessage(), $payload, 500);
	}
}

function SaveUser(array $values, string &$message): ?User {
	$user = null;
	if (array_key_exists('user_id', $values) && BeaconCommon::IsUUID($values['user_id'])) {
		$user_id = $values['user_id'];
		$user = User::Fetch($user_id);
	}
	
	$database = BeaconCommon::Database();
	
	$authenticated_user = null;
	if (Core::Authenticated()) {
		$authenticated_user = Core::User();
	}
	
	if (isset($values['action']) && strtolower($values['action']) === 'merge') {
		// Merge an anonymous user into the currently authenticated user.
		
		if (isset($values['private_key']) == false) {
			$message = 'Private key not included.';
			return null;
		}
		
		return MergeUsers($authenticated_user, $user, $values['private_key'], $message);
	}
	
	// If `user_id` is not specified, changes affect the authenticated user.
	if (is_null($authenticated_user) === false && is_null($user) === true) {
		$user = $authenticated_user;
	}
	
	// `email` is the modern tag. Migrate `login_key` to email if it is present.
	if (array_key_exists('login_key', $values) && array_key_exists('email', $values) === false) {
		$values['email'] = $values['login_key'];
	}
	
	// If `$user` is not null, then we edit the user, as long as the user is the authenticated user.
	if (is_null($user) === false) {
		if (is_null($authenticated_user) || $authenticated_user->UserID() !== $user->UserID()) {
			$message = 'May not edit another user';
			return null;
		}
		
		if (array_key_exists('username', $values) && $user->SetUsername($values['username']) === false) {
			$message = 'Unable to set username to ' . $values['username'] . '.';
			return null;
		}
		
		if (array_key_exists('email', $values) && $user->SetEmailAddress($values['email']) === false) {
			$message = 'Unable to set account email address to ' . $values['email'] . '.';
			return null;
		}
	} else {
		if (empty($user_id)) {
			$message = 'User ID is missing or not a v4 UUID.';
			return null;
		}
		if (empty($values['public_key'])) {
			$message = 'Missing public key.';
			return null;
		}
		$user = new BeaconUser($user_id);
		$user->SetPublicKey(BeaconEncryption::PublicKeyToPEM($values['public_key']));
		$user->SetDecryptedUsercloudKey(BeaconUser::GenerateUsercloudKey());
		
		if (array_key_exists('email', $values)) {
			// The goal is to create a named user
			if (BeaconCommon::HasAllKeys($values, 'private_key', 'private_key_salt', 'private_key_iterations') === false) {
				$message = 'Incomplete user profile.';
				return null;
			}
			
			if (empty($values['username'])) {
				$values['username'] = $values['email'];
			}
			
			$user->SetEmailAddress($values['email']);
			$user->SetUsername($values['username']);
			$user->SetPrivateKey($values['private_key'], $values['private_key_salt'], $values['private_key_iterations']);
		}
	}
	
	if ($user->Commit()) {
		return BeaconUser::GetByUserID($user->UserID());
	} else {
		$message = 'Unable to save changes the user.';
		return null;
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