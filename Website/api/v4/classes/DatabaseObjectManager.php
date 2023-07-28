<?php

namespace BeaconAPI\v4;
use BeaconCommon, BeaconUUID, Exception;

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
			
			if ($create || $update) {
				$methods['POST'] = [$this, 'HandleBulkUpdate'];
			}
			if ($read) {
				$methods['GET'] = [$this, 'HandleList'];
			}
			if ($update) {
				$methods['PATCH'] = [$this, 'HandleBulkUpdate'];
			}
			if ($delete) {
				$methods['DELETE'] = [$this, 'HandleBulkDelete'];
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
			if ($update) {
				$methods['PATCH'] = [$this, 'HandleUpdate'];
			}
			if ($delete) {
				$methods['DELETE'] = [$this, 'HandleDelete'];
			}
			
			Core::RegisterRoutes(["/{$this->path}/{{$this->varName}}" => $methods]);
		}
	}
	
	public function HandleList(array $context): Response {
		return Response::NewJson($this->className::Search($_GET), 200);
	}
	
	public function HandleFetch(array $context): Response {
		$uuid = $context['pathParameters'][$this->varName];
		try {
			$obj = $this->className::Fetch($uuid);
			if ($obj) {
				return Response::NewJson($obj, 200);
			} else {
				return Response::NewJsonError('Not found', null, 404);
			}
		} catch (Exception $err) {
			return Response::NewJsonError($err->getMessage(), null, 500);
		}
	}
	
	protected function WriteObject(User $user, string $primaryKeyProperty, array $member, bool $replace): array {
		if (isset($member[$primaryKeyProperty]) === false) {
			$member[$primaryKeyProperty] = $this->className::GenerateObjectId($member);
		}
		$primaryKey = $member[$primaryKeyProperty];
		
		$obj = $this->className::Fetch($primaryKey);
		$permissions = DatabaseObjectAuthorizer::GetPermissionsForUser(object: $obj, className: $this->className, objectId: $primaryKey, user: $user, options: DatabaseObjectAuthorizer::kOptionNoFetch, newObjectProperties: $member);
		$requiredPermissions = is_null($obj) ? DatabaseObject::kPermissionCreate : DatabaseObject::kPermissionUpdate;
		if (($permissions & $requiredPermissions) !== $requiredPermissions) {
			return [
				'status' => 403,
				'success' => false,
				'keyProperty' => $primaryKeyProperty,
				$primaryKeyProperty => $primaryKey,
				'object' => $member,
				'reason' => 'Forbidden'
			];
		}
		
		if (is_null($obj)) {
			$member['userId'] = $user->UserId(); // In case it is needed
			$obj = $this->className::Create($member);
			if (is_null($obj)) {
				return [
					'status' => 500,
					'success' => false,
					'keyProperty' => $primaryKeyProperty,
					$primaryKeyProperty => $primaryKey,
					'object' => $member,
					'reason' => 'Object was not created'
				];
			}
			return [
				'status' => 201,
				'success' => true,
				'keyProperty' => $primaryKeyProperty,
				$primaryKeyProperty => $primaryKey,
				'object' => $obj
			];
		} else {
			$obj->Edit($member, $replace);
			return [
				'status' => 200,
				'success' => true,
				'keyProperty' => $primaryKeyProperty,
				$primaryKeyProperty => $primaryKey,
				'object' => $obj
			];
		}
	}
	
	protected function HandleWrite(array $context, bool $replace): Response {
		if (Core::IsJsonContentType() === false) {
			return Response::NewJsonError('This endpoint expects a JSON body. Make sure the Content-Type header is application/json.', $_SERVER['HTTP_CONTENT_TYPE'], 400);
		}
		
		try {
			$schema = $this->className::DatabaseSchema();
			$primaryKeyProperty = $schema->PrimaryColumn()->PropertyName();
			$primaryKey = $context['pathParameters'][$this->varName];
			$user = Core::User();
			
			$member = Core::BodyAsJSON();
			$member[$primaryKeyProperty] = $primaryKey;
			
			$status = $this->WriteObject($user, $primaryKeyProperty, $member, $replace);
			if ($status['success'] === true) {
				return Response::NewJson($status['object'], $status['status']);
			} else {
				return Response::NewJsonError($status['reason'], $status['object'], $status['status']);
			}
		} catch (Exception $err) {
			return Response::NewJsonError($err->getMessage(), null, 500);
		}
	}
	
	protected function HandleBulkWrite(array $context, bool $replace): Response {
		if (Core::IsJsonContentType() === false) {
			return Response::NewJsonError('This endpoint expects a JSON body. Make sure the Content-Type header is application/json.', $_SERVER['HTTP_CONTENT_TYPE'], 400);
		}
		
		$members = Core::BodyAsJSON();
		if (count($members) === 0) {
			return Response::NewJsonError('No objects to save', null, 400);
		}
		if (BeaconCommon::IsAssoc($members)) {
			$members = [$members];
		}
		
		$user = Core::User();
		$schema = $this->className::DatabaseSchema();
		$primaryKeyProperty = $schema->PrimaryColumn()->PropertyName();
		$newObjects = [];
		$updatedObjects = [];
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		foreach ($members as $member) {
			try {
				$response = $this->WriteObject($user, $primaryKeyProperty, $member, $replace);
				if ($response['success'] === false) {
					$database->Rollback();
					return Response::NewJsonError($response['reason'], $response['object'], $response['status']);
				}
				if ($response['status'] === 201) {
					$newObjects[] = $response['object'];
				} else {
					$updatedObjects[] = $response['object'];
				}
			} catch (Exception $err) {
				$database->Rollback();
				return Response::NewJsonError($err->getMessage(), $member, 500);
			}
		}
		$database->Commit();
		
		return Response::NewJson([
			'created' => $newObjects,
			'updated' => $updatedObjects
		], 200);
	}
	
	public function HandleUpdate(array $context): Response {
		return $this->HandleWrite($context, false);
	}
	
	public function HandleBulkUpdate(array $context): Response {
		return $this->HandleBulkWrite($context, false);
	}
	
	public function HandleReplace(array $context): Response {
		return $this->HandleWrite($context, true);
	}
	
	public function HandleBulkReplace(array $context): Response {
		return $this->HandleBulkWrite($context, true);
	}
	
	protected function DeleteObject(User $user, string $primaryKeyProperty, array $member): array {
		if (array_key_exists($primaryKeyProperty, $member) === false) {
			return [
				'status' => 400,
				'success' => false,
				'keyProperty' => $primaryKeyProperty,
				'object' => $member,
				'reason' => 'No key property present'
			];
		}
		$primaryKey = $member[$primaryKeyProperty];
		
		$obj = $this->className::Fetch($primaryKey);
		if (is_null($obj)) {
			return [
				'status' => 404,
				'success' => false,
				'keyProperty' => $primaryKeyProperty,
				$primaryKeyProperty => $primaryKey,
				'object' => $member,
				'reason' => 'Object not found'
			];
		}
		
		$permissions = DatabaseObjectAuthorizer::GetPermissionsForUser(object: $obj, className: $this->className, objectId: $primaryKey, user: $user, options: DatabaseObjectAuthorizer::kOptionNoFetch);
		if (($permissions & DatabaseObject::kPermissionDelete) !== DatabaseObject::kPermissionDelete) {
			return [
				'status' => 403,
				'success' => false,
				'keyProperty' => $primaryKeyProperty,
				$primaryKeyProperty => $primaryKey,
				'object' => $member,
				'reason' => 'Forbidden'
			];
		}
		
		$obj->Delete();
		return [
			'status' => 200,
			'success' => true,
			'keyProperty' => $primaryKeyProperty,
			$primaryKeyProperty => $primaryKey,
			'object' => $obj
		];
	}
	
	public function HandleDelete(array $context): Response {
		try {
			$uuid = $context['pathParameters'][$this->varName];
			$user = Core::User();
			$schema = $this->className::DatabaseSchema();
			$primaryKeyProperty = $schema->PrimaryColumn()->PropertyName();
			
			$status = $this->DeleteObject($user, $primaryKeyProperty, [$primaryKeyProperty => $uuid]);
			if ($status['success'] === true) {
				return Response::NewNoContent();
			} else {
				return Response::NewJsonError($status['reason'], $status['object'], $status['status']);
			}
		} catch (Exception $err) {
			return Response::NewJsonError($err->getMessage(), null, 500);
		}
	}
	
	public function HandleBulkDelete(array $context): Response {
		if (Core::IsJsonContentType() === false) {
			return Response::NewJsonError('This endpoint expects a JSON body. Make sure the Content-Type header is application/json.', $_SERVER['HTTP_CONTENT_TYPE'], 400);
		}
		
		$members = Core::BodyAsJSON();
		if (count($members) === 0) {
			return Response::NewJsonError('No objects to delete', null, 400);
		}
		if (BeaconCommon::IsAssoc($members)) {
			$members = [$members];
		}
		
		$user = Core::User();
		$schema = $this->className::DatabaseSchema();
		$primaryKeyProperty = $schema->PrimaryColumn()->PropertyName();
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		foreach ($members as $member) {
			try {
				$status = $this->DeleteObject($user, $primaryKeyProperty, $member);
				if ($status['success'] === false) {
					$database->Rollback();
					return Response::NewJsonError($status['reason'], $status['object'], $status['status']);
				}
			} catch (Exception $err) {
				$database->Rollback();
				return Response::NewJsonError($err->getMessage(), $member, 500);
			}
		}
		$database->Commit();
		
		return Response::NewNoContent();
	}
}

?>
