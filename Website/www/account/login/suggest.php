<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');

$database = BeaconCommon::Database();
$results = $database->Query('SELECT generate_username() AS username;');
$username = $results->Field('username');

header('Content-Type: application/json');
echo json_encode(array('username' => $username), JSON_PRETTY_PRINT);

?>