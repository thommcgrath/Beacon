#!/usr/bin/php -q
<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

use BeaconAPI\v4\Sentinel\Dino;

$database = BeaconCommon::Database();
$database->BeginTransaction();
$rows = $database->Query("DELETE FROM sentinel.services WHERE user_id IN (SELECT user_id FROM (SELECT user_id, game_id, MAX(date_expires) + MAX((user_subscriptions.metadata->>'gracePeriod' || ' days')::INTERVAL) AS purge_date FROM public.user_subscriptions GROUP BY user_id, game_id) WHERE purge_date < CURRENT_TIMESTAMP) RETURNING service_id;");
echo "Deleted {$rows->RecordCount()} services.\n";
$rows = $database->Query("DELETE FROM sentinel.service_logs WHERE message_id IN (SELECT DISTINCT message_id FROM sentinel.service_logs INNER JOIN sentinel.services ON (service_logs.service_id = services.service_id) INNER JOIN public.user_subscriptions ON (services.user_id = user_subscriptions.user_id AND user_subscriptions.game_id = 'Sentinel') WHERE service_logs.log_time < CURRENT_TIMESTAMP - (user_subscriptions.metadata->>'retentionDays' || ' days')::INTERVAL) RETURNING message_id;");
echo "Deleted {$rows->RecordCount()} log messages.\n";
$rows = $database->Query("DELETE FROM sentinel.dinos WHERE dino_id IN (SELECT DISTINCT dino_id FROM sentinel.dinos INNER JOIN sentinel.services ON (dinos.service_id = services.service_id) INNER JOIN public.user_subscriptions ON (services.user_id = user_subscriptions.user_id AND user_subscriptions.game_id = 'Sentinel') WHERE dinos.status = $1 AND dinos.last_update < CURRENT_TIMESTAMP - (user_subscriptions.metadata->>'retentionDays' || ' days')::INTERVAL) RETURNING dino_id;", Dino::StatusDead);
echo "Deleted {$rows->RecordCount()} dead dinos.\n";
$rows = $database->Query("DELETE FROM sentinel.watcher_logs WHERE message_time < CURRENT_TIMESTAMP - '30 days'::INTERVAL RETURNING message_id;");
echo "Deleted {$rows->RecordCount()} watcher messages.\n";
$rows = $database->Query("DELETE FROM sentinel.scripts WHERE deleted = TRUE AND date_modified < CURRENT_TIMESTAMP = '30 days'::INTERVAL AND script_id NOT IN (SELECT DISTINCT script_id FROM sentinel.active_scripts) RETURNING script_id;");
echo "Deleted {$rows->RecordCount()} unused scripts.\n";
$database->Commit();
echo "Sentinel data cleaned\n";

?>
