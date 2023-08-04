<?php

namespace BeaconAPI\v4\Ark;
use BeaconAPI\v4\{DatabaseObjectProperty, MutableDatabaseObject};

trait MutableGenericObject {
	use MutableDatabaseObject {
		PreparePropertyValue as protected MutableDatabaseObjectPreparePropertyValue;
	}
	
	protected static function PreparePropertyValue(DatabaseObjectProperty $definition, mixed $value): mixed {
		switch ($definition->PropertyName()) {
		case 'tags':
			return '{' . implode(',', $value) . '}';
		default:
			return static::MutableDatabaseObjectPreparePropertyValue($definition, $value);
		}
	}
}

?>
