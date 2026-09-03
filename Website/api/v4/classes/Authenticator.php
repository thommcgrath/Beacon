<?php

namespace BeaconAPI\v4;
use BeaconCommon, BeaconRecordSet, BeaconUUID, Exception, JsonSerializable;

class Authenticator implements JsonSerializable {
	const TYPE_TOTP = 'TOTP'; // Deprecated
	const TypeTOTP = 'TOTP';

	const VerifyOptionAllowTOTP = 1;
	const VerifyOptionAllowBackupCodes = 2;
	const VerifyOptionAllowTrustedDevices = 4;
	const VerifyOptionReplaceUsedCode = 8;
	const VerifyAny = 15;

	protected $authenticatorId;
	protected $username;
	protected $type;
	protected $nickname;
	protected $dateAdded;
	protected $metadata;

	public static function FetchForUser(string|User $user): array {
		$database = BeaconCommon::Database();

		if (is_string($user)) {
			$userId = $user;
			$rows = $database->Query('SELECT security_model, username_full FROM public.users WHERE user_id = $1;', $userId);
			if ($rows->RecordCount() !== 1) {
				return [];
			}
			$securityModel = $rows->Field('security_model');
			$username = $rows->Field('username_full');
		} else {
			$userId = $user->UserId();
			$securityModel = $user->SecurityModel();
			$username = $user->Username(true);
		}

		$authenticators = [];
		if ($securityModel === User::SecurityModelLegacy) {
			$rows = $database->Query('SELECT authenticator_id, type, nickname, EXTRACT(EPOCH FROM date_added) AS date_added, metadata FROM public.user_authenticators WHERE user_id = $1 ORDER BY date_added DESC;', $userId);
			while (!$rows->EOF()) {
				$metadata = json_decode($rows->Field('metadata'), true);
				$authenticators[] = new static($rows->Field('authenticator_id'), $username, $rows->Field('type'), $rows->Field('nickname'), floatval($rows->Field('date_added')), $metadata);
				$rows->MoveNext();
			}
		} else {
			$credential = UserCredential::GetPasswordRecord($userId);
			if (is_null($credential)) {
				return [];
			}
			$metadata = $credential->Metadata();
			$sources = $metadata['authenticators'] ?? [];
			foreach ($sources as $source) {
				$authenticators[] = new static($source['authenticatorId'], $username, $source['type'], $source['nickname'], $source['dateAdded'], $source['metadata']);
			}
		}
		return $authenticators;
	}

	public static function GenerateSecret(): string {
		return BeaconCommon::Base32Encode(random_bytes(20));
	}

	public static function CreateTOTP(string|User $user, string $secret, string $nickname): static {
		$database = BeaconCommon::Database();
		if (is_string($user)) {
			$userId = $user;
			$rows = $database->Query('SELECT security_model, username_full FROM public.users WHERE user_id = $1;', $userId);
			if ($rows->RecordCount() !== 1) {
				throw new Exception('Cannot add authenticator to account that does not exist.');
			}
			$securityModel = $rows->Field('security_model');
			$username = $rows->Field('username_full');
		} else {
			$userId = $user->UserId();
			$securityModel = $user->SecurityModel();
			$username = $user->Username(true);
		}

		$authenticatorId = BeaconUUID::v4();
		$dateAdded = microtime(true);
		$authenticator = new static($authenticatorId, $username, self::TypeTOTP, $nickname, $dateAdded, ['secret' => $secret]);

		switch ($securityModel) {
		case User::SecurityModelLegacy:
			$metadata = [
				'setup' => static::SetupUrl($secret, $username),
				'secret' => $secret,
			];
			$database->BeginTransaction();
			$database->Query('INSERT INTO public.user_authenticators (authenticator_id, user_id, type, nickname, date_added, metadata) VALUES ($1, $2, $3, $4, TO_TIMESTAMP($5), $6);', $authenticatorId, $userId, $nickname, $dateAdded, json_encode($metadata));
			$rows = $database->Query('SELECT code FROM public.user_backup_codes WHERE user_id = $1;', $userId);
			$backupCodes = [];
			while (!$rows->EOF()) {
				$backupCodes[] = $rows->Field('code');
				$rows->MoveNext();
			}
			while (count($backupCodes) < 10) {
				$code = BeaconCommon::GenerateRandomKey(6);
				$backupCodes[] = $code;
				$database->Query('INSERT INTO public.user_backup_codes (user_id, code) VALUES ($1, $2);', $userId, $code);
			}
			$database->Commit();
			break;
		default:
			$database->BeginTransaction();
			$credential = UserCredential::GetPasswordRecord($userId);
			if (is_null($credential)) {
				$database->Rollback();
				throw new Exception('Cannot add authenticator to account that does not have a password.');
			}
			$metadata = $credential->Metadata();
			$authenticators = $metadata['authenticators'] ?? [];
			$backupCodes = $metadata['backupCodes'] ?? [];

			$authenticators[] = $authenticator;
			while (count($backupCodes) < 10) {
				$backupCodes[] = BeaconCommon::GenerateRandomKey(6);
			}

			$metadata['authenticators'] = (array)$authenticators;
			$metadata['backupCodes'] = (array)$backupCodes;
			try {
				$credential->Edit(['metadata' => $metadata]);
			} catch (Exception $err) {
				$database->Rollback();
				throw $err;
			}
			$database->Commit();
			break;
		}

		return $authenticator;
	}

