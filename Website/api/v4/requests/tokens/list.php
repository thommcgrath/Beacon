<?php

use BeaconAPI\v4\{Core, OAuth, Response};

function handleRequest(array $context): Response {
	$userId = $context['pathParameters']['userId'];
	$authenticatedAsUser = ($userId === Core::UserId());
	
	$tokens = OAuth::Lookup($userId);
	$json = [];
	foreach ($tokens as $token) {
		$token->Refresh();
		$json[] = $token->JSON($authenticatedAsUser);
	}
	return Response::NewJson($json, 200);
}

?>
