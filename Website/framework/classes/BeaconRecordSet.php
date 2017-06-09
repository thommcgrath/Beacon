<?php

abstract class BeaconRecordSet {
	abstract public function __construct($result);
	abstract public function RecordCount();
	abstract public function MoveTo(int $offset);
	abstract public function BOF();
	abstract public function EOF();
	abstract public function MoveFirst();
	abstract public function MovePrevious();
	abstract public function MoveNext();
	abstract public function MoveLast();
	abstract public function Field($columnOrIndex);
	abstract public function FieldCount();
	abstract public function FieldName(int $index);
	abstract public function IndexOf(string $column);
}

?>