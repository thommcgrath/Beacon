<?php

class BeaconLootSource extends BeaconBlueprint {
	private $multiplier_min;
	private $multiplier_max;
	private $ui_color;
	private $icon_id;
	private $sort_order;
	private $required_item_sets;
	private $experimental;
	private $notes;
	
	protected static function SQLColumns() {
		$columns = parent::SQLColumns();
		$columns[] = 'multiplier_min';
		$columns[] = 'multiplier_max';
		$columns[] = 'uicolor';
		$columns[] = 'icon';
		$columns[] = 'sort';
		$columns[] = 'required_item_sets';
		$columns[] = 'experimental';
		$columns[] = 'notes';
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
		case 'ui_color':
			return $this->ui_color;
		case 'icon':
			return $this->icon_id;
		case 'sort_order':
			return $this->sort_order;
		case 'required_item_sets':
			return $this->required_item-sets;
		case 'experimental':
			return $this->experimental;
		case 'notes':
			return $this->notes;
		default:
			parent::GetColumnValue($column);
		}
	}
	
	protected static function FromRow(BeaconRecordSet $row) {
		$obj = parent::FromRow($row);
		if ($obj === null) {
			return null;
		}
		$obj->multiplier_min = floatval($row->Field('multiplier_min'));
		$obj->multiplier_max = floatval($row->Field('multiplier_max'));
		$obj->ui_color = $row->Field('uicolor');
		$obj->icon_id = $row->Field('icon');
		$obj->sort_order = intval($row->Field('sort'));
		$obj->required_item_sets = intval($row->Field('required_item_sets'));
		$obj->experimental = boolval($row->Field('experimental'));
		$obj->notes = $row->Field('notes');
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
		$json['required_item_sets'] = $this->required_item_sets;
		$json['experimental'] = $this->experimental;
		$json['notes'] = $this->notes;
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
	
	public function RequiredItemSets() {
		return $this->required_item_sets;
	}
	
	public function SetRequiredItemSets(int $required_item_sets) {
		$this->required_item_sets = max(1, $required_item_sets);
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
}

?>