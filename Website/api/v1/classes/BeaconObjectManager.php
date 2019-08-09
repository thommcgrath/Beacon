<?php

class BeaconObjectManager {
	protected $class_name = null;
	
	public function __construct(string $class_name) {
		$test = new $class_name;
		$this->class_name = $class_name;
	}
	
	public function HandleAPIRequest() {
		$method = BeaconAPI::Method();
		switch ($method) {
		case 'GET':
			$this->HandleGet();
			break;
		case 'POST':
		case 'PUT':
			$this->HandlePost();
			break;
		case 'DELETE':
			$this->HandleDelete();
			break;
		default:
			BeaconAPI::ReplyError('Method not allowed', null, 405);
			break;
		}
	}
	
	private function HandleGet() {
		$object_id = BeaconAPI::ObjectID();
		
		if ($object_id === null) {
			// list all
			if (isset($_GET['mod_id'])) {
				$objects = $this->class_name::Get($_GET['mod_id']);
			} else {
				$objects = $this->class_name::Get();
			}
			BeaconAPI::ReplySuccess($objects);
		} else {
			// specific objects
			$objects = $this->class_name::Get($object_id);
			if (count($objects) === 0) {
				BeaconAPI::ReplyError('Object not found', null, 404);
			}
			if (count($objects) == 1) {
				BeaconAPI::ReplySuccess($objects[0]);
			} else {
				BeaconAPI::ReplySuccess($objects);
			}
		}
	}
	
	private function HandlePost() {
		BeaconAPI::Authorize();
		
		$object_id = BeaconAPI::ObjectID();
		
		if ($object_id !== null) {
			BeaconAPI::ReplyError('Do not specify a class when saving.');
		}
		
		if (BeaconAPI::ContentType() !== 'application/json') {
			BeaconAPI::ReplyError('Send a JSON payload');
		}
		
		$payload = BeaconAPI::JSONPayload();
		if (BeaconCommon::IsAssoc($payload)) {
			// single
			$items = array($payload);
		} else {
			// multiple
			$items = $payload;
		}
		
		// get the mods the user is allowed to work with
		$user_mods = BeaconMod::GetAll(BeaconAPI::UserID());
		$mods_by_uuid = array();
		$mods_by_workshop_id = array();
		foreach ($user_mods as $mod) {
			if ($mod->Confirmed()) {
				$mods_by_uuid[$mod->ModID()] = $mod;
				$mods_by_workshop_id[abs($mod->WorkshopID())] = $mod;
			}
		}
		if (count($mods_by_uuid) == 0) {
			BeaconAPI::ReplyError('User has no confirmed mods');
		}
		
		
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$saved = array();
		foreach ($items as $item) {
			// If object_id is supplied, use it. If there is already a matching object, confirm its
			// mod_id is one that the user owns. If there is not a matching object, the mod_id value
			// is then required.
			if (array_key_exists('object_id', $item)) {
				$object = $this->class_name::GetByObjectID($item['object_id']);
				if (is_null($object)) {
					$object = new $this->class_name($item['object_id']);
				}
			} else {
				$object = new $this->class_name;
			}
			if (is_null($object->ModID())) {
				if (array_key_exists('mod_id', $item)) {
					if (array_key_exists($item['mod_id'], $mods_by_uuid)) {
						$mod = $mods_by_uuid[$item['mod_id']];
					} elseif (array_key_exists($item['mod_id'], $mods_by_workshop_id)) {
						$mod = $mods_by_workshop_id[$item['mod_id']];
					} else {
						$database->Rollback();
						BeaconAPI::ReplyError('Object is part of a mod owned by another user.', $item);
					}
				} else {
					$database->Rollback();
					BeaconAPI::ReplyError('New objects must include a mod_id parameter.', $item);
				}
			} else {
				if (array_key_exists($object->ModID(), $mods_by_uuid) === false) {
					$database->Rollback();
					BeaconAPI::ReplyError('Object is part of a mod owned by another user.', $item);
				}
			}
			
			try {
				$object->ConsumeJSON($item);
				$object->Save();
				$object = $this->class_name::GetByObjectID($object->ObjectID());
				if (is_null($object) === false) {
					$saved[] = $object;
				} else {
					$database->Rollback();
					BeaconAPI::ReplyError('Saved object was not found in database.', $item);
				}
			} catch (Exception $e) {
				$database->Rollback();
				BeaconAPI::ReplyError('Object save error: ' . $e->getMessage(), $item);
			}
		}
		$database->Commit();
		
		BeaconAPI::ReplySuccess($saved);
	}
	
	private function HandleDelete() {
		BeaconAPI::Authorize();
		
		$object_id = BeaconAPI::ObjectID();
		
		if (($object_id === null) && (BeaconAPI::ContentType() === 'text/plain')) {
			$object_id = BeaconAPI::Body();
		}
		if (($object_id === null) || ($object_id === '')) {
			BeaconAPI::ReplyError('No object specified');
		}
		
		if ($this->class_name::DeleteObjects($object_id, BeaconAPI::UserID())) {
			BeaconAPI::ReplySuccess();
		} else {
			BeaconAPI::ReplyError('There was an error deleting the requested objects. This may be a permission error.', $object_id);
		}
	}
}