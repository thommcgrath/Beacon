<?php

function handle_request(array $context): void {
	$filters = $_GET;
	
	if ($context['route_key'] === 'GET /ark/mods/{modId}/engrams') {
		$filters['mod_id'] = $context['path_parameters']['modId'];
	}
	
	BeaconAPI::ReplySuccess(Ark\Engram::Search($filters));
}

?>