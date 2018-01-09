<?php

class BeaconLootSource extends BeaconBlueprint {
	const KIND_STANDARD = 'Standard';
	const KIND_BONUS = 'Bonus';
	const KIND_CAVE = 'Cave';
	const KIND_SEA = 'Sea';
	
	private $kind;
	private $multiplier_min;
	private $multiplier_max;
	private $ui_color;
	private $icon;
	private $sort_order;
	private $required_item_sets;
	
	protected static function SQLColumns() {
		$columns = parent::SQLColumns();
		$columns[] = 'kind';
		$columns[] = 'multiplier_min';
		$columns[] = 'multiplier_max';
		$columns[] = 'uicolor';
		$columns[] = 'icon';
		$columns[] = 'sort';
		$columns[] = 'required_item_sets';
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
		case 'kind':
			return $this->kind;
		case 'multiplier_min':
			return $this->multiplier_min;
		case 'multiplier_max':
			return $this->multiplier_max;
		case 'ui_color':
			return $this->ui_color;
		case 'icon':
			return $this->icon;
		case 'sort_order':
			return $this->sort_order;
		case 'required_item_sets':
			return $this->required_item-sets;
		default:
			parent::GetColumnValue($column);
		}
	}
	
	protected static function FromRow(BeaconRecordSet $row) {
		$obj = parent::FromRow($row);
		if ($obj === null) {
			return null;
		}
		$obj->kind = $row->Field('kind');
		$obj->multiplier_min = floatval($row->Field('multiplier_min'));
		$obj->multiplier_max = floatval($row->Field('multiplier_max'));
		$obj->ui_color = $row->Field('uicolor');
		$obj->icon = $row->Field('icon');
		$obj->sort_order = intval($row->Field('sort'));
		$obj->required_item_sets = intval($row->Field('required_item_sets'));
		return $obj;
	}
	
	public function jsonSerialize() {
		$json = parent::jsonSerialize(); 
		$json['kind'] = $this->kind;
		$json['multipliers'] = array(
			'min' => $this->multiplier_min,
			'max' => $this->multiplier_max
		);
		$json['ui_color'] = $this->ui_color;
		$json['icon'] = base64_encode($this->icon);
		$json['sort_order'] = $this->sort_order;
		$json['required_item_sets'] = $this->required_item_sets;  
		return $json;
	}
	
	public function Kind() {
		return $this->kind;
	}
	
	public function SetKind(string $kind) {
		switch ($kind) {
		case self::KIND_STANDARD:
		case self::KIND_BONUS:
		case self::KIND_CAVE:
		case self::KIND_SEA:
			$this->kind = $kind;
			break;
		}
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
	
	public function Icon() {
		return $this->icon;
	}
	
	public function SetIcon(string $icon) {
		// must be 144x144 png
		$info = getimagesizefromstring($icon);
		if ($info === false) {
			return;
		}
		$width = $info[0];
		$height = $info[1];
		$type = $info[2];
		
		if (($width == 144) && ($height == 144) && ($type == IMAGETYPE_PNG)) {
			$this->icon = $icon;
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
}

?>