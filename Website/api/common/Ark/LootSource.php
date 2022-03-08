<?php

namespace BeaconAPI\Ark;

class LootSource extends \Ark\Blueprint {
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
	
	public function jsonSerialize() {
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
}

?>
