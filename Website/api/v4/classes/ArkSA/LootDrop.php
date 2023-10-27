<?php

namespace BeaconAPI\v4\ArkSA;
use BeaconAPI\v4\{Core, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters};
use BeaconCommon, BeaconDatabase, BeaconRecordSet, Exception;

class LootDrop extends Blueprint {
	protected float $multiplierMin;
	protected float $multiplierMax;
	protected string $uiColor;
	protected string $iconId;
	protected string $sortOrder;
	protected bool $experimental;
	protected string $notes;
	protected string $requirements;
	protected ?string $simpleLabel;
	protected int $minItemSets;
	protected int $maxItemSets;
	protected bool $preventDuplicates;
	protected ?array $itemSets;
	
	public function __construct(BeaconRecordSet $row) {
		parent::__construct($row);
			
		$this->multiplierMin = filter_var($row->Field('multiplier_min'), FILTER_VALIDATE_FLOAT, FILTER_NULL_ON_FAILURE) ?? 1.0;
		$this->multiplierMax = filter_var($row->Field('multiplier_max'), FILTER_VALIDATE_FLOAT, FILTER_NULL_ON_FAILURE) ?? 1.0;
		$this->uiColor = $row->Field('uicolor');
		$this->iconId = $row->Field('icon');
		$this->sortOrder = $row->Field('sort_order');
		$this->experimental = filter_var($row->Field('experimental'), FILTER_VALIDATE_BOOL, FILTER_NULL_ON_FAILURE) ?? false;
		$this->notes = $row->Field('notes');
		$this->requirements = $row->Field('requirements');
		$this->simpleLabel = $row->Field('simple_label');
		$this->minItemSets = filter_var($row->Field('min_item_sets'), FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE) ?? 1;
		$this->maxItemSets = filter_var($row->Field('max_item_sets'), FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE) ?? 1;
		$this->preventDuplicates = filter_var($row->Field('prevent_duplicates'), FILTER_VALIDATE_BOOL, FILTER_NULL_ON_FAILURE) ?? true;
		
		if (is_null($row->Field('item_sets')) === false) {
			$item_sets = json_decode($row->Field('item_sets'), true);
			for ($item_set_idx = 0; $item_set_idx < count($item_sets); $item_set_idx++) {
				$item_set = $item_sets[$item_set_idx];
				if (is_null($item_set) || isset($item_set['entries']) === false || is_array($item_set['entries']) === false) {
					continue;
				}
				
				for ($entry_idx = 0; $entry_idx < count($item_set['entries']); $entry_idx++) {
					$entry = $item_set['entries'][$entry_idx];
					if (is_null($entry) || isset($entry['options']) === false || is_array($entry['options']) === false) {
						continue;
					}
					
					for ($option_idx = 0; $option_idx < count($entry['options']); $option_idx++) {
						$option = $entry['options'][$option_idx];
						if (is_null($option)) {
							continue;
						}
						
						$entry['options'][$option_idx] = [
							'lootItemSetEntryOptionId' => $option['lootItemSetEntryOptionId'],
							'engramId' => $option['engramId'],
							'weight' => $option['weight'],
						];
					}
					$item_set['entries'][$entry_idx] = $entry;
				}
				$item_sets[$item_set_idx] = $item_set;
			}
			
			$this->itemSets = $item_sets;
		} else {
			$this->itemSets = null;
		}
	}
	
	protected static function CustomVariablePrefix(): string {
		return 'lootDrop';
	}
	
