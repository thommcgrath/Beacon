<?php

namespace BeaconAPI\v4;
use BeaconCloudStorage, BeaconCommon, BeaconEncryption, BeaconPusher, Exception;

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
		$oldPrivateKey = null;
		$publicKeyPem = $user->PublicKey();

		// If the old password is provided, it *must* match. SymmetricDecrypt will throw an exception if it does not.
		if (is_string($oldPassword)) {
			$privateKeySalt = hex2bin($user->PrivateKeySalt());
			$privateKeyIterations = $user->PrivateKeyIterations();
			$privateKeySecret = BeaconEncryption::HashFromPassword($oldPassword, $privateKeySalt, $privateKeyIterations);
			try {
				$privateKeyPem = BeaconEncryption::SymmetricDecrypt($privateKeySecret, hex2bin($user->PrivateKey()));
				$oldPrivateKey = $privateKeyPem;
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
			if (is_null($oldPrivateKey) === false && $oldPrivateKey !== $privateKeyPem) {
				// re-encrypt project passwords
				$rows = $database->Query('SELECT project_id, encrypted_password FROM public.project_members WHERE user_id = $1 AND encrypted_password IS NOT NULL;', $user->UserId());
				while (!$rows->EOF()) {
					$encryptedPassword = base64_decode($rows->Field('encrypted_password'));
					$projectId = $rows->Field('project_id');

					try {
						$decryptedPassword = BeaconEncryption::RSADecrypt($oldPrivateKey, $encryptedPassword);
						$encryptedPassword = BeaconEncryption::RSAEncrypt($publicKeyPem, $decryptedPassword);
						$fingerprint = ProjectMember::GenerateFingerprint($user->UserId(), $user->Username(false), $publicKeyPem, $decryptedPassword);
						$rows = $database->Query('UPDATE public.project_members SET encrypted_password = $3, fingerprint = $4 WHERE user_id = $1 AND project_id = $2;', $user->UserId(), $projectId, base64_encode($encryptedPassword), $fingerprint);
					} catch (Exception $passwordErr) {
						$rows = $database->Query('UPDATE public.project_members SET encrypted_password = NULL, fingerprint = NULL WHERE user_id = $1 AND project_id = $2;', $user->UserId(), $projectId);
					}
					$rows->MoveNext();
				}
			} else {
				// clear encrypted project passwords
				$database->Query('UPDATE public.project_members SET encrypted_password = NULL, fingerprint = NULL WHERE user_id = $1;', $user->UserId());
			}

			$database->Commit();

			BeaconPusher::SharedInstance()->SendEvents([
				new BeaconChannelEvent(channelName: BeaconPusher::UserChannelName($user->UserId()), eventName: 'user-updated', body: ''),
				new BeaconChannelEvent(channelName: BeaconPusher::PrivateUserChannelName($user->UserId()), eventName: 'userUpdated', body: ''),
			]);
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
