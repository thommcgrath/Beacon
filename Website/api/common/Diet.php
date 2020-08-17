<?php

namespace BeaconAPI;

class Diet extends \BeaconObject implements \ArrayAccess {
	protected $engram_ids = array();
	
	protected static function FromRow(\BeaconRecordSet $row) {
		$obj = parent::FromRow($row);
		if ($obj === null) {
			return null;
		}
		
		$database = \BeaconCommon::Database();
		$results = $database->Query('SELECT engram_id FROM diet_contents WHERE diet_id = $1 ORDER BY preference_order;', $obj->ObjectID());
		while (!$results->EOF()) {
			$obj->engram_ids[] = $results->Field('engram_id');
			$results->MoveNext();
		}
		
		return $obj;
	}
	
	protected static function TableName() {
		return 'diets';
	}
	
	public function jsonSerialize() {
		$json = parent::jsonSerialize();
		$json['engram_ids'] = $this->engram_ids;
		return $json;
	}
	
	public function EngramIDs() {
		return $this->engram_ids;
	}
	
	public function CreatureIDs() {
		$database = \BeaconCommon::Database();
		$results = $database->Query('SELECT DISTINCT object_id, label FROM creatures WHERE taming_diet = $1 OR tamed_diet = $1 ORDER BY label;', $this->ObjectID());
		$arr = array();
		while (!$results->EOF()) {
			$arr[] = $results->Field('object_id');
			$results->MoveNext();
		}
		return $arr;
	}
	
	protected function SaveChildrenHook(\BeaconDatabase $database) {
		$database->Query('DELETE FROM diet_contents WHERE diet_id = $1 AND engram_id != ANY($2);', $this->ObjectID(), '{' . implode(',', $this->engram_ids) . '}');
		$c = 0;
		foreach ($this->engram_ids as $engram_id) {
			$database->Query('INSERT INTO diet_contents (diet_id, engram_id, preference_order) VALUES ($1, $2, $3) ON CONFLICT diet_contents_diet_id_engram_id_key DO UPDATE SET preference_order = $3;', $this->ObjectID(), $engram_id, $c++);
		}
	}
	
	public function offsetSet($offset, $value) {
        if (is_null($offset)) {
            $this->engram_ids[] = $value;
        } else {
            $this->engram_ids[$offset] = $value;
        }
    }
    
    public function offsetExists($offset) {
        return isset($this->engram_ids[$offset]);
    }
    
    public function offsetUnset($offset) {
        unset($this->engram_ids[$offset]);
    }
    
    public function offsetGet($offset) {
        return isset($this->engram_ids[$offset]) ? $this->engram_ids[$offset] : null;
    }
}

?>
