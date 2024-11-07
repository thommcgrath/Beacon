#!/usr/bin/php -q
<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

$database = BeaconCommon::Database();
$clauses = [
	'public.access_tokens' => 'refresh_token_expiration < CURRENT_TIMESTAMP',
	'public.application_auth_flows' => "expiration + '30 days'::INTERVAL < CURRENT_TIMESTAMP",
	'public.oauth_requests' => 'expiration < CURRENT_TIMESTAMP',
];
$cleaningNeeded = [];
foreach ($clauses as $table => $clause) {
	$rows = $database->Query("SELECT EXISTS (SELECT FROM {$table} WHERE {$clause});");
	if ($rows->Field('exists')) {
		$cleaningNeeded[] = $table;
	}
}
if (count($cleaningNeeded) === 0) {
	echo "No cleanup necessary.\n";
	exit;
}

$database->BeginTransaction();
foreach ($cleaningNeeded as $table) {
	$clause = $clauses[$table];
	$database->Query("DELETE FROM {$table} WHERE {$clause};");
}
$database->Commit();

echo "Expired data has been cleaned.\n";
exit;

?>
