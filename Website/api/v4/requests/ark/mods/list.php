<?php

function handleRequest(array $context): APIResponse {
	$filters = $_GET;
	$mods = [];
	switch ($context['routeKey']) {
	case 'GET /ark/mods':
		break;
	case 'GET /users/{userId}/ark/mods':
		$filters['user_id'] = $context['pathParameters']['userId'];
		break;
	}
	BeaconAPI::ReplySuccess(Ark\Mod::Search($filters));
}

?>