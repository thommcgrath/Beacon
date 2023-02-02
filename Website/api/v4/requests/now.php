<?php

function handleRequest(array $context): APIResponse {
	http_response_code(200);
	$now = new DateTime('now', new DateTimeZone('UTC'));
	echo $now->format('Y-m-d H:i:sO');
}

?>