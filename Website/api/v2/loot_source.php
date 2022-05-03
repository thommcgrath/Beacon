<?php

require(dirname(__FILE__) . '/loader.php');

$manager = new BeaconObjectManager('Ark\LootSource');
$manager->HandleAPIRequest();

?>