<?php

function handle_request(array $context): void {
	$now = new DateTime('now', new DateTimeZone('UTC'));
	echo $now->format('Y-m-d H:i:sO');
}

?>