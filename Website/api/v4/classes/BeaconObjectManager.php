<?php

class BeaconObjectManager {
	const FeatureList = 1;
	const FeatureGet = 2;
	const FeatureEdit = 4;
	const FeatureDelete = 8;
	
	protected $class_name = null;
	protected $features = 15;
	protected $group = null;
	protected $name = null;
	
	public function __construct(string $class_name, string $group, string $name, int $features = 15) {
		if (class_exists($class_name) === false) {
			throw new \Exception('Class `' . $class_name . '` does not exist.');
		}
		
		$this->class_name = $class_name;
		$this->group = $group;
		$this->name = $name;
		$this->features = $features;
	}
	
	public static function RegisterRoutes(string $class_name, string $group, string $name, int $features = 15): void {
		$manager = new static($class_name, $group, $name, $features);
		$manager->SetupRoutes();
	}
	
	public function SetupRoutes(): void {
		$id_methods = [];
		$bulk_methods = [];
		
		if (($this->features & self::FeatureGet) === self::FeatureGet) {
			$id_methods['GET'] = [$this, 'HandleGetRequest'];
		}
		if (($this->features & self::FeatureList) === self::FeatureList) {
			$bulk_methods['GET'] = [$this, 'HandleListRequest'];
		}
		if (($this->features & self::FeatureEdit) === self::FeatureEdit) {
			$bulk_methods['POST'] = [$this, 'HandleEditRequest'];
		}
		if (($this->features & self::FeatureDelete) === self::FeatureDelete) {
			$bulk_methods['DELETE'] = [$this, 'HandleDeleteRequest'];
			$id_methods['DELETE'] = [$this, 'HandleDeleteRequest'];
		}
		
		if (count($id_methods) > 0) {
			BeaconAPI::RegisterRoutes([
				'/' . $this->group . '/' . $this->name . '/{' . $this->name . '_id}' => $id_methods
			]);
		}
		if (count($bulk_methods) > 0) {
			BeaconAPI::RegisterRoutes([
				'/' . $this->group . '/' . $this->name => $bulk_methods
			]);
		}
	}
	
	public function HandleListRequest(array $context): void {
		$mod_id = isset($_GET['mod_id']) ? $_GET['mod_id'] : null;
		$objects = $this->class_name::Get($mod_id, \BeaconCommon::MinVersion());
		BeaconAPI::ReplySuccess($objects);
	}
	
	public function HandleGetRequest(array $context): void {
		$id = $context['path_parameters'][$this->name . '_id'];
		$objects = $this->class_name::Get($id, \BeaconCommon::MinVersion());
		if (count($objects) === 0) {
			BeaconAPI::ReplyError('Object not found', null, 404);
		}
		if (count($objects) == 1) {
			BeaconAPI::ReplySuccess($objects[0]);
		} else {
			BeaconAPI::ReplySuccess($objects);
		}
	}
	
	public function HandleEditRequest(array $context): void {
		BeaconAPI::Authorize();
		
		if (BeaconAPI::ContentType() !== 'application/json') {
			BeaconAPI::ReplyError('Send a JSON payload');
		}
		
		$payload = BeaconAPI::JSONPayload();
		if (\BeaconCommon::IsAssoc($payload)) {
			// single
			$items = [$payload];
		} else {
			// multiple
			$items = $payload;
		}
		
		// get the mods the user is allowed to work with
		$user_mods = Ark\Mod::GetAll(BeaconAPI::UserID());
		$mods_by_uuid = [];
		$mods_by_workshop_id = [];
		foreach ($user_mods as $mod) {
			if ($mod->Confirmed()) {
				$mods_by_uuid[$mod->ModID()] = $mod;
				$mods_by_workshop_id[abs($mod->WorkshopID())] = $mod;
			}
		}
		if (count($mods_by_uuid) == 0) {
			BeaconAPI::ReplyError('User has no confirmed mods');
		}
		
		$database = \BeaconCommon::Database();
		$database->BeginTransaction();
		$saved = [];
		foreach ($items as $item) {
			// If object_id is supplied, use it. If there is already a matching object, confirm its
			// mod_id is one that the user owns. If there is not a matching object, the mod_id value
			// is then required.
			if (array_key_exists('object_id', $item)) {
				$object = $this->class_name::GetByObjectID($item['object_id'], \BeaconCommon::MinVersion());
				if (is_null($object)) {
					$object = new $this->class_name($item['object_id']);
				}
			} elseif (array_key_exists('id', $item)) {
				$object = $this->class_name::GetByObjectID($item['id'], \BeaconCommon::MinVersion());
				if (is_null($object)) {
					$object = new $this->class_name($item['id']);
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
					$item['mod'] = [
						'id' => $mod->ModID()
					];
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
			if (array_key_exists('min_version', $item) === false || is_int($item['min_version']) === false) {
				// Find the min version of the mod
				$item['min_version'] = max($object->MinVersion(), $mod->MinVersion());
			} else {
				$item['min_version'] = max($item['min_version'], $object->MinVersion(), $mod->MinVersion());
			}
			
			try {
				$object->ConsumeJSON($item);
				$object->Save();
				$object = $this->class_name::GetByObjectID($object->ObjectID(), \BeaconCommon::MinVersion());
				if (is_null($object) === false) {
					$saved[] = $object;
				} else {
					$database->Rollback();
					BeaconAPI::ReplyError('Saved object was not found in database.', $item);
				}
			} catch (\Exception $e) {
				$database->Rollback();
				BeaconAPI::ReplyError('Object save error: ' . $e->getMessage(), $item);
			}
		}
		$database->Commit();
		
		BeaconAPI::ReplySuccess($saved);
	}
	
	public function HandleDeleteRequest(array $context): void {
		BeaconAPI::Authorize();
		
		if (isset($context['path_parameters'][$this->name . '_id'])) {
			$id = $context['path_parameters'][$this->name . '_id'];
		} elseif (BeaconAPI::ContentType() === 'text/plain') {
			$id = BeaconAPI::Body();
		} else {
			BeaconAPI::ReplyError('No object specified');
		}
		
		if ($this->class_name::DeleteObjects($id, BeaconAPI::UserID())) {
			BeaconAPI::ReplySuccess('', 204);
		} else {
			BeaconAPI::ReplyError('There was an error deleting the requested objects. This may be a permission error.', $id);
		}
	}
}

?>
