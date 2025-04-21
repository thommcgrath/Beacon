#!/usr/bin/php -q
<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

$database = BeaconCommon::Database();
$database->BeginTransaction();
$rows = $database->Query("DELETE FROM sentinel.services WHERE service_id IN (SELECT DISTINCT service_id FROM sentinel.services INNER JOIN public.user_subscriptions ON (services.user_id = user_subscriptions.user_id AND user_subscriptions.game_id = 'Sentinel') WHERE user_subscriptions.date_expires < CURRENT_TIMESTAMP - (user_subscriptions.metadata->>'gracePeriod' || ' days')::INTERVAL) RETURNING service_id;");
echo "Deleted {$rows->RecordCount()} services.\n";
$rows = $database->Query("DELETE FROM sentinel.service_logs WHERE message_id IN (SELECT DISTINCT message_id FROM sentinel.service_logs INNER JOIN sentinel.services ON (service_logs.service_id = services.service_id) INNER JOIN public.user_subscriptions ON (services.user_id = user_subscriptions.user_id AND user_subscriptions.game_id = 'Sentinel') WHERE service_logs.log_time < CURRENT_TIMESTAMP - (user_subscriptions.metadata->>'retentionDays' || ' days')::INTERVAL) RETURNING message_id;");
echo "Deleted {$rows->RecordCount()} log messages.\n";
$database->Commit();
echo "Sentinel data cleaned\n";

?>
