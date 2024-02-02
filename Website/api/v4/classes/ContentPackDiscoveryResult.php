<?php

namespace BeaconAPI\v4;
use BeaconCommon, BeaconRecordSet, JsonSerializable;

class ContentPackDiscoveryResult extends DatabaseObject implements JsonSerializable {
	protected string $contentPackId;
	protected string $gameId;
	protected string $marketplace;
	protected string $marketplaceId;
	protected string $name;
	protected int $lastUpdate;
	protected int $minVersion;
	protected string $storagePath;
	protected bool $deleted;

	protected function __construct(BeaconRecordSet $row) {
		$this->contentPackId = $row->Field('content_pack_id');
		$this->gameId = $row->Field('game_id');
		$this->marketplace = $row->Field('marketplace');
		$this->marketplaceId = $row->Field('marketplace_id');
		$this->name = $row->Field('name');
		$this->lastUpdate = round($row->Field('last_update'));
		$this->minVersion = $row->Field('min_version');
		$this->storagePath = $row->Field('storage_path');
		$this->deleted = $row->Field('deleted');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema('public', 'content_pack_discovery_results', [
			new DatabaseObjectProperty('contentPackId', ['primaryKey' => true, 'columnName' => 'content_pack_id']),
			new DatabaseObjectProperty('gameId', ['columnName' => 'game_id']),
			new DatabaseObjectProperty('marketplace'),
			new DatabaseObjectProperty('marketplaceId', ['columnName' => 'marketplace_id']),
			new DatabaseObjectProperty('name'),
			new DatabaseObjectProperty('lastUpdate', ['columnName' => 'last_update', 'accessor' => 'EXTRACT(EPOCH FROM %%TABLE%%.%%COLUMN%%)', 'setter' => 'TO_TIMESTAMP(%%PLACEHOLDER%%)']),
			new DatabaseObjectProperty('minVersion', ['columnName' => 'min_version']),
			new DatabaseObjectProperty('storagePath', ['columnName' => 'storage_path']),
			new DatabaseObjectProperty('deleted')
		]);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->orderBy = $schema->Table() . '.name';
		$parameters->AddFromFilter($schema, $filters, 'gameId');
		$parameters->AddFromFilter($schema, $filters, 'marketplace');
		$parameters->AddFromFilter($schema, $filters, 'marketplaceId');
		$parameters->AddFromFilter($schema, $filters, 'lastUpdate', '>');
		$parameters->allowAll = true;

		if (isset($filters['search']) && empty($filters['search']) === false) {
			$searchValue = '%' . str_replace(['%', '_'], ['\\%', '\\_'], trim($filters['search'])) . '%';
			$parameters->clauses[] = $schema->Accessor('name') . ' LIKE $' . $parameters->AddValue($searchValue);
		}
	}

	public function jsonSerialize(): mixed {
		return [
			'contentPackId' => $this->contentPackId,
			'gameId' => $this->gameId,
			'marketplace' => $this->marketplace,
			'marketplaceId' => $this->marketplaceId,
			'name' => $this->name,
			'lastUpdate' => $this->lastUpdate,
			'minVersion' => $this->minVersion
		];
	}

	public static function Save(array $contentPackInfo, string $gameId): ?static {
		if (BeaconCommon::HasAllKeys($contentPackInfo, 'contentPackId', 'marketplace', 'marketplaceId', 'name', 'minVersion', 'lastUpdate') === false) {
			return null;
		}

		$gameId = BeaconCommon::StandardizeGameId($gameId);
		$contentPackId = strtolower($contentPackInfo['contentPackId']);
		$marketplace = $contentPackInfo['marketplace'];
		$marketplaceId = $contentPackInfo['marketplaceId'];
		$lastUpdate = $contentPackInfo['lastUpdate'];

		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT game_id, marketplace, marketplace_id, EXTRACT(EPOCH FROM last_update) AS last_update FROM public.content_pack_discovery_results WHERE content_pack_id = $1;', $contentPackId);
		if ($rows->RecordCount() === 0) {
			$storagePath = '/Discovery/' . $contentPackId . '.beacondata';
			$database->BeginTransaction();
			$database->Query('INSERT INTO public.content_pack_discovery_results (content_pack_id, game_id, marketplace, marketplace_id, name, last_update, min_version, storage_path) VALUES ($1, $2, $3, $4, $5, TO_TIMESTAMP($6), $7, $8);', $contentPackId, $gameId, $marketplace, $marketplaceId, $contentPackInfo['name'], $lastUpdate, $contentPackInfo['minVersion'], $storagePath);
			$database->Commit();
			return static::Fetch($contentPackId);
		}

		if ($rows->Field('game_id') !== $gameId || $rows->Field('marketplace') !== $marketplace || $rows->Field('marketplace_id') !== $marketplaceId || $rows->Field('last_update') > $lastUpdate) {
			return null;
		}

		$database->BeginTransaction();
		$database->Query('UPDATE public.content_pack_discovery_results SET name = $2, last_update = TO_TIMESTAMP($3), min_version = $4 WHERE content_pack_id = $1;', $contentPackId, $contentPackInfo['name'], $lastUpdate, $contentPackInfo['minVersion']);
		$database->Commit();
		return static::Fetch($contentPackId);
	}

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

	public function Name(): string {
		return $this->name;
	}

	public function LastUpdate(): int {
		return $this->last_update;
	}

	public function MinVersion(): int {
		return $this->min_version;
	}

	public function StoragePath(): string {
		return $this->storagePath;
	}

	public function Deleted(): bool {
		return $this->deleted;
	}

	public function Delete(): void {
		$schema = static::DatabaseSchema();
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('UPDATE ' . $schema->WriteableTable() . ' SET deleted = TRUE WHERE ' . $schema->PrimaryColumn()->ColumnName() . ' = ' . $schema->PrimarySetter('$1') . ';', $this->ContentPackId());
		$database->Commit();
	}
}

?>
