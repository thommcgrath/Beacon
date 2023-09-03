<?php

// Anybody can GET information about any engram without authorization. Other
// actions require authentication.

require(dirname(__FILE__, 2) . '/loader.php');

$manager = new BeaconObjectManager('Ark\Engram');
$manager->HandleAPIRequest();

?>