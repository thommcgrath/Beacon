<?php

require(dirname(__FILE__) . '/loader.php');

$manager = new BeaconObjectManager('BeaconCreature');
$manager->HandleAPIRequest();

?>