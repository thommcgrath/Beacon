<?php

BeaconAPI::Authorize();
	
// This endpoint supports bulk creation and edting
	
function handle_request(array $context): void {
	$properties = BeaconAPI::JSONPayload();
	
	if (BeaconCommon::IsAssoc($properties)) {
		$mods = [$properties];
		$multiResponse = false;
	} else {
		$mods = $properties;
		$multiResponse = true;
	}
	
	$createdMods = [];
	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	foreach ($mods as $mod) {
		try {
			$user_id = BeaconAPI::UserID();
			$filters = [
				'user_id' => $user_id
			];
			if (isset($mod['workshop_id'])) {
				$filters['workshop_id'] = $mod['workshop_id'];
			} else if (isset($mod['mod_id'])) {
				$filters['mod_id'] = $mod['mod_id'];
			}
			
			$results = Ark\Mod::Search($filters);
			switch ($results['totalResults']) {
			case 1:
				$results['results'][0]->Edit($mod);
				$createdMods[] = $results['results'][0];
				break;
			case 0:
				$mod['user_id'] = BeaconAPI::UserID();
				$mod['min_version'] = max(10600000, $mod['min_version'] ?? 0);
				$createdMods[] = Ark\Mod::Create($mod);
				break;
			default:
				echo json_encode($results, JSON_PRETTY_PRINT);
				throw new Exception('Too many results returned.');
			}
		} catch (Exception $err) {
			$database->Rollback();
			BeaconAPI::ReplyError($err->getMessage(), $mod, 400);
		}
	}
	$database->Commit();
	
	if ($multiResponse) {
		BeaconAPI::ReplySuccess($createdMods);
	} else {
		BeaconAPI::ReplySuccess($createdMods[0]);
	}
}

?>
