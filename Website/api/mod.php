<?php

require($_SERVER['DOCUMENT_ROOT'] . '/php/engine.php');
BeaconAPI::Authorize();

$method = strtoupper($_SERVER['REQUEST_METHOD']);
$mod_id = BeaconAPI::ObjectID();
$database = ConnectionManager::BeaconDatabase();
$user_id = BeaconAPI::UserID();

switch ($method) {
case 'PUT':
case 'POST':
	if ($mod_id === null) {
		BeaconAPI::ReplyError('No mod id.');
	}
	
	$results = $database->Query('SELECT user_id FROM mods WHERE workshop_id = $1 AND user_id = $2;', $mod_id, $user_id);
	if ($results->RecordCount() == 1) {
		BeaconAPI::ReplyError('Mod is already registered.');
	}
	
	$item = ZirconWorkshopItem::Load($mod_id);
	if ($item === null) {
		BeaconAPI::ReplyError('Mod was not found on Ark Workshop.', array('id' => $mod_id, 'url' => ZirconWorkshopItem::URLForModID($mod_id)));
	}
	
	$database->BeginTransaction();
	try {
		$results = $database->Query('INSERT INTO mods (workshop_id, name, user_id) VALUES ($1, $2, $3) RETURNING confirmation_code;', $mod_id, $item->Name(), $user_id);
		$database->Commit();
	} catch (\ZirconQueryException $e) {
		$database->Rollback();
		BeaconAPI::ReplyError($e->getMesage());
	}
	
	BeaconAPI::ReplySuccess();
	
	break;
case 'DELETE':
	if ($mod_id === null) {
		BeaconAPI::ReplyError('No mod id.');
	}
	
	$results = $database->Query('SELECT user_id FROM mods WHERE workshop_id = $1;', $mod_id);
	if ($results->RecordCount() == 0) {
		BeaconAPI::ReplyError('Mod is not registered.');
	}
	
	if ($results->Field('user_id') !== $user_id) {
		BeaconAPI::ReplyError('Mod is registered to a different user.');
	}
	
	$database->BeginTransaction();
	$database->Query('DELETE FROM mods WHERE workshop_id = $1;', $mod_id);
	$database->Commit();
	
	BeaconAPI::ReplySuccess();
	
	break;
case 'GET':
	if ($mod_id === null) {
		$results = $database->Query('SELECT workshop_id, name, confirmed, confirmation_code FROM mods WHERE user_id = $1 ORDER BY name;', $user_id);
		$response = array();
		while (!$results->EOF()) {
			$response[] = array(
				'mod_id' => $results->Field('workshop_id'),
				'name' => $results->Field('name'),
				'workshop_url' => ZirconWorkshopItem::URLForModID($results->Field('workshop_id')),
				'confirmed' => $results->Field('confirmed'),
				'confirmation_code' => $results->Field('confirmation_code'),
				'resource_url' => ZirconCommon::AbsoluteURL('/beacon/api/mod.php/' . $results->Field('workshop_id'))
			);
			$results->MoveNext();
		}
	} else {
		if (isset($_GET['action']) && strtolower($_GET['action']) === 'confirm') {
			// wants to confirm the mod
			$results = $database->Query('SELECT confirmation_code FROM mods WHERE user_id = $1 AND workshop_id = $2;', $user_id, $mod_id);
			if ($results->RecordCount() == 0) {
				BeaconAPI::ReplyError('Mod not found', null, 404);
			}
			$confirmation_code = $results->Field('confirmation_code');
			$workshop_item = ZirconWorkshopItem::Load($mod_id);
			if ($workshop_item === null) {
				BeaconAPI::ReplyError('Unable to load mod from Steam Workshop.');
			}
			if ($workshop_item->ContainsString($confirmation_code)) {
				$database->BeginTransaction();
				$database->Query('UPDATE mods SET confirmed = TRUE WHERE user_id = $1 AND workshop_id = $2;', $user_id, $mod_id);
				$database->Commit();
				BeaconAPI::ReplySuccess();
			} else {
				BeaconAPI::ReplyError('Confirmation code was not found on mod page.');
			}
			return;
		}
		
		$results = $database->Query('SELECT mod_id, workshop_id, name, confirmed, confirmation_code FROM mods WHERE user_id = $1 AND workshop_id = $2 ORDER BY name;', $user_id, $mod_id);
		$response = array(
			'mod_id' => $results->Field('workshop_id'),
			'name' => $results->Field('name'),
			'workshop_url' => ZirconWorkshopItem::URLForModID($results->Field('workshop_id')),
			'confirmed' => $results->Field('confirmed'),
			'confirmation_code' => $results->Field('confirmation_code'),
			'resource_url' => ZirconCommon::AbsoluteURL('/beacon/api/mod.php/' . $results->Field('workshop_id')),
			'confirm_url' => ZirconCommon::AbsoluteURL('/beacon/api/mod.php/' . $results->Field('workshop_id') . '?action=confirm'),
			'engrams' => array()
		);
		
		$results = $database->Query('SELECT classstring, label, availability, can_blueprint FROM engrams WHERE mod_id = $1;', $results->Field('mod_id'));
		while (!$results->EOF()) {
			$class = $results->Field('classstring');
			$label = $results->Field('label');
			$availability = $results->Field('availability');
			$can_blueprint = $results->Field('can_blueprint');
			
			$environments = array();
			if (($availability & 1) === 1) {
				$environments[] = 'Island';
			}
			if (($availability & 2) === 2) {
				$environments[] = 'Scorched';
			}
			
			$class_parts = explode('_', $class);
			array_shift($class_parts);
			array_pop($class_parts);
			
			$response['engrams'][] = array(
				'class' => $class,
				'label' => $label,
				'environments' => $environments,
				'can_blueprint' => $can_blueprint,
				'spawn' => 'cheat gfi ' . strtolower(implode('_', $class_parts)) . ' 1 0 false',
				'resource_url' => ZirconCommon::AbsoluteURL('/beacon/api/engram.php/' . $class)
			);
			
			$results->MoveNext();
		}
	}
	BeaconAPI::ReplySuccess($response);
	
	break;
default:
	BeaconAPI::ReplyError('Method not allowed.', $method, 405);
	break;
}

?>