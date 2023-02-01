<?php

namespace BeaconAPI\v4;
use BeaconCloudStorage, BeaconCommon, BeaconEncryption, Exception;

abstract class UserGenerator {
	public static function CreateAnonymous(string $publicKeyPem, string $cloudKey): User {
		return User::Create([
			'publicKey' => $publicKeyPem,
			'cloudKey' => $cloudKey
		]);
	}
	
	public static function CreateNamed(string $email, string $username, string $password): User {
		$publicKeyPem = null;
		$privateKeyPem = null;
		BeaconEncryption::GenerateKeyPair($publicKeyPem, $privateKeyPem);
		$encryptedCloudKey = BeaconEncryption::RSAEncrypt($publicKeyPem, User::GenerateCloudKey());
		
		$userProperties = array_merge([
			'email' => $email,
			'username' => $username,
			'publicKey' => $publicKeyPem,
			'cloudKey' => bin2hex($encryptedCloudKey)
		], static::EncryptPrivateKey($password, $privateKeyPem));
		
		return User::Create($userProperties);
	}
	
	// Alias for ChangePassword with a null $oldPassword;
	public static function ReplacePassword(User $user, string $password): void {
		static::ChangePassword($user, null, $password, null, true);
	}
	
	// With string $oldPassword: graceful password change, deletes all sessions except one
	// With null $oldPassword: forceful password change, generates a new key, deletes all sessions, deletes all encrypted cloud files, untrusts all devices
	public static function ChangePassword(User $user, string|null $oldPassword, string $newPassword, string|Session|null $retainSession = null, bool $regenerateKey = false): void {
		$userProperties = [];
		$regenerateKey = $regenerateKey || is_null($oldPassword);
		
		// If the old password is provided, it *must* match. SymmetricDecrypt will throw an exception if it does not.
		if (is_string($oldPassword)) {
			$privateKeySalt = hex2bin($user->PrivateKeySalt());
			$privateKeyIterations = $user->PrivateKeyIterations();
			$privateKeySecret = BeaconEncryption::HashFromPassword($oldPassword, $privateKeySalt, $privateKeyIterations);
			try {
				$privateKeyPem = BeaconEncryption::SymmetricDecrypt($privateKeySecret, hex2bin($user->PrivateKey()));
			} catch (Exception $err) {
				// Make a nicer exception
				throw new Exception('Old password is not correct.');
			}
		}
		
		// The user can do a graceful password change and still generate a new key.
		if ($regenerateKey) {
			$publicKeyPem = null;
			$privateKeyPem = null;
			BeaconEncryption::GenerateKeyPair($publicKeyPem, $privateKeyPem);
			$encryptedCloudKey = BeaconEncryption::RSAEncrypt($publicKeyPem, User::GenerateCloudKey());
			
			$userProperties['publicKey'] = $publicKeyPem;
			$userProperties['cloudKey'] = bin2hex($encryptedCloudKey);
		}
		
		$userProperties = array_merge($userProperties, static::EncryptPrivateKey($newPassword, $privateKeyPem));
		
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		try {
			$user->Edit($userProperties);
			
			// delete all sessions
			if (is_null($retainSession) === false && is_string($retainSession)) {
				$retainSession = Session::Fetch($retainSession);
			}
			$sessions = Session::Search(['userId' => $user->UserId()], true);
			foreach ($sessions as $session) {
				if (is_null($retainSession) == false && $session->SessionHash() === $retainSession->SessionHash()) {
					continue;
				}
				
				$session->Delete();
			}
			
			if ($regenerateKey) {
				// delete encrypted cloud files
				$cloudFiles = BeaconCloudStorage::ListFiles('/' . $user->UserId() . '/');
				foreach ($cloudFiles as $file) {
					if ($file['deleted'] === false && is_null($file['header']) === false) {
						BeaconCloudStorage::DeleteFile($file['path']);
					}
				}
				
				// untrust all devices
				$user->UntrustAllDevices();
			}
			
			$database->Commit();
		} catch (Exception $err) {
			$database->Rollback();
			throw $err;
		}
	}
	
	protected static function EncryptPrivateKey(string $password, string $privateKeyPem): array {
		$privateKeySalt = BeaconEncryption::GenerateSalt();
		$privateKeyIterations = rand(100000, 111111);
		$privateKeySecret = BeaconEncryption::HashFromPassword($password, $privateKeySalt, $privateKeyIterations);
		$encryptedPrivateKey = BeaconEncryption::SymmetricEncrypt($privateKeySecret, $privateKeyPem, false);
		
		return [
			'privateKey' => bin2hex($encryptedPrivateKey),
			'privateKeySalt' => bin2hex($privateKeySalt),
			'privateKeyIterations' => $privateKeyIterations
		];
	}
}

?>
