<?php

namespace BeaconAPI\Ark;

class LootSource extends \Ark\Blueprint {
	protected $multiplier_min;
	protected $multiplier_max;
	protected $ui_color;
	protected $icon_id;
	protected $icon_color;
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
		$columns[] = 'public.ui_color_to_hex(icon_color) AS uicolor';
		$columns[] = 'icon';
		$columns[] = 'icon_color';
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
		case 'icon_color':
			return $this->icon_color;
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
		$obj->icon_color = $row->Field('icon_color');
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
		$json['icon_color'] = $this->icon_color;
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

	public function IconID() {
		return $this->icon_id;
	}

	public function SetIconID(string $icon_id) {
		if (BeaconCommon::IsUUID($icon_id)) {
			$this->icon_id = $icon_id;
		}
	}

	public function IconColor() {
		return $this->icon_color;
	}

	public function SetIconColor(string $icon_color) {
		$this->icon_color = $icon_color;
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

		if (array_key_exists('icon_color', $json)) {
			$this->icon_color = ucfirst($json['icon_color']);
		} elseif (array_key_exists('ui_color', $json)) {
			switch (strtoupper($json['ui_color'])) {
			case 'FFFFFF00';
				$this->icon_color = 'White';
				break;
			case '00FF0000';
				$this->icon_color = 'Green';
				break;
			case '88C8FF00';
				$this->icon_color = 'Blue';
				break;
			case 'E6BAFF00';
				$this->icon_color = 'Purple';
				break;
			case 'FFF02A00';
				$this->icon_color = 'Yellow';
				break;
			case 'FFBABA00';
				$this->icon_color = 'Red';
				break;
			case '00FFFF00';
				$this->icon_color = 'Cyan';
				break;
			case 'FFA50000';
				$this->icon_color = 'Orange';
				break;
			default:
				$this->icon_color = 'White';
				break;
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
