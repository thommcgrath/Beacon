<?php

namespace Ark;

class ConfigLine extends \BeaconAPI\Ark\ConfigLine {
	protected ?array $uwp_changes;
	
	protected static function SQLColumns() {
		$columns = parent::SQLColumns();
		$columns[] = 'uwp_changes';
		return $columns;
	}
	
	protected static function FromRow(\BeaconRecordSet $row) {
		$obj = parent::FromRow($row);
		if ($obj === null) {
			return null;
		}
		$obj->uwp_changes = is_null($row->Field('uwp_changes')) ? null : json_decode($row->Field('uwp_changes'), true);
		return $obj;
	}
	
	public function jsonSerialize(): mixed {
		$json = parent::jsonSerialize();
		$json['resource_url'] = \BeaconAPI::URL('ark/ini_option/' . urlencode($this->ObjectID()));
		$json['uwp_changes'] = $this->uwp_changes;
		return $json;
	}
}

?>
