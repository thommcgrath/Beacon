<?php

use BeaconAPI\v4\{Response, Core, License};

function handleRequest(array $context): Response {
	$licenseId = $context['pathParameters']['licenseId'];
	$license = License::Fetch($licenseId);
	if ($license->UserId() !== Core::UserId()) {
		return Response::NewJsonError('License not found', null, 404);
	}
	return Response::NewJson($license, 200);
}

?>
