#!/usr/bin/php -q
<?php
	
require(dirname(__FILE__, 2) . '/framework/loader.php');

$database = BeaconCommon::Database();
$database->BeginTransaction();
$results = $database->Query('SELECT exception_id, exception_hash, exception_type, build, reason, trace, solution_details, solution_min_build FROM exceptions_legacy');
while (!$results->EOF()) {
	$exception_id = $results->Field('exception_id');
	$client_hash = $results->Field('exception_hash');
	$type = $results->Field('exception_type');
	$client_build = $results->Field('build');
	$reason = $results->Field('reason');
	$trace = $results->Field('trace');
	$solution_details = $results->Field('solution_details');
	$solution_min_build = $results->Field('solution_min_build');
	
	$new_exception_id = BeaconExceptions::RecordException($trace, $type, $reason, $client_hash, $client_build, null);
	if (is_null($new_exception_id)) {
		$results->MoveNext();
		continue;
	}
	
	if (!is_null($solution_min_build)) {
		$database->Query('UPDATE exceptions SET solution_build = $2, solution_comments = $3 WHERE exception_id = $1 AND max_reported_build < $2;', $new_exception_id, $solution_min_build, $solution_details);
	}
	
	$comments = $database->Query('SELECT build, comments, date FROM exception_comments_legacy WHERE exception_id = $1;', $exception_id);
	while (!$comments->EOF()) {
		$database->Query('INSERT INTO exception_comments (exception_id, comments, date) VALUES ($1, $2, $3);', $new_exception_id, $comments->Field('comments'), $comments->Field('date'));
		$database->Query('UPDATE exceptions SET min_reported_build = LEAST(min_reported_build, $2), max_reported_build = GREATEST(max_reported_build, $2) WHERE exception_id = $1;', $new_exception_id, $comments->Field('build'));
		$comments->MoveNext();
	}
	
	$results->MoveNext();
}
$database->Commit();

?>