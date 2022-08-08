<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');
header('Cache-Control: no-cache');

$username = BeaconLogin::GenerateUsername();

header('Content-Type: application/json');
echo json_encode(array('username' => $username), JSON_PRETTY_PRINT);

?>