<?php

namespace Ark;

class LootSource extends \BeaconAPI\Ark\LootSource {
	protected $min_item_sets = 1;
	protected $max_item_sets = 1;
	protected $prevent_duplicates = true;
	protected $item_sets = null;
	
	protected static function SQLColumns() {
		$columns = parent::SQLColumns();
		$columns[] = 'min_item_sets';
		$columns[] = 'max_item_sets';
		$columns[] = 'prevent_duplicates';
		$columns[] = '(SELECT array_to_json(array_agg(row_to_json(sets_template))) FROM (SELECT loot_item_set_id, label, min_entries, max_entries, weight, prevent_duplicates, (SELECT array_to_json(array_agg(row_to_json(entries_template))) FROM (SELECT loot_item_set_entry_id, min_quantity, max_quantity, min_quality, max_quality, blueprint_chance, weight, single_item_quantity, prevent_grinding, stat_clamp_multiplier, (SELECT array_to_json(array_agg(row_to_json(options_template))) FROM (SELECT loot_item_set_entry_option_id, engram_id, path, class_string, mod_id, weight FROM ark.loot_item_set_entry_options INNER JOIN ark.engrams ON (loot_item_set_entry_options.engram_id = engrams.object_id) WHERE loot_item_set_entry_options.loot_item_set_entry_id = loot_item_set_entries.loot_item_set_entry_id) AS options_template) AS options FROM ark.loot_item_set_entries WHERE loot_item_set_entries.loot_item_set_id = loot_item_sets.loot_item_set_id) AS entries_template) AS entries FROM ark.loot_item_sets WHERE loot_item_sets.loot_source_id = loot_sources.object_id) AS sets_template) AS item_sets';
		return $columns;
	}
	
	protected static function FromRow(\BeaconRecordSet $row) {
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
				for ($entry_idx = 0; $entry_idx < count($item_set['entries']); $entry_idx++) {
					$entry = $item_set['entries'][$entry_idx];
					for ($option_idx = 0; $option_idx < count($entry['options']); $option_idx++) {
						$option = $entry['options'][$option_idx];
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
	}
	
	public function jsonSerialize() {
		$json = parent::jsonSerialize();
		$json['min_item_sets'] = $this->min_item_sets;
		$json['max_item_sets'] = $this->max_item_sets;
		$json['prevent_duplicates'] = $this->prevent_duplicates;
		if (is_null($this->item_sets) || count($this->item_sets) == 0) {
			$json['contents'] = null;
		} else {
			$json['contents'] = $this->item_sets;
		}
		return $json;
	}
	
	public function ConsumeJSON(array $json) {
		parent::ConsumeJSON($json);
			
		if (array_key_exists('min_item_sets', $json)) {
			if (is_numeric($json['min_item_sets'])) {
				$this->min_item_sets = intval($json['min_item_sets']);
			} else {
				throw new \Exception('Minimum item sets must be a number greater than or equal to zero.');
			}
		}
		if (array_key_exists('max_item_sets', $json)) {
			if (is_numeric($json['max_item_sets'])) {
				$this->max_item_sets = intval($json['max_item_sets']);
			} else {
				throw new \Exception('Maximum item sets must be a number greater than or equal to zero.');
			}
		}
		if (array_key_exists('prevent_duplicates', $json)) {
			if (is_bool($json['prevent_duplicates'])) {
				$this->prevent_duplicates = boolval($json['prevent_duplicates']);
			} else {
				throw new \Exception('Prevent duplicates must be a boolean.');
			}
		}
		if (array_key_exists('contents', $json)) {
			$sets = $json['contents'];
			if (is_null($sets) || (is_array($sets) && \BeaconCommon::IsAssoc($sets) === false)) {
				$this->item_sets = $sets;
			} else {
				throw new \Exception('Item sets must be an array of loot item sets.');
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
	
	protected function SaveChildrenHook(\BeaconDatabase $database) {
		parent::SaveChildrenHook($database);
		
		$this->SaveItemSets($database);
	}
	
	protected function SaveItemSets(\BeaconDatabase $database): void {
		$loot_source_id = $this->ObjectID();
		$keep_sets = [];
		$counters = [];
		if (is_null($this->item_sets) === false) {
			foreach ($this->item_sets as $item_set) {
				$loot_item_set_id = $item_set['loot_item_set_id'];
				if (\BeaconCommon::IsUUID($loot_item_set_id)) {
					$keep_sets[] = $loot_item_set_id;
				} else {
					throw new \Exception('Item set ID is not a v4 UUID.');
				}
				
				$item_set['sync_sort_key'] = \BeaconCommon::CreateUniqueSort(implode(',', [
					\BeaconCommon::SortString($item_set['label']),
					\BeaconCommon::SortDouble($item_set['weight'])
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
	
	protected function SaveItemSetEntries(\BeaconDatabase $database, string $loot_item_set_id, array|null $entries) {
		$keep_entries = [];
		$counters = [];
		if (is_null($entries) === false) {
			foreach ($entries as $entry) {
				$loot_item_set_entry_id = $entry['loot_item_set_entry_id'];
				if (\BeaconCommon::IsUUID($loot_item_set_entry_id)) {
					$keep_entries[] = $loot_item_set_entry_id;
				} else {
					throw new \Exception('Entry ID is not a v4 UUID.');
				}
				
				$entry['sync_sort_key'] = \BeaconCommon::CreateUniqueSort(implode(',', [
					\BeaconCommon::SortDouble($entry['weight']),
					\BeaconCommon::SortInteger($entry['min_quantity']),
					\BeaconCommon::SortInteger($entry['max_quantity']),
					\BeaconCommon::SortDouble($entry['blueprint_chance']),
					\BeaconCommon::SortString($entry['min_quality']),
					\BeaconCommon::SortString($entry['max_quality'])
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
	
	protected function SaveItemSetEntryOptions(\BeaconDatabase $database, string $loot_item_set_entry_id, array|null $options) {
		$keep_options = [];
		$counters = [];
		if (is_null($options) === false) {
			foreach ($options as $option) {
				$loot_item_set_entry_option_id = $option['loot_item_set_entry_option_id'];
				if (\BeaconCommon::IsUUID($loot_item_set_entry_option_id)) {
					$keep_options[] = $loot_item_set_entry_option_id;
				} else {
					throw new \Exception('Option ID is not a v4 UUID.');
				}
				
				if (array_key_exists('engram', $option)) {
					$class_string = $option['engram']['Class'];
					$option['engram_id'] = $option['engram']['UUID'];
					unset($option['engram']);
				} elseif (array_key_exists('engram_id', $option)) {
					$rows = $database->Query('SELECT class_string FROM ark.engrams WHERE object_id = $1;', $option['engram_id']);
					if ($rows->RecordCount() !== 1) {
						throw new \Exception('Unable to find engram by UUID.');
					}
					$class_string = $rows->Field('class_string');
				}
				
				$option['sync_sort_key'] = \BeaconCommon::CreateUniqueSort(implode(',', [
					\BeaconCommon::SortString($class_string),
					\BeaconCommon::SortDouble($option['weight'])
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
	}
}

?>
