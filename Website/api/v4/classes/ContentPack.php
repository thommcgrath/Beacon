<?php

namespace BeaconAPI\v4;
use BeaconCommon, BeaconRecordSet, BeaconUUID, BeaconWorkshopItem, Exception, JsonSerializable;

class ContentPack extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject {
		Validate as protected MutableDatabaseObjectValidate;
	}

	protected string $contentPackId;
	protected string $gameId;
	protected string $marketplace;
	protected string $marketplaceId;
	protected string $userId;
	protected string $name;
	protected bool $isConfirmed;
	protected string $confirmationCode;
	protected bool $isConsoleSafe;
	protected bool $isDefaultEnabled;
	protected int $minVersion;
	protected int $lastUpdate;
	protected bool $isOfficial;
	protected bool $isIncludedInDeltas;
	protected array $gameSpecific;

	protected function __construct(BeaconRecordSet $row) {
		$this->contentPackId = $row->Field('content_pack_id');
		$this->gameId = $row->Field('game_id');
		$this->marketplace = $row->Field('marketplace');
		$this->marketplaceId = $row->Field('marketplace_id');
		$this->userId = $row->Field('user_id');
		$this->name = $row->Field('name');
		$this->isConfirmed = filter_var($row->Field('confirmed'), FILTER_VALIDATE_BOOL);
		$this->confirmationCode = $row->Field('confirmation_code');
		$this->isConsoleSafe = filter_var($row->Field('console_safe'), FILTER_VALIDATE_BOOL);
		$this->isDefaultEnabled = filter_var($row->Field('default_enabled'), FILTER_VALIDATE_BOOL);
		$this->minVersion = intval($row->Field('min_version'));
		$this->lastUpdate = round($row->Field('last_update'));
		$this->isOfficial = filter_var($row->Field('is_official'), FILTER_VALIDATE_BOOL);
		$this->isIncludedInDeltas = filter_var($row->Field('include_in_deltas'), FILTER_VALIDATE_BOOL);
		$this->gameSpecific = json_decode($row->Field('game_specific'), true);
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('public', 'content_packs', [
			new DatabaseObjectProperty('contentPackId', ['primaryKey' => true, 'columnName' => 'content_pack_id']),
			new DatabaseObjectProperty('gameId', ['columnName' => 'game_id']),
			new DatabaseObjectProperty('marketplace'),
			new DatabaseObjectProperty('marketplaceId', ['columnName' => 'marketplace_id']),
			new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
			new DatabaseObjectProperty('name', ['editable' => DatabaseObjectProperty::kEditableAlways]),
			new DatabaseObjectProperty('isConfirmed', ['columnName' => 'confirmed', 'editable' => DatabaseObjectProperty::kEditableNever]),
			new DatabaseObjectProperty('confirmationCode', ['columnName' => 'confirmation_code', 'editable' => DatabaseObjectProperty::kEditableNever]),
			new DatabaseObjectProperty('isConsoleSafe', ['columnName' => 'console_safe', 'editable' => DatabaseObjectProperty::kEditableNever]),
			new DatabaseObjectProperty('isDefaultEnabled', ['columnName' => 'default_enabled', 'editable' => DatabaseObjectProperty::kEditableNever]),
			new DatabaseObjectProperty('minVersion', ['columnName' => 'min_version', 'editable' => DatabaseObjectProperty::kEditableNever]),
			New DatabaseObjectProperty('lastUpdate', ['columnName' => 'last_update', 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)', 'setter' => 'TO_TIMESTAMP(%%PLACEHOLDER%%)', 'editable' => DatabaseObjectProperty::kEditableNever]),
			new DatabaseObjectProperty('isOfficial', ['columnName' => 'is_official', 'editable' => DatabaseObjectProperty::kEditableNever]),
			new DatabaseObjectProperty('isIncludedInDeltas', ['columnName' => 'include_in_deltas', 'editable' => DatabaseObjectProperty::kEditableNever]),
			new DatabaseObjectProperty('gameSpecific', ['columnName' => 'game_specific', 'editable' => DatabaseObjectProperty::kEditableNever])
		]);
	}

	public static function Fetch(string $uuid): ?static {
		if (BeaconCommon::IsUUID($uuid)) {
			return parent::Fetch($uuid);
		} else {
			$packs = static::Search(['marketplaceId' => $uuid], true);
			if (count($packs) === 1) {
				return $packs[0];
			}
		}
		return null;
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$table = $schema->table();

		$parameters->AddFromFilter($schema, $filters, 'userId', '=');
		$parameters->AddFromFilter($schema, $filters, 'isConfirmed', '=');
		$parameters->AddFromFilter($schema, $filters, 'isOfficial', '=');
		$parameters->AddFromFilter($schema, $filters, 'isIncludedInDeltas', '=');
		$parameters->AddFromFilter($schema, $filters, 'lastUpdate', '>');
		$parameters->AddFromFilter($schema, $filters, 'marketplace', '=');
		$parameters->AddFromFilter($schema, $filters, 'marketplaceId', '=');
		$parameters->AddFromFilter($schema, $filters, 'gameId', '=');

		if (isset($filters['contentPackId']) && BeaconCommon::IsUUID($filters['contentPackId']) === true) {
			$parameters->clauses[] = $schema->Comparison('contentPackId', '=', $parameters->placeholder++);
			$parameters->values[] = $filters['contentPackId'];
		}

		$parameters->allowAll = true;
		$parameters->orderBy = $schema->Accessor('name');
	}

	public static function GetNewObjectPermissionsForUser(User $user, ?array $newObjectProperties): int {
		return static::kPermissionRead | static::kPermissionCreate;
	}

	public function GetPermissionsForUser(User $user): int {
		if ($this->userId === $user->UserId()) {
			return static::kPermissionAll;
		} else {
			return static::kPermissionRead;
		}
	}

	public static function GenerateLocalId(string $marketplace, string $marketplaceId): string {
		return BeaconUUID::v5('Local ' . $marketplace . ': ' . $marketplaceId);
	}

	protected static function Validate(array $properties): void {
		static::MutableDatabaseObjectValidate($properties);

		$validMarketplaces = [];
		switch ($properties['gameId']) {
		case 'Ark':
			$validMarketplaces = ['Steam Workshop'];
			break;
		default:
			throw new Exception('Property gameId should be one of: ' . BeaconCommon::ArrayToEnglish(['Ark']) . '.');
		}
		if (in_array($properties['marketplace'], $validMarketplaces) === false) {
			throw new Exception('Property marketplace should be one of: ' . BeaconCommon::ArrayToEnglish($validMarketplaces) . '.');
		}

		if ($properties['contentPackId'] === static::GenerateLocalId($properties['marketplace'], $properties['marketplaceId'])) {
			throw new Exception('This contentPackId is reserved for local content packs.');
		}
	}

	/*public static function Create(array $propertyValues): ?static {
		$requiredKeys = ['marketplace', 'marketplaceId', 'gameId', 'name'];
		if (BeaconCommon::HasAllKeys($propertyValues, ...$requiredKeys) === false) {
			throw new Exception('Properties ' . BeaconCommon::ArrayToEnglish($requiredKeys) . ' keys are required.');
		}

		$marketplace = $propertyValues['marketplace'];
		$marketplaceId = $propertyValues['marketplaceId'];
		$gameId = $propertyValues['gameId'];
		$userId = $propertyValues['userId'];
		$name = $propertyValues['name'];

		$validMarketplaces = [];
		switch ($gameId) {
		case 'Ark':
			$validMarketplaces = ['Steam Workshop'];
			break;
		default:
			throw new Exception('Property gameId should be one of: ' . BeaconCommon::ArrayToEnglish(['Ark']) . '.');
		}
		if (in_array($marketplace, $validMarketplaces) === false) {
			throw new Exception('Property marketplace should be one of: ' . BeaconCommon::ArrayToEnglish($validMarketplaces) . '.');
		}

		if (isset($propertyValues['contentPackId'])) {
			$contentPackId = strtolower($propertyValues['contentPackId']);
			if ($contentPackId === static::GenerateLocalId($marketplace, $marketplaceId)) {
				throw new Exception('This contentPackId is reserved for local content packs.');
			}
		} else {
			$contentPackId = BeaconUUID::v4();
		}

		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('INSERT INTO public.content_packs (content_pack_id, marketplace, marketplace_id, game_id, user_id, name, console_safe, default_enabled, min_version, include_in_deltas, is_official) VALUES ($1, $2, $3, $4, $5, $6, FALSE, FALSE, 10500000, FALSE, FALSE);', $contentPackId, $marketplace, $marketplaceId, $gameId, $userId, $name);
		$database->Commit();

		return static::Fetch($contentPackId);
	}*/

	public function ContentPackId(): string {
		return $this->contentPackId;
	}

	public function GameId(): string {
		return $this->gameId;
	}

	public function Marketplace(): string {
		return $this->marketplace;
	}

	public function MarketplaceId(): string {
		return $this->marketplaceId;
	}

	public function MarketplaceUrl(): string {
		switch ($this->marketplace) {
		case 'Steam':
			return "https://store.steampowered.com/app/{$this->marketplaceId}";
		case 'Steam Workshop':
			return "https://steamcommunity.com/sharedfiles/filedetails/?id={$this->marketplaceId}";
		default:
			return '';
		}
	}

	public function UserId(): string {
		return $this->userId;
	}

	public function Name(): string {
		return $this->name;
	}

	// Should be IsConfirmed
	public function Confirmed(): bool {
		return $this->isConfirmed;
	}

	public function IsConfirmed(): bool {
		return $this->isConfirmed;
	}

	public function ConfirmationCode(): string {
		return $this->confirmationCode;
	}

	public function MinVersion(): int {
		return $this->minVersion;
	}

	public function IsIncludedInDeltas(): bool {
		return $this->isIncludedInDeltas;
	}

	public function IsOfficial(): bool {
		return $this->isOfficial;
	}

	public function GameSpecific(): array {
		return $this->gameSpecific;
	}

	public function IsConsoleSafe(): bool {
		return $this->isConsoleSafe;
	}

	public function AttemptConfirmation(): bool {
		switch ($this->marketplace) {
		case 'Steam Workshop':
			$workshop_item = BeaconWorkshopItem::Load($this->marketplaceId);
			if (is_null($workshop_item)) {
				return false;
			}
			if (BeaconCommon::InDevelopment() || $workshop_item->ContainsString($this->confirmationCode)) {
				$database = BeaconCommon::Database();
				$database->BeginTransaction();
				$database->Query('UPDATE public.content_packs SET confirmed = TRUE WHERE content_pack_id = $1;', $this->contentPackId);
				$database->Commit();
				$this->isConfirmed = true;
				return true;
			}
			break;
		}

		return false;
	}

	public function jsonSerialize(): mixed {
		return [
			'contentPackId' => $this->contentPackId,
			'gameId' => $this->gameId,
			'marketplace' => $this->marketplace,
			'marketplaceId' => $this->marketplaceId,
			'marketplaceUrl' => $this->MarketplaceUrl(),
			'userId' => $this->userId,
			'name' => $this->name,
			'isConfirmed' => $this->isConfirmed,
			'isConsoleSafe' => $this->isConsoleSafe,
			'isDefaultEnabled' => $this->isDefaultEnabled,
			'isIncludedInDeltas' => $this->isIncludedInDeltas,
			'isOfficial' => $this->isOfficial,
			'confirmationCode' => $this->confirmationCode,
			'minVersion' => $this->minVersion,
			'lastUpdate' => $this->lastUpdate,
			'gameSpecific' => $this->gameSpecific
		];
	}
}

?>
