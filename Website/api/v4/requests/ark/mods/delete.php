<?php

BeaconAPI::Authorize();
	
function handleRequest(array $context): APIResponse {
	if (isset($context['pathParameters']['workshop_id'])) {
		$workshop_id = $context['pathParameters']['workshop_id'];
	} else if (BeaconAPI::ContentType() === 'text/plain') {
		$workshop_id = BeaconAPI::Body();
	} else {
		BeaconAPI::ReplyError('No mod specified');
	}
	
	$mods = Ark\Mod::GetByWorkshopID(BeaconAPI::UserID(), $workshop_id);
	if (count($mods) == 0) {
		BeaconAPI::ReplyError('No mods found.', null, 404);
	}
	
	$database = \BeaconCommon::Database();
	$database->BeginTransaction();
	foreach ($mods as $mod) {
		$mod->Delete();
	}
	$database->Commit();
	
	BeaconAPI::ReplySuccess('', 204);
}

?>