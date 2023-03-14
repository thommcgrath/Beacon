<?php

namespace BeaconAPI\v4\Ark;
use BeaconAPI\v4\{Core, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters};
use BeaconRecordSet;

class LootDropIcon extends GenericObject {
	private $iconData;
	
	public function __construct(BeaconRecordSet $row) {
		parent::__construct($row);
		
		$this->iconData = $row->Field('icon_data');	
	}
	
	protected static function CustomVariablePrefix(): string {
		return 'lootDropIcon';
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		$schema = parent::BuildDatabaseSchema();
		$schema->SetTable('loot_source_icons');
		$schema->AddColumns([
			New DatabaseObjectProperty('iconData', ['columnName' => 'icon_data'])
		]);
		return $schema;
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		parent::BuildSearchParameters($parameters, $filters, $isNested);
		
		$parameters->allowAll = true;
		$parameters->orderBy = 'label';
	}
	
	public function jsonSerialize(): mixed {
		$json = parent::jsonSerialize();
		unset($json['lootDropIconGroup']);
		$json['iconData'] = base64_encode($this->iconData);
		return $json;
	}
	
	public function IconData(bool $base64 = true): string {
		if ($base64) {
			return base64_encode($this->iconData);
		} else {
			return $this->iconData;
		}
	}
}

?>