	public static function RemoveAuthenticator(string|User $user, string $authenticatorId): void {
		$database = BeaconCommon::Database();
		if (is_string($user)) {
			$userId = $user;
			$rows = $database->Query('SELECT security_model FROM public.users WHERE user_id = $1;', $userId);
			if ($rows->RecordCount() !== 1) {
				throw new Exception('Cannot remove authenticator from account that does not exist.');
			}
			$securityModel = $rows->Field('security_model');
		} else {
			$userId = $user->UserId();
			$securityModel = $user->SecurityModel();
		}

		// The user may not remove their last authenticator if they have an application registered.
		$apps = Application::Search(['user_id' => $userId], true);
		$hasApp = count($apps) > 0;

		switch ($securityModel) {
		case User::SecurityModelLegacy:
			$database->BeginTransaction();
			$rows = $database->Query('SELECT authenticator_id FROM public.user_authenticators WHERE user_id = $1 AND authenticator_id = $2;', $userId, $authenticatorId);
			if ($rows->RecordCount() !== 1) {
				$database->Rollback();
				throw new Exception('Authenticator not found.');
			}

			$rows = $database->Query('SELECT COUNT(authenticator_id) AS remaining_authenticators FROM public.user_authenticators WHERE user_id = $1 AND authenticator_id != $2;', $userId, $authenticatorId);
			$remainingAuthenticators = $rows->Field('remaining_authenticators');
			if ($remainingAuthenticators <= 0 && $hasApp) {
				$database->Rollback();
				throw new Exception('One or more applications are registered to this account. Two step authentication cannot be disabled.');
			}

			$database->Query('DELETE FROM public.user_authenticators WHERE user_id = $1 AND authenticator_id = $2;', $userId, $authenticatorId);
			if ($remainingAuthenticators <= 0) {
				$database->Query('DELETE FROM public.user_backup_codes WHERE user_id = $1;', $userId);
			}
			$datbase->Commit();
			break;
		default:
			$database->BeginTransaction();
			$credential = UserCredential::GetPasswordRecord($userId);
			if (is_null($credential)) {
				$database->Rollback();
				throw new Exception('Cannot remove authenticator from account that does not have a password.');
			}
			$metadata = $credential->Metadata();
			$authenticators = $metadata['authenticators'] ?? [];
			$backupCodes = $metadata['backupCodes'] ?? [];

			$found = false;
			for ($idx = 0; $idx < count($authenticators); $idx++) {
				if ($authenticators[$idx]['authenticatorId'] == $authenticatorId) {
					$found = true;
					array_splice($authenticators, $idx, 1);
					break;
				}
			}
			if (!$found) {
				$database->Rollback();
				throw new Exception('Authenticator not found.');
			}
			if (count($authenticators) === 0) {
				if ($hasApp) {
					$database->Rollback();
					throw new Exception('One or more applications are registered to this account. Two step authentication cannot be disabled.');
				}
				$backupCodes = [];
			}

			$metadata['authenticators'] = (array)$authenticators;
			$metadata['backupCodes'] = (array)$backupCodes;
			try {
				$credential->Edit(['metadata' => $metadata]);
			} catch (Exception $err) {
				$database->Rollback();
				throw $err;
			}
			$database->Commit();
			break;
		}
	}

