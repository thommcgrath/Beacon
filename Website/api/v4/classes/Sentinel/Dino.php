<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRecordSet, JsonSerializable;

class Dino extends DatabaseObject implements JsonSerializable {
	protected string $dinoId;
	protected string $dinoNumber;
	protected string $dinoNumber64;
	protected string $dinoName;
	protected string $dinoSpecies;
	protected string $dinoSpeciesPath;
	protected int $dinoLevel;
	protected float $dinoAge;
	protected bool $dinoIsDead;
	protected bool $dinoIsFrozen;
	protected bool $dinoIsUploaded;
	protected string $serviceId;
	protected string $serviceDisplayName;
	protected string $serviceColor;
	protected string $tribeId;
	protected string $tribeName;
	protected ?string $cryopodData;

	public function __construct(BeaconRecordSet $row) {
		$this->dinoId = $row->Field('dino_id');
		$this->dinoName = $row->Field('dino_name');
		$this->dinoNumber = $row->Field('dino_number');
		$this->dinoNumber64 = $row->Field('dino_number_64');
		$this->dinoSpecies = $row->Field('dino_species');
		$this->dinoSpeciesPath = $row->Field('dino_species_path');
		$this->dinoLevel = $row->Field('dino_level');
		$this->dinoAge = $row->Field('dino_age');
		$this->dinoIsDead = $row->Field('dino_is_dead');
		$this->dinoIsFrozen = $row->Field('dino_is_frozen');
		$this->dinoIsUploaded = $row->Field('dino_is_uploaded');
		$this->tribeId = $row->Field('tribe_id');
		$this->tribeName = $row->Field('tribe_name');
		$this->serviceId = $row->Field('service_id');
		$this->serviceDisplayName = $row->Field('service_display_name');
		$this->serviceColor = $row->Field('service_color');
		$this->cryopodData = $row->Field('cryopod_data');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'sentinel',
			table: 'dinos',
			definitions: [
				new DatabaseObjectProperty('dinoId', ['columnName' => 'dino_id', 'primaryKey' => true, 'required' => false]),
				new DatabaseObjectProperty('dinoNumber', ['columnName' => 'dino_number', 'accessor' => 'dinos.visual_dino_number']),
				new DatabaseObjectProperty('dinoNumber64', ['columnName' => 'dino_number_64', 'accessor' => 'dinos.dino_number']),
				new DatabaseObjectProperty('dinoName', ['columnName' => 'dino_name', 'accessor' => 'dinos.name']),
				new DatabaseObjectProperty('dinoSpecies', ['columnName' => 'dino_species', 'accessor' => 'dinos.species']),
				new DatabaseObjectProperty('dinoSpeciesPath', ['columnName' => 'dino_species_path', 'accessor' => 'dinos.species_path']),
				new DatabaseObjectProperty('dinoLevel', ['columnName' => 'dino_level', 'accessor' => 'dinos.level']),
				new DatabaseObjectProperty('dinoAge', ['columnName' => 'dino_age', 'accessor' => 'dinos.age']),
				new DatabaseObjectProperty('dinoIsDead', ['columnName' => 'dino_is_dead', 'accessor' => 'dinos.is_dead']),
				new DatabaseObjectProperty('dinoIsFrozen', ['columnName' => 'dino_is_frozen', 'accessor' => 'dinos.is_frozen']),
				new DatabaseObjectProperty('dinoIsUploaded', ['columnName' => 'dino_is_uploaded', 'accessor' => 'dinos.is_uploaded']),
				new DatabaseObjectProperty('serviceId', ['columnName' => 'service_id', 'accessor' => 'services.service_id']),
				new DatabaseObjectProperty('serviceDisplayName', ['columnName' => 'service_display_name', 'accessor' => 'services.display_name']),
				new DatabaseObjectProperty('serviceColor', ['columnName' => 'service_color', 'accessor' => 'services.color']),
				new DatabaseObjectProperty('tribeId', ['columnName' => 'tribe_id', 'accessor' => 'tribes.tribe_id']),
				new DatabaseObjectProperty('tribeName', ['columnName' => 'tribe_name', 'accessor' => 'tribes.name']),
				new DatabaseObjectProperty('cryopodData', ['columnName' => 'cryopod_data', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever]),
			],
			joins: [
				'INNER JOIN sentinel.services ON (dinos.service_id = services.service_id)',
				'INNER JOIN sentinel.tribes ON (dinos.tribe_id = tribes.tribe_id)',
				'INNER JOIN sentinel.service_permissions ON (dinos.service_id = service_permissions.service_id AND service_permissions.user_id = %%USER_ID%%)',
			],
		);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$sortDirection = (isset($filters['sortDirection']) && strtolower($filters['sortDirection']) === 'descending') ? 'DESC' : 'ASC';
		$sortColumn = 'dinoName';
		if (isset($filters['sortedColumn'])) {
			switch ($filters['sortedColumn']) {
			case 'dinoName':
			case 'serviceDisplayName':
			case 'tribeName':
			case 'dinoNumber':
				$sortColumn = $filters['sortedColumn'];
				break;
			}
		}
		$parameters->orderBy = $schema->Accessor($sortColumn) . ' ' . $sortDirection;
		$parameters->allowAll = true;
		$parameters->AddFromFilter($schema, $filters, 'dinoName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'dinoNumber');
		$parameters->AddFromFilter($schema, $filters, 'serviceId');
		$parameters->AddFromFilter($schema, $filters, 'serviceDisplayName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'tribeName', 'ILIKE');
		$parameters->AddFromFilter($schema, $filters, 'dinoIsDead');

		if (isset($filters['tribeId'])) {
			$placeholder = $parameters->AddValue($filters['tribeId']);
			$parameters->clauses[] = '(' . $schema->Accessor('tribeId') . ' = $' . $placeholder . ' OR ' . $schema->Accessor('dinoId') . ' IN (SELECT dino_id FROM sentinel.tribe_dinos WHERE tribe_id = $' . $placeholder . '))';
		}
	}

	public function jsonSerialize(): mixed {
		return [
			'dinoId' => $this->dinoId,
			'dinoNumber' => $this->dinoNumber,
			'dinoName' => $this->dinoName,
			'dinoSpecies' => $this->dinoSpecies,
			'dinoSpeciesPath' => $this->dinoSpeciesPath,
			'dinoLevel' => $this->dinoLevel,
			'dinoAge' => $this->dinoAge,
			'dinoIsDead' => $this->dinoIsDead,
			'dinoIsFrozen' => $this->dinoIsFrozen,
			'dinoIsUploaded' => $this->dinoIsUploaded,
			'dinoRestoreEligible' => $this->RestoreEligible(),
			'serviceId' => $this->serviceId,
			'serviceDisplayName' => $this->serviceDisplayName,
			'serviceColor' => $this->serviceColor,
			'tribeId' => $this->tribeId,
			'tribeName' => $this->tribeName,
		];
	}

	public static function SetupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
		$requiredScopes[] = Application::kScopeSentinelRead;
		if ($editable) {
			$requiredScopes[] = Application::kScopeSentinelWrite;
		}
	}

	public function ServiceId(): string {
		return $this->serviceId;
	}

	public function DinoNumberParts(): array {
		$high = bcdiv($this->dinoNumber64, bcpow("2", "32"), 0);
		$low = bcmod($this->dinoNumber64, bcpow("2", "32"));
		return [(int)$high, (int)$low];
	}

	public function RestoreEligible(): bool {
		return $this->dinoIsDead && is_null($this->cryopodData) === false;
	}

	public function CryopodData(): ?array {
		if (is_null($this->cryopodData)) {
			return null;
		}
		return json_decode(gzdecode($this->cryopodData), true);
	}

	public function DescriptiveName(): string {
		if (empty($this->dinoName)) {
			return "{$this->dinoSpecies} - Level {$this->dinoLevel}";
		} else {
			return $this->dinoName;
		}
	}
}

?>
