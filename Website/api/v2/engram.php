<?php

// Anybody can GET information about any engram without authorization. Other
// actions require authentication.

require(dirname(__FILE__) . '/loader.php');

$manager = new BeaconObjectManager('BeaconEngram');
$manager->HandleAPIRequest();

?>