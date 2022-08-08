<?php

require(dirname(__FILE__) . '/loader.php');

$manager = new BeaconObjectManager('Ark\SpawnPoint');
$manager->HandleAPIRequest();

?>