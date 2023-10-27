<?php

namespace BeaconAPI\v4\ArkSA;
use BeaconAPI\v4\{DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters};
use BeaconCommon, BeaconRecordSet, BeaconUUID, DateTime;

class Blueprint extends GenericObject {
	protected int $availability;
	protected string $path;
	protected string $classString;

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
			new DatabaseObjectProperty('classString', ['columnName' => 'class_string', 'editable' => DatabaseObjectProperty::kEditableNever])
		]);
		return $schema;
	}

	public static function GenerateObjectId(array $properties): string {
		if (isset($properties['contentPackId']) === false || isset($properties['path']) === false) {
			return '00000000-0000-0000-0000-000000000000';
		}

		$contentPackId = strtolower(trim($properties['contentPackId']));
		$path = strtolower(trim($properties['path']));
		return BeaconUUID::v5("{$contentPackId}:{$path}");
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		parent::BuildSearchParameters($parameters, $filters, $isNested);

		$schema = static::DatabaseSchema();

		if (isset($filters['path'])) {
			if (str_contains($filters['path'], '%')) {
				$parameters->clauses[] = $schema->Accessor('path') . ' LIKE ' . $schema->Setter('path', $parameters->placeholder++);
			} else {
				$parameters->clauses[] = $schema->Comparison('path', '=', $parameters->placeholder++);
			}
			$parameters->values[] = $filters['path'];
		}

		if (isset($filters['classString'])) {
			if (str_contains($filters['classString'], '%')) {
				$parameters->clauses[] = $schema->Accessor('classString') . ' LIKE ' . $schema->Setter('classString', $parameters->placeholder++);
			} else {
				$parameters->clauses[] = $schema->Comparison('classString', '=', $parameters->placeholder++);
			}
			$parameters->values[] = $filters['classString'];
		}

		if (isset($filters['availability'])) {
			$availabilityProperty = $schema->Property('availability');
			$parameters->clauses[] = '(' . $schema->Accessor($availabilityProperty) . ' & ' . $schema->Setter($availabilityProperty, $parameters->placeholder) . ') = ' . $schema->Setter($availabilityProperty, $parameters->placeholder++);
			$parameters->values[] = $filters['availability'];
		}
	}

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

	public function RelatedObjectIds(): array {
		return [];
	}

	public function Fingerprint(): string {
		return base64_encode(hash('sha1', $this->contentPackMarketplace . ':' . $this->contentPackMarketplaceId . ':' . strtolower($this->path), true));
	}

	public static function ConvertTag(string $tag): array {
		// Could be in the format of no_fibercraft or NoFibercraft

		if (str_contains($tag, '_')) {
			// lowercase
			$tagHuman = ucwords(str_replace('_', ' ', strtolower($tag)));

		} else {
			$tagWords = preg_split('/(?=[A-Z])/', $tag);
			if (empty($tagWords[0])) {
				unset($tagWords[0]);
			}
			$tagHuman = ucwords(implode(' ', $tagWords));
			$tag = strtolower(implode('_', $tagWords));
		}
		$tagUrl = str_replace(' ', '', $tagHuman);

		return [
			'tag' => $tag,
			'human' => $tagHuman,
			'url' => $tagUrl
		];
	}
}

?>