	public static function GetBackupCodes(string|User $user): array {
		$database = BeaconCommon::Database();
		if (is_string($user)) {
			$userId = $user;
			$rows = $database->Query('SELECT security_model FROM public.users WHERE user_id = $1;', $userId);
			if ($rows->RecordCount() !== 1) {
				return [];
			}
			$securityModel = $rows->Field('security_model');
		} else {
			$userId = $user->UserId();
			$securityModel = $user->SecurityModel();
		}

		switch ($securityModel) {
		case User::SecurityModelLegacy:
			$rows = $database->Query('SELECT code FROM public.user_backup_codes WHERE user_id = $1;', $userId);
			$backupCodes = [];
			while (!$rows->EOF()) {
				$backupCodes[] = $rows->Field('code');
				$rows->MoveNext();
			}
			return $backupCodes;
			break;
		default:
			$credential = UserCredential::GetPasswordRecord($userId);
			if (is_null($credential)) {
				return [];
			}
			$metadata = $credential->Metadata();
			$backupCodes = $metadata['backupCodes'] ?? [];
			return $backupCodes;
			break;
		}
	}

	public static function ReplaceBackupCodes(string|User $user): array {
		$database = BeaconCommon::Database();
		if (is_string($user)) {
			$userId = $user;
			$rows = $database->Query('SELECT security_model FROM public.users WHERE user_id = $1;', $userId);
			if ($rows->RecordCount() !== 1) {
				return [];
			}
			$securityModel = $rows->Field('security_model');
		} else {
			$userId = $user->UserId();
			$securityModel = $user->SecurityModel();
		}

		switch ($securityModel) {
		case User::SecurityModelLegacy:
			$database->BeginTransaction();
			$rows = $database->Query('SELECT COUNT(*) AS authenticator_count FROM public.user_authenticators WHERE user_id = $1;', $userId);
			if ($rows->Field('authenticator_count') === 0) {
				$database->Rollback();
				return [];
			}
			$database->Query('DELETE FROM public.user_authenticators WHERE user_id = $1;', $userId);
			$backupCodes = [];
			while (count($backupCodes) < 10) {
				$code = BeaconCommon::GenerateRandomKey(6);
				$backupCodes[] = $code;
				$database->Query('INSERT INTO public.user_backup_codes (user_id, code) VALUES ($1, $2);', $userId, $code);
			}
			$database->Commit();
			return $backupCodes;
		default:
			$credential = UserCredential::GetPasswordRecord($userId);
			if (is_null($credential)) {
				return [];
			}
			$metadata = $credential->Metadata();
			$backupCodes = [];
			while (count($backupCodes) < 10) {
				$backupCodes[] = BeaconCommon::GenerateRandomKey(6);
			}
			$metadata['backupCodes'] = (array)$backupCodes;
			try {
				$credential->Edit(['metadata' => $metadata]);
			} catch (Exception $err) {
				$database->Rollback();
				throw $err;
			}
			$database->Commit();
			return $backupCodes;
		}

		return [];
	}

