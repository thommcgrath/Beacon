<?php

class BeaconPostgreSQLRecordSet extends BeaconRecordSet {
	private $result;
	private $offset;
	
	public function __construct($result) {
		$this->result = $result;
		$this->MoveTo(0);
	}
	
	public function __destruct() {
		pg_free_result($this->result);
	}
	
	public function RecordCount() {
		return pg_num_rows($this->result);
	}
	
	public function MoveTo(int $offset) {
		$this->offset = min($this->RecordCount(), max($offset, 0));
		pg_result_seek($this->result, $this->offset);
	}
	
	public function BOF() {
		return $this->offset <= 0;
	}
	
	public function EOF() {
		return $this->offset > ($this->RecordCount() - 1);
	}
	
	public function MoveFirst() {
		$this->MoveTo(0);
	}
	
	public function MovePrevious() {
		$this->MoveTo($this->offset - 1);
	}
	
	public function MoveNext() {
		$this->MoveTo($this->offset + 1);
	}
	
	public function MoveLast() {
		$this->MoveTo($this->RecordCount() - 1);
	}
	
	public function Field($columnOrIndex) {
		if (is_string($columnOrIndex)) {
			$index = $this->IndexOf($columnOrIndex);
		} elseif (is_int($columnOrIndex)) {
			$index = $columnOrIndex;
		} else {
			$index = -1;
		}
		if ($index < 0) {
			throw new Exception('Column ' . $columnOrIndex . ' not found');
		}
		
		if (pg_field_is_null($this->result, $index)) {
			return null;
		}
		
		$value = pg_fetch_result($this->result, $index);
		$type = pg_field_type($this->result, $index);
		switch ($type) {
		case 'boolean':
		case 'bool':
			return ($value == 't');
			break;
		case 'bytea':
			if (substr($value, 0, 2) == '\x') {
				return hex2bin(substr($value, 2));
			} else {
				return pg_unescape_bytea($value);
			}
			break;
		default:
			return $value;
			break;
		}
	}
	
	public function FieldCount() {
		return pg_num_fields($this->result);
	}
	
	public function FieldName(int $index) {
		if ((is_int($index) == false) || ($index < 0)) {
			throw new Exception('Must supply integer greater than zero for field index');
		}
		return pg_field_name($this->result, $index);
	}
	
	public function IndexOf(string $column) {
		$c = $this->FieldCount();
		for ($i = 0; $i < $c; $i++) {
			$name = $this->FieldName($i);
			if (strcasecmp($name, $column) == 0) {
				return $i;
			}
		}
		return -1;
	}
}

?>