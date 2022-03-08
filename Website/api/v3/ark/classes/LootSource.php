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
		$columns[] = '(SELECT array_to_json(array_agg(row_to_json(sets_template))) FROM (SELECT loot_item_set_id, label, min_entries, max_entries, weight, prevent_duplicates, (SELECT array_to_json(array_agg(row_to_json(entries_template))) FROM (SELECT loot_item_set_entry_id, min_quantity, max_quantity, min_quality, max_quality, blueprint_chance, weight, single_item_quantity, prevent_grinding, stat_clamp_multiplier, (SELECT array_to_json(array_agg(row_to_json(options_template))) FROM (SELECT loot_item_set_entry_option_id, engram_id, weight FROM ark.loot_item_set_entry_options WHERE loot_item_set_entry_options.loot_item_set_entry_id = loot_item_set_entries.loot_item_set_entry_id) AS options_template) AS options FROM ark.loot_item_set_entries WHERE loot_item_set_entries.loot_item_set_id = loot_item_sets.loot_item_set_id) AS entries_template) AS entries FROM ark.loot_item_sets WHERE loot_item_sets.loot_source_id = loot_sources.object_id) AS sets_template) AS item_sets';
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
			$obj->item_sets = json_decode($row->Field('item_sets'), true);
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
		if (array_key_exists('item_sets', $json)) {
			$sets = $json['item_sets'];
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
		default:
			return parent::GetColumnValue($column);
		}
	}
	
	protected function SaveChildrenHook(\BeaconDatabase $database) {
		parent::SaveChildrenHook($database);
		
		$this->SaveItemSets($database);
	}
	
	protected function SaveItemSets(\BeaconDatabase $database) {
	}
}

?>
