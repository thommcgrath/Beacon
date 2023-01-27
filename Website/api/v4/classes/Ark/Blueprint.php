<?php
	
namespace BeaconAPI\v4\Ark;
use BeaconAPI\v4\{DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters};
use BeaconCommon, BeaconRecordSet, DateTime;

class Blueprint extends GenericObject {
	protected $availability;
	protected $path;
	protected $classString;
	
	protected function __construct(BeaconRecordSet $row) {
		parent::__construct($row);
		
		$this->availability = $row->Field('availability');
		$this->path = $row->Field('path');
		$this->classString = $row->Field('class_string');	
	}
	
	protected static function CustomVariablePrefix(): string {
		return 'blueprint';
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		$schema = parent::BuildDatabaseSchema();
		$schema->SetTable('blueprints');
		$schema->AddColumns([
			'availability',
			'path',
			new DatabaseObjectProperty('classString', ['columnName' => 'class_string'])
		]);
		return $schema;
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters): void {
		parent::BuildSearchParameters($parameters, $filters);
			
		$schema = static::DatabaseSchema();
		$parameters->AddFromFilter($schema, $filters, 'path');
		$parameters->AddFromFilter($schema, $filters, 'classString');
		
		if (isset($filters['availability'])) {
			$availabilityProperty = $schema->Property('availability');
			$parameters->clauses[] = '(' . $schema->Accessor($availabilityProperty) . ' & ' . $schema->Setter($availabilityProperty, $parameters->placeholder) . ') = ' . $schema->Setter($availabilityProperty, $parameters->placeholder++);
			$parameters->values[] = $filters['availability'];
		}
	}
	
	/*public static function GetByObjectPath(string $path, int $min_version = -1, DateTime $updated_since = null) {
		$objects = static::Get('path:' . $path, $min_version, $updated_since);
		if (count($objects) == 1) {
			return $objects[0];
		}
	}
	
	protected static function SQLColumns() {
		$columns = parent::SQLColumns();
		$columns[] = 'availability';
		$columns[] = 'path';
		$columns[] = 'class_string';
		return $columns;
	}
	
	protected static function TableName() {
		return 'blueprints';
	}
	
	protected function GetColumnValue(string $column) {
		switch ($column) {
		case 'availability':
			return $this->availability;
		case 'path':
			return $this->path;
		case 'class_string':
			return $this->class_string;
		default:
			return parent::GetColumnValue($column);
		}
	}
	
	public function ConsumeJSON(array $json) {
		parent::ConsumeJSON($json);
			
		if (array_key_exists('path', $json)) {
			$this->path = $json['path'];
		}
		if (array_key_exists('availability', $json) && is_int($json['availability'])) {
			$this->availability = intval($json['availability']);
		}
	}
	
	protected static function FromRow(BeaconRecordSet $row) {
		$obj = parent::FromRow($row);
		if ($obj === null) {
			return null;
		}
		$obj->availability = intval($row->Field('availability'));
		$obj->path = $row->Field('path');
		$obj->class_string = $row->Field('class_string');
		return $obj;
	}
	
	protected static function ListValueToParameter($value, array &$possible_columns) {
		if (is_string($value)) {
			if (strtoupper(substr($value, -2)) == '_C') {
				$possible_columns[] = 'class_string';
				return $value;
			} elseif (preg_match('/^[A-F0-9]{32}$/i', $value)) {
				$possible_columns[] = 'MD5(LOWER(path))';
				return $value;
			} elseif (strtolower(substr($value, 0, 6)) == '/game/') {
				$possible_columns[] = 'path';
				return $value;
			}
		}
		
		return parent::ListValueToParameter($value, $possible_columns);
	}*/
	
	public static function Fetch(string $uuid): ?static {
		if (BeaconCommon::IsUUID($uuid)) {
			return parent::Fetch($uuid);
		} else if (str_contains($uuid, '/')) {
			$blueprints = static::Search(['path' => $uuid], true);
			if (count($blueprints) === 1) {
				return $blueprints[0];
			}
		} else {
			$blueprints = static::Search(['classString' => $uuid], true);
			if (count($blueprints) === 1) {
				return $blueprints[0];
			}
		}
		return null;
	}
	
	public function jsonSerialize(): mixed {
		$json = parent::jsonSerialize();
		$json['fingerprint'] = $this->Fingerprint();
		$json['availability'] = intval($this->availability);
		$json['path'] = $this->path;
		$json['classString'] = $this->classString;
		return $json;
	}
	
	public function Path(): string {
		return $this->path;
	}
	
	public function SetPath(string $path): void {
		$this->path = $path;
		$this->class_string = self::ClassFromPath($path);
	}
	
	public function ClassString(): string {
		return $this->classString;
	}
	
	public function Availability(): int {
		return $this->availability;
	}
	
	public function SetAvailability(int $availability): void {
		$this->availability = $availability;
	}
	
	public function AvailableTo(int $mask): bool {
		return ($this->availability & $mask) !== 0;
	}
	
	public function SetAvailableTo(int $mask, bool $available): void {
		if ($available) {
			$this->availability = $this->availability | $mask;
		} else {
			$this->availability = $this->availability & ~$mask;
		}
	}
	
	protected static function ClassFromPath(string $path): string {
		$components = explode('/', $path);
		$tail = array_pop($components);
		$components = explode('.', $tail);
		$class = array_pop($components);
		return $class . '_C';
	}
	
	public function RelatedObjectIDs(): array {
		return [];
	}
	
	public function Fingerprint(): string {
		return base64_encode(hash('sha1', $this->contentPackSteamId . ':' . strtolower($this->path), true));
	}
}

?>
