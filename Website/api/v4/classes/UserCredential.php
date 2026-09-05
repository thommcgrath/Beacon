<?php

namespace BeaconAPI\v4;
use BeaconCommon, BeaconEncryption, BeaconRecordSet, Exception, JsonSerializable;

class UserCredential extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject {
		PreparePropertyValue as protected MutableDatabaseObjectPreparePropertyValue;
	}

	const TypePassword = 'Password';
	const TypePasskey = 'Passkey';

	protected string $credentialId = '';
	protected string $userId = '';
	protected string $type = '';
	protected string $name = '';
	protected float $dateAdded = 0;
	protected float $dateModified = 0;
	protected array $metadata = [];

	public function __construct(BeaconRecordSet $row) {
		$this->credentialId = $row->Field('credential_id');
		$this->userId = $row->Field('user_id');
		$this->type = $row->Field('type');
		$this->name = $row->Field('name');
		$this->dateAdded = floatval($row->Field('date_added'));
		$this->dateModified = floatval($row->Field('date_modified'));

		$metadataKey = base64_decode(BeaconCommon::GetGlobal('Credential Secret'));
		$metadata = BeaconEncryption::SymmetricDecrypt($metadataKey, $row->Field('metadata'));
		if (BeaconCommon::IsCompressed($metadata)) {
			$metadata = gzdecode($metadata);
		}
		$this->metadata = json_decode($metadata, true);
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('public', 'user_credentials', [
			new DatabaseObjectProperty('credentialId', ['primaryKey' => true, 'columnName' => 'credential_id', 'required' => false]),
			new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
			new DatabaseObjectProperty('type'),
			new DatabaseObjectProperty('name', ['editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('dateAdded', ['columnName' => 'date_added', 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)', 'setter' => 'TO_TIMESTAMP(%%PLACEHOLDER%%)', 'editable' => DatabaseObjectProperty::kEditableNever]),
			new DatabaseObjectProperty('dateModified', ['columnName' => 'date_modified', 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)', 'setter' => 'TO_TIMESTAMP(%%PLACEHOLDER%%)', 'editable' => DatabaseObjectProperty::kEditableNever]),
			new DatabaseObjectProperty('metadata', ['editable' => DatabaseObjectProperty::kEditableAlways, 'setter' => 'decode(%%PLACEHOLDER%%, \'hex\')']),
		]);
	}

	public function jsonSerialize(): mixed {
		$json = [
			'credentialId' => $this->credentialId,
			'userId' => $this->userId,
			'type' => $this->type,
			'name' => $this->name,
			'dateAdded' => $this->dateAdded,
			'dateModified' => $this->dateModified,
			'metadata' => $this->metadata,
		];
		return $json;
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();

		if (isset($filters['userId']) === false) {
			throw new Exception('Must include userId filter');
		}

		$parameters->AddFromFilter($schema, $filters, 'userId');
		$parameters->AddFromFilter($schema, $filters, 'type');
	}

	public static function GetPasswordRecord(string $userId): ?static {
		$records = static::Search(['userId' => $userId, 'type' => self::TypePassword], true);
		if (count($records) === 1) {
			return $records[0];
		} else {
			return null;
		}
	}

	public function CredentialId(): string {
		return $this->credentialId;
	}

	public function UserId(): string {
		return $this->userId;
	}

	public function Type(): string {
		return $this->type;
	}

	public function Name(): string {
		return $this->name;
	}

	public function DateAdded(): float {
		return $this->dateAdded;
	}

	public function DateModified(): float {
		return $this->dateModified;
	}

	public function Metadata(): array {
		return $this->metadata;
	}

	public function SetMetadata(array $metadata): void {
		$this->SetProperty('metadata', $metadata);
	}

	protected static function PreparePropertyValue(DatabaseObjectProperty $definition, mixed $value, array $otherProperties): mixed {
		switch ($definition->PropertyName()) {
		case 'metadata':
			$metadataKey = base64_decode(BeaconCommon::GetGlobal('Credential Secret'));
			return bin2hex(BeaconEncryption::SymmetricEncrypt($metadataKey, gzencode(json_encode($value)), false));
		default:
			return static::MutableDatabaseObjectPreparePropertyValue($definition, $value, $otherProperties);
		}
	}

	public static function SetUserPassword(string $userId, string $password): static {
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$credential = static::GetPasswordRecord($userId);
		if (is_null($credential)) {
			// Look for and migrate legacy authenticators
			$authRows = $database->Query('SELECT authenticator_id, type, nickname, EXTRACT(EPOCH FROM date_added) AS date_added, metadata->>\'secret\' AS secret FROM public.user_authenticators WHERE user_id = $1 ORDER BY date_added DESC;', $userId);
			$authenticators = [];
			while (!$authRows->EOF()) {
				$authenticators[] = [
					'authenticatorId' => $authRows->Field('authenticator_id'),
					'type' => $authRows->Field('type'),
					'nickname' => $authRows->Field('nickname'),
					'dateAdded' => floatval($authRows->Field('date_added')),
					'metadata' => [
						'secret' => $authRows->Field('secret')
					],
				];
				$authRows->MoveNext();
			}
			$database->Query('DELETE FROM public.user_authenticators WHERE user_id = $1;', $userId);

			$codeRows = $database->Query('SELECT code FROM public.user_backup_codes WHERE user_id = $1;', $userId);
			$backupCodes = [];
			while (!$codeRows->EOF()) {
				$backupCodes[] = $codeRows->Field('code');
				$codeRows->MoveNext();
			}
			$database->Query('DELETE FROM public.user_backup_codes WHERE user_id = $1;', $userId);

			$credentialData = [
				'userId' => $userId,
				'type' => self::TypePassword,
				'name' => 'Password',
				'metadata' => [
					'hash' => BeaconEncryption::GeneratePasswordHash($password),
					'authenticators' => (array)$authenticators,
					'backupCodes' => (array)$backupCodes,
				],
			];
			try {
				$credential = static::Create($credentialData);
			} catch (Exception $err) {
				$database->Rollback();
				throw $err;
			}
		} else {
			$metadata = $credential->Metadata();
			$metadata['hash'] = BeaconEncryption::GeneratePasswordHash($password);
			try {
				$credential->Edit(['metadata' => $metadata]);
			} catch (Exception $err) {
				$database->Rollback();
				throw $err;
			}
		}
		$database->Commit();
		return $credential;
	}

	public static function VerifyUserPassword(string $userId, string $password): bool {
		$credential = static::GetPasswordRecord($userId);
		if (is_null($credential)) {
			return false;
		}
		$metadata = $credential->Metadata();
		$hash = $metadata['hash'];
		if (BeaconEncryption::VerifyPasswordHash($password, $hash) === false) {
			return false;
		}
		return true;
	}

	public static function CreatePasskey(string $userId, string $passkeyId, string $passkeyName, string $passkeyData): static {
		$credentialData = [
			'credentialId' => $passkeyId,
			'userId' => $userId,
			'type' => self::TypePasskey,
			'name' => $passkeyName,
			'metadata' => json_decode($passkeyData, true),
		];
		return static::Create($credentialData);
	}
}

?>
