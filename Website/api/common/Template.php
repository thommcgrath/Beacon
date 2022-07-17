<?php

namespace BeaconAPI;

class Template implements \JsonSerializable {
	protected $object_id;
	protected $game_id;
	protected $label;
	protected $min_version;
	protected $contents;
	
	public function jsonSerialize(): mixed {
		return [
			'id' => $this->object_id,
			'game' => $this->game_id,
			'label' => $this->label,
			'min_version' => $this->min_version,
			'contents' => $this->contents
		];
	}
	
	public function UUID() {
		return $this->object_id;
	}
	
	public function GameID() {
		return $this->game_id;
	}
	
	public function Label() {
		return $this->label;
	}
	
	public function MinVersion() {
		return $this->min_version;
	}
	
	public function Contents() {
		return $this->contents;
	}
	
	public static function GetAll(int $min_version = -1, \DateTime $updated_since = null) {
		$clauses = [];
		$values = [];
		$placeholder = 1;
		if ($min_version > -1) {
			$clauses[] = 'min_version <= $' . $placeholder;
			$values[] = $min_version;
			$placeholder++;
		}
		if (is_null($updated_since) === false) {
			$clauses[] = 'last_update > $' . $placeholder;
			$values[] = $updated_since->format('Y-m-d H:i:sO');
			$placeholder++;
		}
		
		$sql = 'SELECT object_id, label, min_version, contents, game_id FROM public.templates';
		if (count($clauses) > 0) {
			$sql .= ' WHERE ' . implode(' AND ', $clauses);
		}
		
		$rows = \BeaconCommon::Database()->Query($sql, $values);
		return static::FromRows($rows);
	}
	
	public static function GetByObjectID(string $object_id, int $min_version = -1) {
		$clauses = ['object_id = $1'];
		$values = [$object_id];
		$placeholder = 2;
		if ($min_version > -1) {
			$clauses[] = 'min_version <= $' . $placeholder;
			$values[] = $min_version;
			$placeholder++;
		}
		
		$sql = 'SELECT object_id, label, min_version, contents, game_id FROM public.templates';
		if (count($clauses) > 0) {
			$sql .= ' WHERE ' . implode(' AND ', $clauses);
		}
		
		$rows = \BeaconCommon::Database()->Query($sql, $values);
		if ($rows->RecordCount() === 1) {
			return static::FromRow($rows);
		}
	}
	
	protected static function FromRows(\BeaconRecordSet $rows) {
		if (($rows === null) || ($rows->RecordCount() == 0)) {
			return [];
		}
		
		$objects = [];
		while (!$rows->EOF()) {
			$object = static::FromRow($rows);
			if (is_null($object) === false) {
				$objects[] = $object;
			}
			$rows->MoveNext();
		}
		return $objects;
	}
	
	protected static function FromRow(\BeaconRecordSet $row) {
		$obj = new static();
		$obj->object_id = $row->Field('object_id');
		$obj->game_id = $row->Field('game_id');
		$obj->label = $row->Field('label');
		$obj->min_version = $row->Field('min_version');
		$obj->contents = $row->Field('contents');
		return $obj;
	}
}

?>
