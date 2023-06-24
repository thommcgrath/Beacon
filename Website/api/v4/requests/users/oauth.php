<?php

use BeaconAPI\v4\{Core, OAuth, Response};

function handleRequest(array $context): Response {
	$userId = $context['pathParameters']['userId'];
	$authenticatedAsUser = ($userId === Core::UserId());
	$provider = strtolower($context['pathParameters']['provider']);
	switch ($provider) {
	case 'nitrado':
		$provider = OAuth::ProviderNitrado;
		break;
	}
	
	$oauth = OAuth::Lookup($userId, $provider);
	if (is_null($oauth) || ($authenticatedAsUser === true && $oauth->Test(true) === false)) {
		return Response::NewJsonError('Token not found.', null, 404);
	}
	
	return Response::NewJson($oauth->JSON($authenticatedAsUser), 200);
}

?>
