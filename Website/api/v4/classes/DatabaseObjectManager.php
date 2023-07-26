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
			$member[$primaryKeyProperty] = BeaconUUID::v4();
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
			echo 'creating';
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
	
	/*public function HandleCreate(array $context): Response {
		if (Core::IsJsonContentType() === false) {
			return Response::NewJsonError('This endpoint expects a JSON body. Make sure the Content-Type header is application/json.', $_SERVER['HTTP_CONTENT_TYPE'], 400);
		}
		
		$body = Core::BodyAsJSON();
		if (BeaconCommon::IsAssoc($body) || count($body) === 0) {
			$members = [$body];
			$multi = false;
		} else {
			$members = $body;
			$multi = true;
		}
		
		$user = Core::User();
		$schema = $this->className::DatabaseSchema();
		$primaryKeyProperty = $schema->PrimaryColumn()->PropertyName();
		$newObjects = [];
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		foreach ($members as $memberData) {
			try {
				if (isset($memberData[$primaryKeyProperty]) === false) {
					$memberData[$primaryKeyProperty] = BeaconUUID::v4();
				}
				$primaryKey = $memberData[$primaryKeyProperty];
				$permissions = DatabaseObjectAuthorizer::GetPermissionsForUser($this->className, $primaryKey, $user);
				if (($permissions & DatabaseObject::kPermissionCreate) !== DatabaseObject::kPermissionCreate) {
					$database->Rollback();
					return Response::NewJsonError('Forbidden', $memberData, 403);
				}
				
				$memberData['userId'] = $user->UserId();
				
				$created = $this->className::Create($memberData);
				if (is_null($created)) {
					$database->Rollback();
					return Response::NewJsonError('Object was not created', $memberData, 500);
				}
				$newObjects[] = $created;
			} catch (Exception $err) {
				$database->Rollback();
				return Response::NewJsonError($err->getMessage(), $err, 500);
			}
		}
		if (count($newObjects) !== count($members)) {
			$database->Rollback();
			return Response::NewJsonError('Incorrect number of objects created', ['sent' => $members, 'created' => $newObjects], 500);
		}
		$database->Commit();
		
		if ($multi) {
			return Response::NewJson($newObjects, 201);
		} else {
			return Response::NewJson($newObjects[0], 201);
		}
	}*/
	
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
	
	public function HandleDelete(array $context): Response {
		try {
			$uuid = $context['pathParameters'][$this->varName];
			$obj = $this->className::Fetch($uuid);
			if (is_null($obj)) {
				return Response::NewJsonError('Not found', null, 404);
			}
			
			$user = Core::User();
			if ($obj->CheckPermission($user, DatabaseObject::kPermissionDelete) === false) {
				return Response::NewJsonError('Forbidden', null, 403);
			}
			
			$obj->Delete();
			return Response::NewNoContent();
		} catch (Exception $err) {
			return Response::NewJsonError($err->getMessage(), null, 500);
		}
	}
	
	public function HandleBulkDelete(array $context): Response {
		
	}
}

?>
