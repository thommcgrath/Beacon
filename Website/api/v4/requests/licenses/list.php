<?php

use BeaconAPI\v4\{Response, Core, License};

function handleRequest(array $context): Response {
	$userId = $context['pathParameters']['userId'];
	if ($userId !== Core::UserId()) {
		$results = License::Search(['userId' => '00000000-0000-0000-0000-000000000000']);
	} else {
		$results = License::Search(['userId' => Core::UserId()]);
	}
	return Response::NewJson($results, 200);
}

?>
