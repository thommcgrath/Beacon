<?php

function handleRequest(array $context): Response {
	$mod_id = $context['pathParameters']['modId'];
	
	$mod = Ark\Mod::Fetch($mod_id);
	if (is_null($mod) === false) {
		BeaconAPI::ReplySuccess($mod);
	}
	
	$mods = Ark\Mod::Search(['workshop_id' => $mod_id]);
	if ($mods['totalResults'] === 1) {
		BeaconAPI::ReplySuccess($mods['results'][0]);
	}
	
	BeaconAPI::ReplyError('Mod not found', null, 404);
}

?>