	public static function BuildDatabaseSchema(): DatabaseSchema {
		$schema = parent::BuildDatabaseSchema();
		$schema->SetTable('loot_drops');
		$schema->AddColumns([
			New DatabaseObjectProperty('multiplierMin', ['columnName' => 'multiplier_min']),
			New DatabaseObjectProperty('multiplierMax', ['columnName' => 'multiplier_max']),
			New DatabaseObjectProperty('uiColor', ['columnName' => 'uicolor']),
			New DatabaseObjectProperty('iconId', ['columnName' => 'icon']),
			New DatabaseObjectProperty('sortOrder', ['columnName' => 'sort_order']),
			New DatabaseObjectProperty('experimental'),
			New DatabaseObjectProperty('notes'),
			New DatabaseObjectProperty('requirements'),
			New DatabaseObjectProperty('simpleLabel', ['columnName' => 'simple_label']),
			New DatabaseObjectProperty('minItemSets', ['columnName' => 'min_item_sets']),
			New DatabaseObjectProperty('maxItemSets', ['columnName' => 'max_item_sets']),
			New DatabaseObjectProperty('preventDuplicates', ['columnName' => 'prevent_duplicates']),
			New DatabaseObjectProperty('itemSets', ['columnName' => 'item_sets', 'accessor' => '(SELECT array_to_json(array_agg(row_to_json(sets_template))) FROM (SELECT loot_item_set_id AS "lootItemSetId", label, min_entries AS "minEntries", max_entries AS "maxEntries", weight, prevent_duplicates AS "preventDuplicates", (SELECT array_to_json(array_agg(row_to_json(entries_template))) FROM (SELECT loot_item_set_entry_id AS "lootItemSetEntryId", min_quantity AS "minQuantity", max_quantity AS "maxQuantity", min_quality AS "minQuality", max_quality AS "maxQuality", blueprint_chance AS "blueprintChance", weight, single_item_quantity "singleItemQuantity", prevent_grinding AS "preventGrinding", stat_clamp_multiplier AS "statClampMultiplier", (SELECT array_to_json(array_agg(row_to_json(options_template))) FROM (SELECT loot_item_set_entry_option_id AS "lootItemSetEntryOptionId", engram_id AS "engramId", weight FROM arksa.loot_item_set_entry_options INNER JOIN arksa.engrams ON (loot_item_set_entry_options.engram_id = engrams.object_id) WHERE loot_item_set_entry_options.loot_item_set_entry_id = loot_item_set_entries.loot_item_set_entry_id) AS options_template) AS options FROM arksa.loot_item_set_entries WHERE loot_item_set_entries.loot_item_set_id = loot_item_sets.loot_item_set_id) AS entries_template) AS entries FROM arksa.loot_item_sets WHERE loot_item_sets.loot_drop_id = loot_drops.object_id) AS sets_template)'])
		]);
		return $schema;
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		parent::BuildSearchParameters($parameters, $filters, $isNested);
		
		$schema = static::DatabaseSchema();
		$parameters->allowAll = true;
		$parameters->orderBy = 'loot_drops.sort_order, loot_drops.label';
		$parameters->AddFromFilter($schema, $filters, 'classString');
	}
	
	public static function Fetch(string $uuid): ?static {
		if (BeaconCommon::IsUUID($uuid)) {
			return parent::Fetch($uuid);
		}
		
		$results = static::Search(['classString' => $uuid], true);
		if (count($results) === 1) {
			return $results[0];
		}
		
		return null;
	}
	
	public function jsonSerialize(): mixed {
		$json = parent::jsonSerialize();
		unset($json['lootDropGroup']);
		$json['multipliers'] = array(
			'min' => $this->multiplierMin,
			'max' => $this->multiplierMax
		);
		$json['uiColor'] = $this->uiColor;
		$json['iconId'] = $this->iconId;
		$json['sortOrder'] = $this->sortOrder;
		$json['experimental'] = $this->experimental;
		$json['notes'] = $this->notes;
		$json['requirements'] = $this->requirements;
		$json['simpleLabel'] = is_null($this->simpleLabel) ? $json['label'] : $this->simpleLabel;
		$json['minItemSets'] = $this->minItemSets;
		$json['maxItemSets'] = $this->maxItemSets;
		$json['preventDuplicates'] = $this->preventDuplicates;
		if (is_null($this->itemSets) || count($this->itemSets) == 0) {
			$json['itemSets'] = null;
		} else {
			$json['itemSets'] = $this->itemSets;
		}
		return $json;
	}
	
	public function MultiplierMin(): float {
		return $this->multiplierMin;
	}
	
	public function SetMultiplierMin(float $multiplier): void {
		$this->multiplierMin = $multiplier;
	}
	
	public function MultiplierMax(): float {
		return $this->multiplierMax;
	}
	
	public function SetMultiplierMax(float $multiplier): void {
		$this->multiplierMax = $multiplier;
	}
	
	public function UIColor(): string {
		return $this->uiColor;
	}
	
	public function SetUIColor(string $uicolor): void {
		if (preg_match('/[A-F]{8}/i', $uicolor)) {
			$this->uiColor = strtoupper($uicolor);
		} else {
			throw new Exception('Bad uiColor. Use 8-character hex.');
		}
	}
	
	public function IconId(): string {
		return $this->iconId;
	}
	
	public function SetIconId(string $iconId): void {
		if (BeaconCommon::IsUUID($iconId)) {
			$this->iconId = $iconId;
		}
	}
	
	public function SortOrder(): int {
		return $this->sortOrder;
	}
	
	public function SetSortOrder(int $order): void {
		$this->sortOrder = $order;
	}
	
	public function Experimental(): bool {
		return $this->experimental;
	}
	
	public function SetExperimental(bool $value): void {
		$this->experimental = $value;
	}
	
	public function Notes(): string {
		return $this->notes;
	}
	
	public function SetNotes(bool $notes): void {
		$this->notes = $notes;
	}
	
	public function SpawnCode(): string {
		return 'cheat summon ' . $this->classString;
	}
}

?>
