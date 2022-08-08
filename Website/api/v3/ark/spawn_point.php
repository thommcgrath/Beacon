<?php

require(dirname(__FILE__, 2) . '/loader.php');

$manager = new BeaconObjectManager('Ark\SpawnPoint');
$manager->HandleAPIRequest();

?>