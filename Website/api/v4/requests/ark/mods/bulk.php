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
	
	$database = BeaconCommon::Database();
	$user_id = BeaconAPI::UserID();
	switch ($context['route_key']) {
	case 'POST /ark/mods':
		$createdMods = [];
		$database->BeginTransaction();
		foreach ($mods as $mod) {
			try {
				$filters = [
					'user_id' => $user_id
				];
				if (isset($mod['workshop_id'])) {
					$filters['workshop_id'] = $mod['workshop_id'];
				} else if (isset($mod['mod_id'])) {
					$filters['mod_id'] = $mod['mod_id'];
				} else {
					throw new Exception('No mod_id or workshop_id provided.');
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
		break;
	case 'DELETE /ark/mods':
		$database->BeginTransaction();
		foreach ($mods as $mod) {
			try {
				$filters = [
					'user_id' => $user_id
				];
				if (isset($mod['workshop_id'])) {
					$filters['workshop_id'] = $mod['workshop_id'];
				} else if (isset($mod['mod_id'])) {
					$filters['mod_id'] = $mod['mod_id'];
				} else {
					throw new Exception('No mod_id or workshop_id provided.');
				}
				
				$results = Ark\Mod::Search($filters);
				foreach ($results['results'] as $result) {
					$result->Delete();
				}
			} catch (Exception $err) {
				$database->Rollback();
				BeaconAPI::ReplyError($err->getMessage(), $mod, 400);
			}
		}
		$database->Commit();
		
		BeaconAPI::ReplySuccess(null);
		break;
	}
}

?>
