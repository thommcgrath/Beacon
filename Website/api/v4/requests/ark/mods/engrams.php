<?php

function handle_request(array $context): void {
	$mod_id = $context['path_parameters']['modId'];
	
	$filters = $_GET;
	if (BeaconCommon::IsUUID($mod_id)) {
		$filters['mod_id'] = $mod_id;
		unset($filters['mod_workshop_id']);
	} else {
		$filters['mod_workshop_id'] = $mod_id;
		unset($filters['mod_id']);
	}
	
	$engrams = Ark\Engram::Search($filters);
	BeaconAPI::ReplySuccess($engrams);
}

?>