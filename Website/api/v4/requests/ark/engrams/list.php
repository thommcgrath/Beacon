<?php

function handleRequest(array $context): APIResponse {
	$filters = $_GET;
	
	if ($context['routeKey'] === 'GET /ark/mods/{modId}/engrams') {
		$filters['mod_id'] = $context['pathParameters']['modId'];
	}
	
	BeaconAPI::ReplySuccess(Ark\Engram::Search($filters));
}

?>