	public static function VerifyCode(string|User $user, string $code, int $options): bool {
		if (is_string($user)) {
			$userId = $user;
			$user = User::Fetch($userId);
		} else {
			$userId = $user->UserId();
		}

		$authenticators = static::FetchForUser($user);
		if (count($authenticators) === 0) {
			return true;
		}

		// If it's a UUID, it has to be a trusted device id
		if (($options & self::VerifyOptionAllowTrustedDevices) === self::VerifyOptionAllowTrustedDevices) {
			if (BeaconCommon::IsUUID($code) === true) {
				return $user->IsDeviceTrusted($code);
			}
		}

		// Check authenticators first
		if (($options & self::VerifyOptionAllowTOTP) === self::VerifyOptionAllowTOTP) {
			foreach ($authenticators as $authenticator) {
				if ($authenticator->TestCode($code)) {
					return true;
				}
			}
		}

		// Finally check backup codes
		if (($options & self::VerifyOptionAllowBackupCodes) === self::VerifyOptionAllowBackupCodes) {
			$database = BeaconCommon::Database();
			$replaceCode = ($options & self::VerifyOptionReplaceUsedCode);
			switch ($user->SecurityModel()) {
			case User::SecurityModelLegacy:
				$rows = $database->Query('SELECT code FROM public.user_backup_codes WHERE user_id = $1 AND code = $2;', $userId, $code);
				if ($rows->RecordCount() === 1) {
					if ($replaceCode) {
						$database->BeginTransaction();
						$database->Query('DELETE FROM public.user_backup_codes WHERE user_id = $1 AND code = $2;', $userId, $code);
						$database->Query('INSERT INTO public.user_backup_codes (user_id, code) VALUES ($1, $2);', $userId, BeaconCommon::GenerateRandomKey(6));
						$database->Commit();
					}
					return true;
				}
				break;
			default:
				$credential = UserCredential::GetPasswordRecord($userId);
				if (is_null($credential) === false) {
					$metadata = $credential->Metadata();
					$backupCodes = $metadata['backupCodes'] ?? [];
					$codeIndex = array_search($code, $backupCodes, true);
					if ($codeIndex !== false) {
						if ($replaceCode) {
							array_splice($backupCodes, $codeIndex, 1);
							$backupCodes[] = BeaconCommon::GenerateRandomKey(6);
							$metadata['backupCodes'] = (array)$backupCodes;

							$credential->Edit(['metadata' => $metadata]);
						}
						return true;
					}
				}
				break;
			}
		}

		return false;
	}

	protected function __construct(string $authenticatorId, string $username, string $type, string $nickname, float $dateAdded, array $metadata) {
		$this->authenticatorId = $authenticatorId;
		$this->username = $username;
		$this->type = $type;
		$this->nickname = $nickname;
		$this->dateAdded = $dateAdded;
		$this->metadata = $metadata;
	}

	public static function UserHasAuthenticators(string|User $user): bool {
		if (is_string($user)) {
			$userId = $user;
		} else {
			$userId = $user->UserId();
		}

		$authenticators = static::FetchForUser($userId);
		return count($authenticators) > 0;
	}

	// Deprecated
	public static function UserIdHasAuthenticators(string $userId): bool {
		return static::UserHasAuthenticators($userId);
	}

	public function AuthenticatorId(): string {
		return $this->authenticatorId;
	}

	public function AccountName(): string {
		return $this->username;
	}

	public function Type(): string {
		return $this->type;
	}

	public function Nickname(): string {
		return $this->nickname;
	}

	public function DateAdded(): float {
		return $this->dateAdded;
	}

	public function TestCode(string $code): bool {
		switch ($this->type) {
		case self::TYPE_TOTP:
			if (strlen($code) !== 6) {
				return false;
			}

			$secret = $this->metadata['secret'];
			$decoded = BeaconCommon::Base32Decode($secret);
			$now = time();
			$future = $now + 30;
			$past = $now - 30;
			return ($code === static::GenerateTOTP($now, $decoded) || $code === static::GenerateTOTP($past, $decoded) || $code === static::GenerateTOTP($future, $decoded));
		}

		return false;
	}

	protected static function GenerateTOTP(int $timestamp, string $decoded_secret): string {
		$timestamp = floor($timestamp / 30);
		$binary = pack('N*', 0) . pack('N*', $timestamp);
		$hash = hash_hmac('sha1', $binary, $decoded_secret, true);
		$offset = ord($hash[19]) & 0xf;
		$code = (((ord($hash[$offset]) & 0x7f) << 24) | ((ord($hash[$offset + 1]) & 0xff) << 16) | ((ord($hash[$offset + 2]) & 0xff) << 8) | (ord($hash[$offset + 3]) & 0xff)) % pow(10, 6);
		return str_pad($code, 6, '0', STR_PAD_LEFT);
	}

	public static function SetupUrl(string $secret, string $accountName): string {
		return 'otpauth://totp/' . urlencode('Beacon:' . $accountName) . '?secret=' . $secret . '&issuer=Beacon';
	}

	public function jsonSerialize(): mixed {
		return [
			'authenticatorId' => $this->authenticatorId,
			'type' => $this->type,
			'nickname' => $this->nickname,
			'dateAdded' => $this->dateAdded,
			'metadata' => $this->metadata,
		];
	}
}

?>
