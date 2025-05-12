#!/usr/bin/php -q
<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

while (ob_get_level() > 0) {
	ob_end_clean();
}

define('STATUS_OUTAGE', -1);
define('STATUS_DEGRADED', 0);
define('STATUS_OPERATIONAL', 1);

$status = STATUS_OPERATIONAL;
$database = BeaconCommon::Database();
$rows = $database->Query('SELECT COUNT(*) FROM sentinel.service_event_queue WHERE status = $1;', 'Waiting');
$metrics = [
	'queued_events' => [
		[
			'y' => $rows->RecordCount(),
		],
	],
];
if ($rows->RecordCount() >= 10) {
	$status = STATUS_DEGRADED;
}

// Find the age of the oldest queue item
$rows = $database->Query('SELECT EXTRACT(EPOCH FROM CURRENT_TIMESTAMP) - EXTRACT(EPOCH FROM queue_time) AS age FROM sentinel.service_event_queue WHERE status = $1 ORDER BY queue_time ASC LIMIT 1;', 'Waiting');
if ($rows->RecordCount() > 0 && $rows->Field('age') >= 60) {
	$status = STATUS_OUTAGE;
}

$curl = curl_init('https://status.usebeacon.app/state_webhook/watchdog/68217390386fb3052b0d8fcf');
curl_setopt($curl, CURLOPT_HTTPHEADER, [
	'X-WEBHOOK-KEY: ' . BeaconCommon::GetGlobal('Hund Sentinel Status Key'),
]);
curl_setopt($curl, CURLOPT_CUSTOMREQUEST, 'POST');
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
curl_setopt($curl, CURLOPT_POSTFIELDS, ['status' => $status]);
$response = curl_exec($curl);
$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
curl_close($curl);

// Send the metrics, because this couldn't be done in one request for some dumb reason
$curl = curl_init('https://status.usebeacon.app/state_webhook/metrics/68217390386fb3052b0d8fd7');
curl_setopt($curl, CURLOPT_HTTPHEADER, [
	'Content-Type: application/json',
	'X-WEBHOOK-KEY: ' . BeaconCommon::GetGlobal('Hund Sentinel Status Key'),
]);
curl_setopt($curl, CURLOPT_CUSTOMREQUEST, 'POST');
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode(['metrics' => $metrics]));
$response = curl_exec($curl);
$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
curl_close($curl);

?>
