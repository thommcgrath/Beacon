<?php

BeaconAPI::Authorize();
	
function handle_request(array $context): void {
	$workshop_id = $context['path_parameters']['workshop_id'];
	$mods = Ark\Mod::GetByWorkshopID(BeaconAPI::UserID(), $workshop_id);
	if (count($mods) === 0) {
		BeaconAPI::ReplyError('Mod not found', null, 404);
	}
	
	if (isset($_GET['action']) && $_GET['action'] === 'confirm') {
		foreach ($mods as $mod) {
			$mod->AttemptConfirmation();
		}
	}
	
	if (str_contains($workshop_id, ',') === false) {
		BeaconAPI::ReplySuccess($mods[0]);
	} else {
		BeaconAPI::ReplySuccess($mods);
	}
}

?>