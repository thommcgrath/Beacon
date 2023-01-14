<?php

function handle_request(array $context): void {
	$filters = $_GET;
	$mods = [];
	switch ($context['route_key']) {
	case 'GET /ark/mods':
		break;
	case 'GET /users/{userId}/ark/mods':
		$filters['user_id'] = $context['path_parameters']['userId'];
		break;
	}
	BeaconAPI::ReplySuccess(Ark\Mod::Search($filters));
}

?>