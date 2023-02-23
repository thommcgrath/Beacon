<?php

use BeaconAPI\v4\Response;

function handleRequest(array $context): Response {
	http_response_code(200);
	$now = new DateTime('now', new DateTimeZone('UTC'));
	//echo $now->format('Y-m-d H:i:sO');
	return Response::NewJson([
		'sql' => $now->format('Y-m-d H:i:sO'),
		'unixEpoch' => $now->format('U'),
		'iso8601' => $now->format('c'),
		'rfc2822' => $now->format('r')
	], 200);
}

?>