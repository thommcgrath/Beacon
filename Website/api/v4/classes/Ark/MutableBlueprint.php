<?php

namespace BeaconAPI\v4\Ark;
use BeaconAPI\v4\MutableDatabaseObject;

class MutableBlueprint extends Blueprint {
	use MutableDatabaseObject {
		Validate as protected MutableDatabaseObjectValidate;
	}
}

?>
