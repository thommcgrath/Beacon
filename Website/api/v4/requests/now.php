<?php

use BeaconAPI\v4\Response;

$requiredScopes = [];
$authScheme = Core::kAuthSchemeNone;

function handleRequest(array $context): Response {
	http_response_code(200);
	$now = new DateTime('now', new DateTimeZone('UTC'));
	return Response::NewJson([
		'sql' => $now->format('Y-m-d H:i:sO'),
		'unixEpoch' => intval($now->format('U')),
		'iso8601' => $now->format('c'),
		'rfc2822' => $now->format('r')
	], 200);
}

?>