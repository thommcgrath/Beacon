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
$overviewUrl = 'http://' . BeaconCommon::GetGlobal('RabbitMQ Host') . ':' . BeaconCommon::GetGlobal('RabbitMQ Management Port') . '/api/overview?lengths_age=60&lengths_incr=10&msg_rates_age=60&msg_rates_incr=10';
$curl = curl_init($overviewUrl);
curl_setopt($curl, CURLOPT_USERPWD, BeaconCommon::GetGlobal('RabbitMQ User') . ":" . BeaconCommon::GetGlobal('RabbitMQ Password'));
curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
$responseBody = curl_exec($curl);
$responseStatus = curl_getinfo($curl, CURLINFO_HTTP_CODE);
$responseError = curl_error($curl);
curl_close($curl);

if ($responseStatus !== 200) {
	echo "Metrics overview request returned status {$responseStatus}:\n";
	echo $responseError;
	echo $responseBody;
	return;
}

$overview = json_decode($responseBody, true);
$queueTotals = $overview['queue_totals'];
$waitingEventCount = $queueTotals['messages'];
$messageStats = $overview['message_stats'];
$publishRate = $messageStats['publish_details']['avg_rate'] ?? 0;
$deliverRate = ($messageStats['deliver_details']['avg_rate'] ?? 0) + ($messageStats['deliver_no_ack_details']['avg_rate'] ?? 0);
$ackRate = ($messageStats['ack_details']['avg_rate'] ?? 0) + ($messageStats['deliver_no_ack_details']['avg_rate'] ?? 0);

$database = BeaconCommon::Database();
$rows = $database->Query("SELECT SUM(is_connected::INT) AS servers_connected, COUNT(*) AS total_servers FROM sentinel.services WHERE user_id IN (SELECT user_id FROM public.user_subscriptions WHERE date_expires > CURRENT_TIMESTAMP AND game_id = 'Sentinel') AND cluster_id != '00000000-0000-0000-0000-000000000000';");
$connectionPercent = intval($rows->Field('servers_connected')) / intval($rows->Field('total_servers'));

$metrics = [
	'queued_events' => [
		[
			'y' => intval($waitingEventCount),
		],
	],
	'publish_rate' => [
		[
			'y' => floatval($publishRate),
		],
	],
	'deliver_rate' => [
		[
			'y' => floatval($deliverRate),
		],
	],
	'ack_rate' => [
		[
			'y' => floatval($ackRate),
		],
	],
	'connections' => [
		[
			'y' => $connectionPercent * 100,
		],
	],
];

if ($waitingEventCount > 0 && $ackRate === 0) {
	$status = STATUS_OUTAGE;
} elseif ($publishRate > ($ackRate * 1.5)) {
	if ($deliverRate > 0) {
		$status = STATUS_DEGRADED;
	} else {
		$status = STATUS_OUTAGE;
	}
}

if (BeaconCommon::InProduction()) {
	$curl = curl_init('https://status.usebeacon.app/state_webhook/watchdog/68217390386fb3052b0d8fcf');
	curl_setopt($curl, CURLOPT_HTTPHEADER, [
		'X-WEBHOOK-KEY: ' . BeaconCommon::GetGlobal('Hund Sentinel Status Key'),
	]);
	curl_setopt($curl, CURLOPT_CUSTOMREQUEST, 'POST');
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($curl, CURLOPT_POSTFIELDS, ['status' => $status]);
	$responseBody = curl_exec($curl);
	$responseStatus = curl_getinfo($curl, CURLINFO_HTTP_CODE);
	curl_close($curl);

	if ($responseStatus === 200) {
		echo "webhook successful\n";
	} else {
		echo "{$responseStatus}\n{$responseBody}\n";
	}

	// Send the metrics, because this couldn't be done in one request for some dumb reason
	$curl = curl_init('https://status.usebeacon.app/state_webhook/metrics/68217390386fb3052b0d8fd7');
	curl_setopt($curl, CURLOPT_HTTPHEADER, [
		'Content-Type: application/json',
		'X-WEBHOOK-KEY: ' . BeaconCommon::GetGlobal('Hund Sentinel Status Key'),
	]);
	curl_setopt($curl, CURLOPT_CUSTOMREQUEST, 'POST');
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode(['metrics' => $metrics]));
	$responseBody = curl_exec($curl);
	$responseStatus = curl_getinfo($curl, CURLINFO_HTTP_CODE);
	curl_close($curl);

	if ($responseStatus === 204) {
		echo "metrics successful\n";
		echo json_encode($metrics, JSON_PRETTY_PRINT) . "\n";
	} else {
		echo "{$responseStatus}\n{$responseBody}\n";
	}
} else {
	echo "Status: {$status}\n";
	echo json_encode($metrics, JSON_PRETTY_PRINT);
}

?>
