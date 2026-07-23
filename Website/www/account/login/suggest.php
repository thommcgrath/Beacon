<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');
header('Cache-Control: no-cache, no-store, must-revalidate');

$username = BeaconLogin::GenerateUsername();

header('Content-Type: application/json');
echo json_encode(['username' => $username], JSON_PRETTY_PRINT);

?>