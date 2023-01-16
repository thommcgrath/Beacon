<?php

namespace BeaconAPI\v4;
use Exception;

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
