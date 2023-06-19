<?php

namespace BeaconAPI\v4\Ark;
use BeaconAPI\v4\{Core, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters};
use BeaconCommon, BeaconDatabase, BeaconRecordSet, Exception;

class LootDrop extends Blueprint {
	protected float $multiplierMin;
	protected float $multiplierMax;
	protected string $uiColor;
	protected string $iconId;
	protected int $sortOrder;
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
		$this->sortOrder = filter_var($row->Field('modern_sort'), FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE) ?? 999;
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
		$schema->SetTable('loot_sources');
		$schema->AddColumns([
			New DatabaseObjectProperty('multiplierMin', ['columnName' => 'multiplier_min']),
			New DatabaseObjectProperty('multiplierMax', ['columnName' => 'multiplier_max']),
			New DatabaseObjectProperty('uiColor', ['columnName' => 'uicolor']),
			New DatabaseObjectProperty('iconId', ['columnName' => 'icon']),
			New DatabaseObjectProperty('sortOrder', ['columnName' => 'modern_sort']),
			New DatabaseObjectProperty('experimental'),
			New DatabaseObjectProperty('notes'),
			New DatabaseObjectProperty('requirements'),
			New DatabaseObjectProperty('simpleLabel', ['columnName' => 'simple_label']),
			New DatabaseObjectProperty('minItemSets', ['columnName' => 'min_item_sets']),
			New DatabaseObjectProperty('maxItemSets', ['columnName' => 'max_item_sets']),
			New DatabaseObjectProperty('preventDuplicates', ['columnName' => 'prevent_duplicates']),
			New DatabaseObjectProperty('itemSets', ['columnName' => 'item_sets', 'accessor' => '(SELECT array_to_json(array_agg(row_to_json(sets_template))) FROM (SELECT loot_item_set_id AS "lootItemSetId", label, min_entries AS "maxEntries", max_entries AS "minEntries", weight, prevent_duplicates AS "preventDuplicates", (SELECT array_to_json(array_agg(row_to_json(entries_template))) FROM (SELECT loot_item_set_entry_id AS "lootItemSetEntryId", min_quantity AS "minQuantity", max_quantity AS "maxQuantity", min_quality AS "minQuality", max_quality AS "maxQuality", blueprint_chance AS "blueprintChance", weight, single_item_quantity "singleItemQuantity", prevent_grinding AS "preventGrinding", stat_clamp_multiplier AS "statClampMultiplier", (SELECT array_to_json(array_agg(row_to_json(options_template))) FROM (SELECT loot_item_set_entry_option_id AS "lootItemSetEntryOptionId", engram_id AS "engramId", weight FROM ark.loot_item_set_entry_options INNER JOIN ark.engrams ON (loot_item_set_entry_options.engram_id = engrams.object_id) WHERE loot_item_set_entry_options.loot_item_set_entry_id = loot_item_set_entries.loot_item_set_entry_id) AS options_template) AS options FROM ark.loot_item_set_entries WHERE loot_item_set_entries.loot_item_set_id = loot_item_sets.loot_item_set_id) AS entries_template) AS entries FROM ark.loot_item_sets WHERE loot_item_sets.loot_source_id = loot_sources.object_id) AS sets_template)'])
		]);
		return $schema;
	}
	
	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		parent::BuildSearchParameters($parameters, $filters, $isNested);
		
		$schema = static::DatabaseSchema();
		$parameters->allowAll = true;
		$parameters->orderBy = 'loot_sources.modern_sort, loot_sources.label';
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
	
	/*protected static function SQLColumns() {
		$columns = parent::SQLColumns();
		$columns[] = 'min_item_sets';
		$columns[] = 'max_item_sets';
		$columns[] = 'prevent_duplicates';
		$columns[] = '(SELECT array_to_json(array_agg(row_to_json(sets_template))) FROM (SELECT loot_item_set_id, label, min_entries, max_entries, weight, prevent_duplicates, (SELECT array_to_json(array_agg(row_to_json(entries_template))) FROM (SELECT loot_item_set_entry_id, min_quantity, max_quantity, min_quality, max_quality, blueprint_chance, weight, single_item_quantity, prevent_grinding, stat_clamp_multiplier, (SELECT array_to_json(array_agg(row_to_json(options_template))) FROM (SELECT loot_item_set_entry_option_id, engram_id, path, class_string, mod_id, weight FROM ark.loot_item_set_entry_options INNER JOIN ark.engrams ON (loot_item_set_entry_options.engram_id = engrams.object_id) WHERE loot_item_set_entry_options.loot_item_set_entry_id = loot_item_set_entries.loot_item_set_entry_id) AS options_template) AS options FROM ark.loot_item_set_entries WHERE loot_item_set_entries.loot_item_set_id = loot_item_sets.loot_item_set_id) AS entries_template) AS entries FROM ark.loot_item_sets WHERE loot_item_sets.loot_source_id = loot_sources.object_id) AS sets_template) AS item_sets';
		return $columns;
	}
	
	protected static function FromRow(BeaconRecordSet $row) {
		$obj = parent::FromRow($row);
		if ($obj === null) {
			return null;
		}
		
		$obj->min_item_sets = $row->Field('min_item_sets');
		$obj->max_item_sets = $row->Field('max_item_sets');
		$obj->prevent_duplicates = $row->Field('prevent_duplicates');
		
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
							'loot_item_set_entry_option_id' => $option['loot_item_set_entry_option_id'],
							'engram' => [
								'Schema' => 'Beacon.BlueprintReference',
								'Version' => 1,
								'Kind' => 'Engram',
								'UUID' => $option['engram_id'],
								'Path' => $option['path'],
								'Class' => $option['class_string'],
								'ModUUID' => $option['mod_id']
							],
							'weight' => $option['weight'],
						];
					}
					$item_set['entries'][$entry_idx] = $entry;
				}
				$item_sets[$item_set_idx] = $item_set;
			}
			
			$obj->item_sets = $item_sets;
		} else {
			$obj->item_sets = null;
		}
		
		return $obj;
	}*/
	
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
	
	/*public function ConsumeJSON(array $json) {
		parent::ConsumeJSON($json);
			
		if (array_key_exists('min_item_sets', $json)) {
			if (is_numeric($json['min_item_sets'])) {
				$this->min_item_sets = intval($json['min_item_sets']);
			} else {
				throw new Exception('Minimum item sets must be a number greater than or equal to zero.');
			}
		}
		if (array_key_exists('max_item_sets', $json)) {
			if (is_numeric($json['max_item_sets'])) {
				$this->max_item_sets = intval($json['max_item_sets']);
			} else {
				throw new Exception('Maximum item sets must be a number greater than or equal to zero.');
			}
		}
		if (array_key_exists('prevent_duplicates', $json)) {
			if (is_bool($json['prevent_duplicates'])) {
				$this->prevent_duplicates = boolval($json['prevent_duplicates']);
			} else {
				throw new Exception('Prevent duplicates must be a boolean.');
			}
		}
		if (array_key_exists('contents', $json)) {
			$sets = $json['contents'];
			if (is_null($sets) || (is_array($sets) && BeaconCommon::IsAssoc($sets) === false)) {
				$this->item_sets = $sets;
			} else {
				throw new Exception('Item sets must be an array of loot item sets.');
			}
		}
	}
	
	protected function GetColumnValue(string $column) {
		switch ($column) {
		case 'min_item_sets':
			return $this->min_item_sets;
		case 'max_item_sets':
			return $this->max_item_sets;
		case 'prevent_duplicates':
			return $this->prevent_duplicates;
		case 'item_sets':
			return $this->item_sets;
		default:
			return parent::GetColumnValue($column);
		}
	}
	
	protected function SaveChildrenHook(BeaconDatabase $database) {
		parent::SaveChildrenHook($database);
		
		$this->SaveItemSets($database);
	}
	
	protected function SaveItemSets(BeaconDatabase $database): void {
		$loot_source_id = $this->ObjectID();
		$keep_sets = [];
		$counters = [];
		if (is_null($this->item_sets) === false) {
			foreach ($this->item_sets as $item_set) {
				$loot_item_set_id = $item_set['loot_item_set_id'];
				if (BeaconCommon::IsUUID($loot_item_set_id)) {
					$keep_sets[] = $loot_item_set_id;
				} else {
					throw new Exception('Item set ID is not a v4 UUID.');
				}
				
				$item_set['sync_sort_key'] = BeaconCommon::CreateUniqueSort(implode(',', [
					BeaconCommon::SortString($item_set['label']),
					BeaconCommon::SortDouble($item_set['weight'])
				]), $counters);
				$item_set['loot_source_id'] = $loot_source_id;
				$entries = $item_set['entries'];
				unset($item_set['entries']);
				
				$database->Upsert('ark.loot_item_sets', $item_set, ['loot_item_set_id']);
				$this->SaveItemSetEntries($database, $loot_item_set_id, $entries);
			}
		}
		
		if (count($keep_sets) > 0) {
			$database->Query('DELETE FROM ark.loot_item_sets WHERE loot_source_id = $1 AND loot_item_set_id NOT IN (\'' . implode('\', \'', $keep_sets) . '\');', $loot_source_id);
		} else {
			$database->Query('DELETE FROM ark.loot_item_sets WHERE loot_source_id = $1;', $loot_source_id);
		}
	}
	
	protected function SaveItemSetEntries(BeaconDatabase $database, string $loot_item_set_id, array|null $entries) {
		$keep_entries = [];
		$counters = [];
		if (is_null($entries) === false) {
			foreach ($entries as $entry) {
				$loot_item_set_entry_id = $entry['loot_item_set_entry_id'];
				if (BeaconCommon::IsUUID($loot_item_set_entry_id)) {
					$keep_entries[] = $loot_item_set_entry_id;
				} else {
					throw new Exception('Entry ID is not a v4 UUID.');
				}
				
				$entry['sync_sort_key'] = BeaconCommon::CreateUniqueSort(implode(',', [
					BeaconCommon::SortDouble($entry['weight']),
					BeaconCommon::SortInteger($entry['min_quantity']),
					BeaconCommon::SortInteger($entry['max_quantity']),
					BeaconCommon::SortDouble($entry['blueprint_chance']),
					BeaconCommon::SortString($entry['min_quality']),
					BeaconCommon::SortString($entry['max_quality'])
				]), $counters);
				$entry['loot_item_set_id'] = $loot_item_set_id;
				$options = $entry['options'];
				unset($entry['options']);
				
				$database->Upsert('ark.loot_item_set_entries', $entry, ['loot_item_set_entry_id']);
				$this->SaveItemSetEntryOptions($database, $loot_item_set_entry_id, $options);
			}
		}
		if (count($keep_entries) > 0) {
			$database->Query('DELETE FROM ark.loot_item_set_entries WHERE loot_item_set_id = $1 AND loot_item_set_entry_id NOT IN (\'' . implode('\', \'', $keep_entries) . '\');', $loot_item_set_id);
		} else {
			$database->Query('DELETE FROM ark.loot_item_set_entries WHERE loot_item_set_id = $1;', $loot_item_set_id);
		}
	}
	
	protected function SaveItemSetEntryOptions(BeaconDatabase $database, string $loot_item_set_entry_id, array|null $options) {
		$keep_options = [];
		$counters = [];
		if (is_null($options) === false) {
			foreach ($options as $option) {
				$loot_item_set_entry_option_id = $option['loot_item_set_entry_option_id'];
				if (BeaconCommon::IsUUID($loot_item_set_entry_option_id)) {
					$keep_options[] = $loot_item_set_entry_option_id;
				} else {
					throw new Exception('Option ID is not a v4 UUID.');
				}
				
				if (array_key_exists('engram', $option)) {
					$class_string = $option['engram']['Class'];
					$option['engram_id'] = $option['engram']['UUID'];
					unset($option['engram']);
				} elseif (array_key_exists('engram_id', $option)) {
					$rows = $database->Query('SELECT class_string FROM ark.engrams WHERE object_id = $1;', $option['engram_id']);
					if ($rows->RecordCount() !== 1) {
						throw new Exception('Unable to find engram by UUID.');
					}
					$class_string = $rows->Field('class_string');
				}
				
				$option['sync_sort_key'] = BeaconCommon::CreateUniqueSort(implode(',', [
					BeaconCommon::SortString($class_string),
					BeaconCommon::SortDouble($option['weight'])
				]), $counters);
				$option['loot_item_set_entry_id'] = $loot_item_set_entry_id;
				
				$database->Upsert('ark.loot_item_set_entry_options', $option, ['loot_item_set_entry_option_id']);
			}
		}
		if (count($keep_options) > 0) {
			$database->Query('DELETE FROM ark.loot_item_set_entry_options WHERE loot_item_set_entry_id = $1 AND loot_item_set_entry_option_id NOT IN (\'' . implode('\', \'', $keep_options) . '\');', $loot_item_set_entry_id);
		} else {
			$database->Query('DELETE FROM ark.loot_item_set_entry_options WHERE loot_item_set_entry_id = $1;', $loot_item_set_entry_id);
		}	
	}*/
}

