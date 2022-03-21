<?php

require(dirname(__FILE__) . '/loader.php');

$user_id = BeaconAPI::ObjectID();
$challenge = BeaconCommon::GenerateUUID();

$database = BeaconCommon::Database();
$database->BeginTransaction();
$database->Query('INSERT INTO user_challenges (user_id, challenge) VALUES ($1, $2) ON CONFLICT (user_id) DO UPDATE SET challenge = $2;', $user_id, $challenge);
$database->Commit();

echo json_encode(['user_id' => $user_id, 'challenge' => $challenge], JSON_PRETTY_PRINT);

?>