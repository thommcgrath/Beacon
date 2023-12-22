<?php

namespace BeaconAPI\v4\ArkSA;
use BeaconAPI\v4\{Core, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters};
use BeaconCommon, BeaconDatabase, BeaconRecordSet, Exception;

class LootDrop extends MutableBlueprint {
	protected array $multipliers;
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

		$this->multipliers = is_null($row->Field('multipliers')) === false ? json_decode($row->Field('multipliers'), true) : ['min' => 1.0, 'max' => 1.0];
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
			$itemSets = json_decode($row->Field('item_sets'), true);
			for ($itemSet_idx = 0; $itemSet_idx < count($itemSets); $itemSet_idx++) {
				$itemSet = $itemSets[$itemSet_idx];
				if (is_null($itemSet) || isset($itemSet['entries']) === false || is_array($itemSet['entries']) === false) {
					continue;
				}

				for ($entry_idx = 0; $entry_idx < count($itemSet['entries']); $entry_idx++) {
					$entry = $itemSet['entries'][$entry_idx];
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
					$itemSet['entries'][$entry_idx] = $entry;
				}
				$itemSets[$itemSet_idx] = $itemSet;
			}

			$this->itemSets = $itemSets;
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
			New DatabaseObjectProperty('multipliers', ['columnName' => 'multipliers', 'accessor' => 'json_build_object(\'min\', %%TABLE%%.multiplier_min, \'max\', %%TABLE%%.multiplier_max)', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
			New DatabaseObjectProperty('uiColor', ['columnName' => 'uicolor', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
			New DatabaseObjectProperty('iconId', ['columnName' => 'icon', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
			New DatabaseObjectProperty('sortOrder', ['columnName' => 'sort_order', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
			New DatabaseObjectProperty('experimental', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
			New DatabaseObjectProperty('notes', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
			New DatabaseObjectProperty('requirements', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
			New DatabaseObjectProperty('simpleLabel', ['columnName' => 'simple_label', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
			New DatabaseObjectProperty('minItemSets', ['columnName' => 'min_item_sets', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
			New DatabaseObjectProperty('maxItemSets', ['columnName' => 'max_item_sets', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
			New DatabaseObjectProperty('preventDuplicates', ['columnName' => 'prevent_duplicates', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
			New DatabaseObjectProperty('itemSets', ['columnName' => 'item_sets', 'accessor' => '(SELECT array_to_json(array_agg(row_to_json(sets_template))) FROM (SELECT loot_item_set_id AS "lootItemSetId", label, min_entries AS "minEntries", max_entries AS "maxEntries", weight, prevent_duplicates AS "preventDuplicates", (SELECT array_to_json(array_agg(row_to_json(entries_template))) FROM (SELECT loot_item_set_entry_id AS "lootItemSetEntryId", min_quantity AS "minQuantity", max_quantity AS "maxQuantity", min_quality AS "minQuality", max_quality AS "maxQuality", blueprint_chance AS "blueprintChance", weight, single_item_quantity "singleItemQuantity", prevent_grinding AS "preventGrinding", stat_clamp_multiplier AS "statClampMultiplier", (SELECT array_to_json(array_agg(row_to_json(options_template))) FROM (SELECT loot_item_set_entry_option_id AS "lootItemSetEntryOptionId", engram_id AS "engramId", weight FROM arksa.loot_item_set_entry_options INNER JOIN arksa.engrams ON (loot_item_set_entry_options.engram_id = engrams.object_id) WHERE loot_item_set_entry_options.loot_item_set_entry_id = loot_item_set_entries.loot_item_set_entry_id) AS options_template) AS options FROM arksa.loot_item_set_entries WHERE loot_item_set_entries.loot_item_set_id = loot_item_sets.loot_item_set_id) AS entries_template) AS entries FROM arksa.loot_item_sets WHERE loot_item_sets.loot_drop_id = loot_drops.object_id) AS sets_template)', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways])
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
		$json['multipliers'] = $this->multipliers;
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
		return $this->multipliers['min'];
	}

	public function SetMultiplierMin(float $multiplier): void {
		$this->multipliers['min'] = $multiplier;
	}

	public function MultiplierMax(): float {
		return $this->multipliers['max'];
	}

	public function SetMultiplierMax(float $multiplier): void {
		$this->multipliers['max'] = $multiplier;
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

	protected function SaveChildObjects(BeaconDatabase $database): void {
		parent::SaveChildObjects($database);
		$this->SaveItemSets($database);
		$database->Query('UPDATE arksa.loot_drops SET multiplier_min = $2, multiplier_max = $3 WHERE object_id = $1 AND (multiplier_min IS DISTINCT FROM $2 OR multiplier_min IS DISTINCT FROM $3);', $this->objectId, $this->multipliers['min'], $this->multipliers['max']);
	}

	protected function SaveItemSets(BeaconDatabase $database): void {
		$lootContainerId = $this->ObjectID();
		$keepItemSets = [];
		$counters = [];
		if (is_null($this->itemSets) === false) {
			foreach ($this->itemSets as $itemSet) {
				$lootItemSetId = $itemSet['lootItemSetId'];
				if (BeaconCommon::IsUUID($lootItemSetId)) {
					$keepItemSets[] = $lootItemSetId;
				} else {
					throw new Exception('Item set ID is not a v4 UUID.');
				}

				$columnMap = [
					'label' => 'label',
					'minEntries' => 'min_entries',
					'maxEntries' => 'max_entries',
					'weight' => 'weight',
					'preventDuplicates' => 'prevent_duplicates',
				];
				$columns = [
					'loot_item_set_id' => $lootItemSetId,
					'loot_drop_id' => $lootContainerId,
				];
				foreach ($columnMap as $propertyName => $columnName) {
					if (array_key_exists($propertyName, $itemSet)) {
						$columns[$columnName] = $itemSet[$propertyName];
					}
				}
				$columns['sync_sort_key'] = BeaconCommon::CreateUniqueSort(implode(',', [
					BeaconCommon::SortString($itemSet['label']),
					BeaconCommon::SortDouble($itemSet['weight'])
				]), $counters);

				$database->Upsert('arksa.loot_item_sets', $columns, ['loot_item_set_id']);
				$this->SaveItemSetEntries($database, $lootItemSetId, $itemSet['entries']);
			}
		}

		if (count($keepItemSets) > 0) {
			$database->Query('DELETE FROM arksa.loot_item_sets WHERE loot_drop_id = $1 AND loot_item_set_id NOT IN (\'' . implode('\', \'', $keepItemSets) . '\');', $lootContainerId);
		} else {
			$database->Query('DELETE FROM arksa.loot_item_sets WHERE loot_drop_id = $1;', $lootContainerId);
		}
	}

	protected function SaveItemSetEntries(BeaconDatabase $database, string $lootItemSetId, ?array $entries) {
		$keepEntries = [];
		$counters = [];
		if (is_null($entries) === false) {
			foreach ($entries as $entry) {
				$lootItemSetEntryId = $entry['lootItemSetEntryId'];
				if (BeaconCommon::IsUUID($lootItemSetEntryId)) {
					$keepEntries[] = $lootItemSetEntryId;
				} else {
					throw new Exception('Entry ID is not a v4 UUID.');
				}

				$columnMap = [
					'minQuantity' => 'min_quantity',
					'maxQuantity' => 'max_quantity',
					'minQuality' => 'min_quality',
					'maxQuality' => 'max_quality',
					'blueprintChance' => 'blueprint_chance',
					'weight' => 'weight',
					'singleItemQuantity' => 'single_item_quantity',
					'preventGrinding' => 'prevent_grinding',
					'statClampMultiplier' => 'stat_clamp_multiplier',
				];
				$columns = [
					'loot_item_set_entry_id' => $lootItemSetEntryId,
					'loot_item_set_id' => $lootItemSetId,
				];
				foreach ($columnMap as $propertyName => $columnName) {
					if (array_key_exists($propertyName, $entry)) {
						$columns[$columnName] = $entry[$propertyName];
					}
				}
				$columns['sync_sort_key'] = BeaconCommon::CreateUniqueSort(implode(',', [
					BeaconCommon::SortDouble($entry['weight']),
					BeaconCommon::SortInteger($entry['minQuantity']),
					BeaconCommon::SortInteger($entry['maxQuantity']),
					BeaconCommon::SortDouble($entry['blueprintChance']),
					BeaconCommon::SortString($entry['minQuality']),
					BeaconCommon::SortString($entry['maxQuality'])
				]), $counters);

				$database->Upsert('arksa.loot_item_set_entries', $columns, ['loot_item_set_entry_id']);
				$this->SaveItemSetEntryOptions($database, $lootItemSetEntryId, $entry['options']);
			}
		}
		if (count($keepEntries) > 0) {
			$database->Query('DELETE FROM arksa.loot_item_set_entries WHERE loot_item_set_id = $1 AND loot_item_set_entry_id NOT IN (\'' . implode('\', \'', $keepEntries) . '\');', $lootItemSetId);
		} else {
			$database->Query('DELETE FROM arksa.loot_item_set_entries WHERE loot_item_set_id = $1;', $lootItemSetId);
		}
	}

	protected function SaveItemSetEntryOptions(BeaconDatabase $database, string $lootItemSetEntryId, ?array $options) {
		$keepOptions = [];
		$counters = [];
		if (is_null($options) === false) {
			foreach ($options as $option) {
				$lootItemSetEntryOptionId = $option['lootItemSetEntryOptionId'];
				if (BeaconCommon::IsUUID($lootItemSetEntryOptionId)) {
					$keepOptions[] = $lootItemSetEntryOptionId;
				} else {
					throw new Exception('Option ID is not a v4 UUID.');
				}

				$engramRow = $database->Query('SELECT class_string FROM arksa.engrams WHERE object_id = $1;', $option['engramId']);
				if ($engramRow->RecordCount() !== 1) {
					throw new Exception('Could not find engram ' . $option['engramId']);
				}
				$classString = $engramRow->Field('class_string');
				$columns = [
					'loot_item_set_entry_option_id' => $lootItemSetEntryOptionId,
					'loot_item_set_entry_id' => $lootItemSetEntryId,
					'weight' => $option['weight'],
					'engram_id' => $option['engramId'],
				];
				$columns['sync_sort_key'] = BeaconCommon::CreateUniqueSort(implode(',', [
					BeaconCommon::SortString($classString),
					BeaconCommon::SortDouble($option['weight'])
				]), $counters);

				$database->Upsert('arksa.loot_item_set_entry_options', $columns, ['loot_item_set_entry_option_id']);
			}
		}
		if (count($keepOptions) > 0) {
			$database->Query('DELETE FROM arksa.loot_item_set_entry_options WHERE loot_item_set_entry_id = $1 AND loot_item_set_entry_option_id NOT IN (\'' . implode('\', \'', $keepOptions) . '\');', $lootItemSetEntryId);
		} else {
			$database->Query('DELETE FROM arksa.loot_item_set_entry_options WHERE loot_item_set_entry_id = $1;', $lootItemSetEntryId);
		}
	}
}

?>