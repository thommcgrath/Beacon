<?php

namespace BeaconAPI\v4;
use BeaconChannelEvent, BeaconCloudStorage, BeaconCommon, BeaconEncryption, BeaconPusher, Exception;

abstract class UserGenerator {
	public static function CreateAnonymous(string $publicKeyPem, string $cloudKey): User {
		return User::Create([
			'publicKey' => $publicKeyPem,
			'cloudKey' => $cloudKey,
			'securityModel' => User::SecurityModelAnonymous,
		]);
	}

	public static function CreateNamed(string $email, string $username, string $password): User {
		$publicKeyPem = null;
		$privateKeyPem = null;
		BeaconEncryption::GenerateKeyPair($publicKeyPem, $privateKeyPem);
		$encryptedCloudKey = BeaconEncryption::RSAEncrypt($publicKeyPem, User::GenerateCloudKey());
		$securityModel = (BeaconCommon::GetGlobal('Enable Security Models') ?? false) ? User::SecurityModelStandard : User::SecurityModelLegacy;

		$userProperties = [
			'email' => $email,
			'username' => $username,
			'publicKey' => $publicKeyPem,
			'cloudKey' => bin2hex($encryptedCloudKey),
			'securityModel' => $securityModel,
		];
		switch ($securityModel) {
		case User::SecurityModelLegacy:
			$userProperties = array_merge($userProperties, static::EncryptPrivateKey($password, $privateKeyPem));
			break;
		case User::SecurityModelStandard:
			$privateKeySecret = base64_decode(BeaconCommon::GetGlobal('Private Key Secret'));
			$encryptedPrivateKey = BeaconEncryption::SymmetricEncrypt($privateKeySecret, $privateKeyPem, false);
			$userProperties['privateKey'] = bin2hex($encryptedPrivateKey);
			break;
		}

		$user = null;
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		try {
			$user = User::Create($userProperties);
			if ($securityModel !== User::SecurityModelLegacy) {
				UserCredential::SetUserPassword($user->UserId(), $password);
			}
		} catch (Exception $err) {
			$database->Rollback();
			throw $err;
		}
		$database->Commit();

		return $user;
	}

	public static function ReplacePrivateKey(string|User $user, ?string &$newPassword = null): void {
		if (is_string($user)) {
			$userId = $user;
			$user = User::Fetch($userId);
		} else {
			$userId = $user->UserId();
		}

		$generateHash = true;
		$secret = null;
		switch ($user->SecurityModel()) {
		case User::SecurityModelAnonymous:
			throw new Exception('Anonymous accounts are anonymous. There is no private key to replace.');
		case User::SecurityModelStandard:
			$secret = base64_decode(BeaconCommon::GetGlobal('Private Key Secret'));
			$generateHash = false;
			break;
		case User::SecurityModelLegacy:
			$secret = $newPassword;
			break;
		case User::SecurityModelEnhanced:
			$newPassword = BeaconCommon::GenerateRandomKey(32);
			$secret = $newPassword;
			break;
		}

		$publicKeyPem = null;
		$privateKeyPem = null;
		BeaconEncryption::GenerateKeyPair($publicKeyPem, $privateKeyPem);
		$encryptedCloudKey = BeaconEncryption::RSAEncrypt($publicKeyPem, User::GenerateCloudKey());

		$userProperties = array_merge([
			'publicKey' => $publicKeyPem,
			'cloudKey' => bin2hex($encryptedCloudKey),
		], static::EncryptPrivateKey($secret, $privateKeyPem, $generateHash));

		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		try {
			$user->Edit($userProperties);

			// delete encrypted cloud files
			$cloudFiles = BeaconCloudStorage::ListFiles('/' . $userId . '/');
			foreach ($cloudFiles as $file) {
				if ($file['deleted'] === false && is_null($file['header']) === false) {
					BeaconCloudStorage::DeleteFile($file['path']);
				}
			}

			// clear all project passwords
			$database->Query('UPDATE public.project_members SET encrypted_password = NULL, fingerprint = NULL WHERE user_id = $1;', $user->UserId());

			$database->Commit();
		} catch (Exception $err) {
			$database->Rollback();
			throw $err;
		}
	}

	public static function GracefulPasswordChange(string|User $user, string $oldPassword, string $newPassword): bool {
		if (is_string($user)) {
			$userId = $user;
			$user = User::Fetch($userId);
		} else {
			$userId = $user->UserId();
		}

		if ($user->UsesModernSecurity()) {
			UserCredential::SetUserPassword($userId, $newPassword);
			return true;
		}

		try {
			$privateKey = $user->DecryptPrivateKey($oldPassword);
		} catch (Exception $err) {
			return false;
		}

		$userProperties = static::EncryptPrivateKey($newPassword, $privateKey);

		try {
			$user->Edit($userProperties);
			return true;
		} catch (Exception $err) {
			return false;
		}
	}

	public static function HardPasswordReset(string|User $user, string $newPassword): bool {
		if (is_string($user)) {
			$userId = $user;
			$user = User::Fetch($userId);
		} else {
			$userId = $user->UserId();
		}

		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		try {
			if ($user->UsesModernSecurity()) {
				UserCredential::SetUserPassword($userId, $newPassword);
			} else {
				static::ReplacePrivateKey($user, $newPassword);
			}

			// clear all sessions
			$sessions = Session::Search(['userId' => $userId], true);
			foreach ($sessions as $session) {
				$session->Delete();
			}

			// untrust all devices
			$user->UntrustAllDevices();

			$database->Commit();

			BeaconPusher::SharedInstance()->SendEvents([
				new BeaconChannelEvent(channelName: BeaconPusher::UserChannelName($userId), eventName: 'user-updated', body: ''),
				new BeaconChannelEvent(channelName: BeaconPusher::PrivateUserChannelName($userId), eventName: 'userUpdated', body: ''),
			]);

			return true;
		} catch (Exception $err) {
			$database->Rollback();
			return false;
		}
	}

	protected static function EncryptPrivateKey(string $password, string $privateKeyPem, bool $generateHash = true): array {
		if ($generateHash) {
			$privateKeySalt = BeaconEncryption::GenerateSalt();
			$privateKeyIterations = 450000;
			$privateKeySecret = BeaconEncryption::HashFromPassword($password, $privateKeySalt, $privateKeyIterations);
		} else {
			$privateKeySecret = $password;
		}
		$encryptedPrivateKey = BeaconEncryption::SymmetricEncrypt($privateKeySecret, $privateKeyPem, false);

		return [
			'privateKey' => bin2hex($encryptedPrivateKey),
			'privateKeySalt' => bin2hex($privateKeySalt),
			'privateKeyIterations' => $privateKeyIterations
		];
	}
}

?>
