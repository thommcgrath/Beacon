<?php

namespace BeaconAPI\v4\ArkSA;
use BeaconAPI\v4\{Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters};
use BeaconCommon, BeaconDatabase, BeaconRecordSet, Exception;

class LootDrop extends MutableBlueprint {
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
			New DatabaseObjectProperty('multiplierMin', ['columnName' => 'multiplier_min', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
			New DatabaseObjectProperty('multiplierMax', ['columnName' => 'multiplier_max', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
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
		$json['multipliers'] = [
			'min' => $this->multiplierMin,
			'max' => $this->multiplierMax
		];
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

	protected static function FixProperties(array $properties): array {
		if (array_key_exists('multipliers', $properties)) {
			$properties['multiplierMin'] = $properties['multipliers']['min'];
			$properties['multiplierMax'] = $properties['multipliers']['max'];
		}
		if (array_key_exists('icon', $properties) === true && array_key_exists('iconId', $properties) === false) {
			$properties['iconId'] = $properties['icon'];
			unset($properties['icon']);
		}
		if (array_key_exists('sort', $properties) === true && array_key_exists('sortOrder', $properties) === false) {
			$properties['sortOrder'] = $properties['sort'];
			unset($properties['sort']);
		}
		return $properties;
	}

	public static function Create(array $properties): DatabaseObject {
		$properties = static::FixProperties($properties);
		return parent::Create($properties);
	}

	public function Edit(array $properties, bool $restoreDefaults = false): void {
		$properties = static::FixProperties($properties);
		parent::Edit($properties, $restoreDefaults);
	}

	protected static function ValuesEqual(DatabaseObjectProperty $definition, mixed $valueOne, mixed $valueTwo): bool {
		switch ($definition->PropertyName()) {
		case 'multiplierMin':
		case 'multiplierMax':
			return number_format($valueOne, 4, '.', '') === number_format($valueTwo, 4, '.', '');
		default:
			return parent::ValuesEqual($definition, $valueOne, $valueTwo);
		}
	}

	protected function SaveChildObjects(BeaconDatabase $database): void {
		parent::SaveChildObjects($database);
		$this->SaveItemSets($database);
	}

	protected function SaveItemSets(BeaconDatabase $database): void {
		$lootContainerId = $this->ObjectID();
		$rows = $database->Query('SELECT loot_item_set_id FROM arksa.loot_item_sets WHERE loot_drop_id = $1', $lootContainerId);
		$existingSets = [];
		while (!$rows->EOF()) {
			$itemSetId = $rows->Field('loot_item_set_id');
			$existingSets[$itemSetId] = true;
			$rows->MoveNext();
		}

		if (is_null($this->itemSets) === false) {
			foreach ($this->itemSets as $itemSet) {
				$itemSetId = $itemSet['lootItemSetId'];
				if (BeaconCommon::IsUUID($itemSetId) === false) {
					throw new Exception('Item set ID "' . $itemSetId . '" is not a UUID.');
				}

				if ($this->SaveItemSetEntries($database, $itemSetId, $itemSet['entries']) === false) {
					continue;
				}

				$values = [
					$itemSetId,
					$lootContainerId,
					$itemSet['label'],
					$itemSet['minEntries'],
					$itemSet['maxEntries'],
					$itemSet['weight'],
					$itemSet['preventDuplicates'],
				];

				if (array_key_exists($itemSetId, $existingSets)) {
					unset($existingSets[$itemSetId]);
					$sql = 'UPDATE arksa.loot_item_sets SET loot_drop_id = $2, label = $3, min_entries = $4, max_entries = $5, weight = $6, prevent_duplicates = $7 WHERE loot_item_set_id = $1 AND (loot_drop_id != $2 OR label != $3 OR min_entries != $4 OR max_entries != $5 OR weight != $6::NUMERIC(16,6) OR prevent_duplicates != $7);';
				} else {
					$sql = 'INSERT INTO arksa.loot_item_sets SET (loot_item_set_id, loot_drop_id, label, min_entries, max_entries, weight, prevent_duplicates, sync_sort_key) VALUES ($1, $2, $3, $4, $5, $6, $7, $8);';
					$values[] = bin2hex(random_bytes(4));
				}
				$database->Query($sql, $values);
			}
		}

		foreach ($existingSets as $itemSetId => $itemSet) {
			$database->Query('DELETE FROM arksa.loot_item_sets WHERE loot_item_set_id = $1;', $itemSetId);
		}
	}

	protected function SaveItemSetEntries(BeaconDatabase $database, string $lootItemSetId, ?array $entries): bool {
		$rows = $database->Query('SELECT loot_item_set_entry_id FROM arksa.loot_item_set_entries WHERE loot_item_set_id = $1', $lootItemSetId);
		$existingEntries = [];
		$entriesSaved = 0;
		while (!$rows->EOF()) {
			$entryId = $rows->Field('loot_item_set_entry_id');
			$existingEntries[$entryId] = true;
			$rows->MoveNext();
		}

		if (is_null($entries) === false) {
			foreach ($entries as $entry) {
				$entryId = $entry['lootItemSetEntryId'];
				if (BeaconCommon::IsUUID($entryId) === false) {
					throw new Exception('Entry ID "' . $entryId . '" is not a UUID.');
				}

				if ($this->SaveItemSetEntryOptions($database, $entryId, $entry['options']) === false) {
					continue;
				}

				$values = [
					$entryId,
					$lootItemSetId,
					$entry['minQuantity'],
					$entry['maxQuantity'],
					$entry['minQuality'],
					$entry['maxQuality'],
					$entry['blueprintChance'],
					$entry['weight'],
					$entry['singleItemQuantity'],
					$entry['preventGrinding'],
					$entry['statClampMultiplier'],
				];

				if (array_key_exists($entryId, $existingEntries)) {
					unset($existingEntries[$entryId]);
					$sql = 'UPDATE arksa.loot_item_set_entries SET loot_item_set_id = $2, min_quantity = $3, max_quantity = $4, min_quality = $5, max_quality = $6, blueprint_chance = $7, weight = $8, single_item_quantity = $9, prevent_grinding = $10, stat_clamp_multiplier = $11 WHERE loot_item_set_entry_id = $1 AND (loot_item_set_id != $2 OR min_quantity != $3 OR max_quantity != $4 OR min_quality != $5 OR max_quality != $6 OR blueprint_chance != $7::NUMERIC(16,6) OR weight != $8::NUMERIC(16,6) OR single_item_quantity != $9 OR prevent_grinding != $10 OR stat_clamp_multiplier != $11::NUMERIC(16,6));';
				} else {
					$sql = 'INSERT INTO arksa.loot_item_set_entries (loot_item_set_entry_id, loot_item_set_id, min_quantity, max_quantity, min_quality, max_quality, blueprint_chance, weight, single_item_quantity, prevent_grinding, stat_clamp_multiplier, sync_sort_key) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12);';
					$values[] = bin2hex(random_bytes(4));
				}
				$database->Query($sql, $values);
				$entriesSaved++;
			}
		}

		foreach ($existingEntries as $entryId => $entry) {
			$database->Query('DELETE FROM arksa.loot_item_set_entries WHERE loot_item_set_entry_id = $1;', $entryId);
		}

		return $entriesSaved > 0;
	}

	protected function SaveItemSetEntryOptions(BeaconDatabase $database, string $lootItemSetEntryId, ?array $options): bool {
		$rows = $database->Query('SELECT loot_item_set_entry_option_id FROM arksa.loot_item_set_entry_options WHERE loot_item_set_entry_id = $1', $lootItemSetEntryId);
		$existingOptions = [];
		$optionsSaved = 0;
		while (!$rows->EOF()) {
			$optionId = $rows->Field('loot_item_set_entry_option_id');
			$existingOptions[$optionId] = true;
			$rows->MoveNext();
		}

		if (is_null($options) === false) {
			foreach ($options as $option) {
				$optionId = $option['lootItemSetEntryOptionId'];
				if (BeaconCommon::IsUUID($optionId) === false) {
					throw new Exception('Option ID "' . $optionId . '" is not a UUID.');
				}

				$values = [
					$optionId,
					$lootItemSetEntryId,
					$option['weight'],
					$option['engramId'],
				];

				if (array_key_exists($optionId, $existingOptions)) {
					unset($existingOptions[$optionId]);
					$sql = 'UPDATE arksa.loot_item_set_entry_options SET loot_item_set_entry_id = $2, weight = $3, engram_id = $4 WHERE loot_item_set_entry_option_id = $1 AND (loot_item_set_entry_id != $2 OR weight != $3::NUMERIC(16,6) OR engram_id != $4);';
				} else {
					$sql = 'INSERT INTO arksa.loot_item_set_entry_options (loot_item_set_entry_option_id, loot_item_set_entry_id, weight, engram_id, sync_sort_key) VALUES ($1, $2, $3, $4, $5);';
					$values[] = bin2hex(random_bytes(4));
				}
				$database->Query($sql, $values);
				$optionsSaved++;
			}
		}

		foreach ($existingOptions as $optionId => $option) {
			$database->Query('DELETE FROM arksa.loot_item_set_entry_options WHERE loot_item_set_entry_option_id = $1;', $optionId);
		}

		return $optionsSaved > 0;
	}
}

?>