/*class LootSource extends \Ark\Blueprint {
	protected $multiplier_min;
	protected $multiplier_max;
	protected $ui_color;
	protected $icon_id;
	protected $sort_order;
	protected $modern_sort_order;
	protected $experimental;
	protected $notes;
	protected $requirements = '{}';
	protected $simple_label;
	
	protected static function SQLColumns() {
		$columns = parent::SQLColumns();
		$columns[] = 'multiplier_min';
		$columns[] = 'multiplier_max';
		$columns[] = 'uicolor';
		$columns[] = 'icon';
		$columns[] = 'sort';
		$columns[] = 'modern_sort';
		$columns[] = 'experimental';
		$columns[] = 'notes';
		$columns[] = 'requirements';
		$columns[] = 'simple_label';
		return $columns;
	}
	
	protected static function TableName() {
		return 'loot_sources';
	}
	
	protected static function SortColumn() {
		return 'sort';
	}
	
	protected function GetColumnValue(string $column) {
		switch ($column) {
		case 'multiplier_min':
			return $this->multiplier_min;
		case 'multiplier_max':
			return $this->multiplier_max;
		case 'uicolor':
			return $this->ui_color;
		case 'icon':
			return $this->icon_id;
		case 'sort':
			return $this->sort_order;
		case 'modern_sort':
			return $this->modern_sort_order;
		case 'required_item_sets':
			return 1;
		case 'experimental':
			return $this->experimental;
		case 'notes':
			return $this->notes;
		case 'requirements':
			return $this->requirements;
		case 'simple_label':
			return $this->simple_label;
		default:
			return parent::GetColumnValue($column);
		}
	}
	
	protected static function FromRow(\BeaconRecordSet $row) {
		$obj = parent::FromRow($row);
		if ($obj === null) {
			return null;
		}
		$obj->multiplier_min = floatval($row->Field('multiplier_min'));
		$obj->multiplier_max = floatval($row->Field('multiplier_max'));
		$obj->ui_color = $row->Field('uicolor');
		$obj->icon_id = $row->Field('icon');
		if (is_null($row->Field('sort')) == false) {
			$obj->sort_order = intval($row->Field('sort'));
		}
		if (is_null($row->Field('modern_sort')) == false) {
			$obj->modern_sort_order = intval($row->Field('modern_sort'));
		}
		$obj->experimental = boolval($row->Field('experimental'));
		$obj->notes = $row->Field('notes');
		$obj->requirements = $row->Field('requirements');
		$obj->simple_label = $row->Field('simple_label');
		return $obj;
	}
	
	public function jsonSerialize(): mixed {
		$json = parent::jsonSerialize();
		$json['multipliers'] = array(
			'min' => $this->multiplier_min,
			'max' => $this->multiplier_max
		);
		$json['ui_color'] = $this->ui_color;
		$json['icon'] = $this->icon_id;
		$json['sort_order'] = $this->sort_order;
		$json['sort'] = is_null($this->modern_sort_order) ? $this->sort_order : $this->modern_sort_order;
		$json['required_item_sets'] = 1;
		$json['experimental'] = $this->experimental;
		$json['notes'] = $this->notes;
		$json['requirements'] = $this->requirements;
		$json['simple_label'] = is_null($this->simple_label) ? $json['label'] : $this->simple_label;
		return $json;
	}
	
	public function MultiplierMin() {
		return $this->multiplier_min;
	}
	
	public function SetMultiplierMin(float $multiplier) {
		$this->multiplier_min = $multiplier;
	}
	
	public function MultiplierMax() {
		return $this->multiplier_max;
	}
	
	public function SetMultiplierMax(float $multiplier) {
		$this->multiplier_max = $multiplier;
	}
	
	public function UIColor() {
		return $this->ui_color;
	}
	
	public function SetUIColor(string $uicolor) {
		if (preg_match('/[A-F]{8}/i', $uicolor)) {
			$this->ui_color = strtoupper($uicolor);
		}
	}
	
	public function IconID() {
		return $this->icon_id;
	}
	
	public function SetIconID(string $icon_id) {
		if (BeaconCommon::IsUUID($icon_id)) {
			$this->icon_id = $icon_id;
		}
	}
	
	public function SortOrder() {
		return $this->sort_order;
	}
	
	public function SetSortOrder(int $order) {
		$this->sort_order = $order;
	}
	
	public function Experimental() {
		return $this->experimental;
	}
	
	public function SetExperimental(bool $value) {
		$this->experimental = $value;
	}
	
	public function Notes() {
		return $this->notes;
	}
	
	public function SetNotes(bool $notes) {
		$this->notes = $notes;
	}
	
	public function ConsumeJSON(array $json) {
		parent::ConsumeJSON($json);
			
		if (array_key_exists('multipliers', $json)) {
			$multipliers = $json['multipliers'];
			if (\BeaconCommon::IsAssoc($multipliers) && \BeaconCommon::HasAllKeys($multipliers, 'min', 'max') && is_float($multipliers['min']) && is_float($multipliers['max'])) {
				$this->multiplier_min = $multipliers['min'];
				$this->multiplier_max = $multipliers['max'];
			} else {
				throw new \Exception('Multipliers must be an object with min and max keys and floating point values.');
			}
		}
		
		if (array_key_exists('ui_color', $json)) {
			$ui_color = $json['ui_color'];
			if (is_string($ui_color) && strlen($ui_color) === 8) {
				$this->ui_color = strtoupper($ui_color);
			} else {
				throw new \Exception('Icon color must be an 8-character hex color, such as RRGGBBAA.');
			}
		}
		
		if (array_key_exists('icon', $json)) {
			$icon_id = $json['icon'];
			if (\BeaconCommon::IsUUID($icon_id)) {
				$this->icon_id = $icon_id;
			} else {
				throw new \Exception('Icon ID must be a v4 UUID.');
			}
		}
		
		if (array_key_exists('sort', $json)) {
			$sort = $json['sort'];
			if (is_int($sort)) {
				$this->modern_sort_order = $sort;
				$this->sort_order = null;
			} else {
				throw new \Exception('Sort order must be numeric.');
			}
		}
		
		if (array_key_exists('experimental', $json)) {
			$experimental = $json['experimental'];
			if (is_bool($experimental)) {
				$this->experimental = $experimental;
			} else {
				throw new \Exception('Experimental flag must be a boolean.');
			}
		}
		
		if (array_key_exists('notes', $json)) {
			$notes = $json['notes'];
			if (is_string($notes)) {
				$this->notes = trim($notes);
			} else {
				throw new \Exception('Notes must be a string.');
			}
		}
		
		if (array_key_exists('requirements', $json)) {
			$requirements = $json['requirements'];
			if (is_string($requirements)) {
				$this->requirements = trim($requirements);
			} else {
				throw new \Exception('Requirements must be a JSON string.');
			}
		}
	}
}*/

?>
