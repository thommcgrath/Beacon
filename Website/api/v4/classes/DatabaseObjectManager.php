<?php

namespace BeaconAPI\v4;
use BeaconCommon, Exception;

class DatabaseObjectManager {
	const kFeatureCreate = 1;
	const kFeatureRead = 2;
	const kFeatureUpdate = 4;
	const kFeatureDelete = 8;
	const kFeatureSingle = 16;
	const kFeatureBulk = 32;
	const kFeatureReadOnly = self::kFeatureRead | self::kFeatureSingle | self::kFeatureBulk;
	const kFeatureAll = self::kFeatureCreate | self::kFeatureRead | self::kFeatureUpdate | self::kFeatureDelete | self::kFeatureSingle | self::kFeatureBulk;
	
	protected $className = null;
	protected $features = self::kFeatureAll;
	protected $path = null;
	protected $varName = null;
	
	public function __construct(string $className, string $path, string $varName, int $features = self::kFeatureAll) {
		if (class_exists($className) === false) {
			throw new Exception('Class `' . $className . '` does not exist.');
		}
		
		if (is_a($className, 'BeaconAPI\v4\DatabaseObject', true) === false) {
			throw new Exception('Class `' . $className . '` is not an instance of DatabaseObject.');
		}
		
		$this->className = $className;
		$this->path = $path;
		$this->varName = $varName;
		$this->features = ($features & self::kFeatureAll);
	}
	
	public static function RegisterRoutes(string $className, string $path, string $varName, int $features = self::kFeatureAll) {
		$manager = new static($className, $path, $varName, $features);
		$manager->SetupRoutes();
	}
	
	public function SetupRoutes(): void {
		$create = ($this->features & self::kFeatureCreate) === self::kFeatureCreate;
		$read = ($this->features & self::kFeatureRead) === self::kFeatureRead;
		$update = ($this->features & self::kFeatureUpdate) === self::kFeatureUpdate;
		$delete = ($this->features & self::kFeatureDelete) === self::kFeatureDelete;
		$bulk = ($this->features & self::kFeatureBulk) === self::kFeatureBulk;
		$single = ($this->features & self::kFeatureSingle) === self::kFeatureSingle;
				
		if ($bulk) {
			$methods = [];
			
			if ($create) {
				$methods['POST'] = [$this, 'HandleCreate'];
			}
			if ($read) {
				$methods['GET'] = [$this, 'HandleList'];
			}
			if ($update) {
				$methods['PATCH'] = [$this, 'HandleUpdate'];
			}
			if ($delete) {
				$methods['DELETE'] = [$this, 'HandleDelete'];
			}
			
			Core::RegisterRoutes(["/{$this->path}" => $methods]);
		}
		if ($single) {
			$methods = [];
			
			if ($create || $update) {
				$methods['PUT'] = [$this, 'HandleReplace'];
			}
			if ($read) {
				$methods['GET'] = [$this, 'HandleFetch'];
			}
			if ($delete) {
				$methods['DELETE'] = [$this, 'HandleDelete'];
			}
			
			Core::RegisterRoutes(["/{$this->path}/{{$this->varName}}" => $methods]);
		}
	}
	
	public function HandleCreate(array $context): APIResponse {
		Core::Authorize();
		
		if (Core::IsJSONContentType() === false) {
			return APIResponse::NewJSONError('This endpoint expects a JSON body. Make sure the Content-Type header is application/json.', $_SERVER['HTTP_CONTENT_TYPE'], 400);
		}
		
		$body = Core::BodyAsJSON();
		if (BeaconCommon::IsAssoc($body)) {
			$members = [$body];
			$multi = false;
		} else {
			$members = $body;
			$multi = true;
		}
		
		$user = Core::User();
		if ($this->className::CheckClassPermission($user, $members, DatabaseObject::kPermissionCreate) === false) {
			return APIResponse::NewJSONError('Forbidden', $members, 403);
		}
			
		$schema = $this->className::DatabaseSchema();
		$primaryKeyProperty = $schema->PrimaryColumn()->PropertyName();
		$newObjects = [];
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		foreach ($members as $memberData) {
			try {
				if (isset($memberData[$primaryKeyProperty]) === false) {
					$memberData[$primaryKeyProperty] = BeaconCommon::GenerateUUID();
				}
				
				$created = $this->className::Create($memberData);
				if (is_null($created)) {
					$database->Rollback();
					return APIResponse::NewJSONError('Object was not created', $memberData, 500);
				}
				$newObjects[] = $created;
			} catch (Exception $err) {
				$database->Rollback();
				return APIResponse::NewJSONError($err->getMessage(), $err, 500);
			}
		}
		if (count($newObjects) !== count($members)) {
			$database->Rollback();
			return APIResponse::NewJSONError('Incorrect number of objects created', ['sent' => $members, 'created' => $newObjects], 500);
		}
		$database->Commit();
		
		if ($multi) {
			return APIResponse::NewJSON($newObjects, 201);
		} else {
			return APIResponse::NewJSON($newObjects[0], 201);
		}
	}
	
	public function HandleList(array $context): APIResponse {
		return APIResponse::NewJSON($this->className::Search($_GET), 200);
	}
	
	public function HandleUpdate(array $context): APIResponse {
		
	}
	
	public function HandleReplace(array $context): APIResponse {
		
	}
	
	public function HandleFetch(array $context): APIResponse {
		$uuid = $context['path_parameters'][$this->varName];
		try {
			$obj = $this->className::Fetch($uuid);
			if ($obj) {
				return APIResponse::NewJSON($obj, 200);
			} else {
				return APIResponse::NewJSONError('Not found', null, 404);
			}
		} catch (Exception $err) {
			return APIResponse::NewJSONError($err->getMessage(), null, 500);
		}
	}
	
	public function HandleDelete(array $contet): APIResponse {
		
	}
}

?>
