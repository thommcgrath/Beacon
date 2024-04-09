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

	protected string $className;
	protected int $features = self::kFeatureAll;
	protected string $path;
	protected string $varName;
	protected ?string $subclassProperty = null;
	protected array $subclassMap = [];

	public function __construct(string $className, string $path, string $varName, int $features = self::kFeatureAll, ?string $subclassProperty = null, array $subclassMap = []) {
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

		if (is_null($subclassProperty) === false && count($subclassMap) === 0) {
			throw new Exception('Subclass map must include members if using a subclass property.');
		}

		$this->subclassProperty = $subclassProperty;
		$this->subclassMap = $subclassMap;
	}

	public static function RegisterRoutes(string $className, string $path, string $varName, int $features = self::kFeatureAll, ?string $subclassProperty = null, array $subclassMap = []) {
		$manager = new static($className, $path, $varName, $features, $subclassProperty, $subclassMap);
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

	protected function GetClassName(array $member): string {
		if (is_null($this->subclassProperty) === false && array_key_exists($this->subclassProperty, $member)) {
			$subclassValue = $member[$this->subclassProperty];
			if (array_key_exists($subclassValue, $this->subclassMap)) {
				return $this->subclassMap[$subclassValue];
			}
		}
		return $this->className;
	}

	public function HandleList(array $context): Response {
		$results = $this->className::Search($_GET);
		if (is_null($this->subclassProperty)) {
			return Response::NewJson($results, 200);
		}

		$objects = $results['results'];
		$objectsBound = count($objects) - 1;
		$indexes = [];
		$classObjectIds = [];
		for ($idx = 0; $idx <= $objectsBound; $idx++) {
			$subclassValue = $objects[$idx]->GetPropertyValue($this->subclassProperty);
			if (array_key_exists($subclassValue, $this->subclassMap) === false) {
				$continue;
			}

			$className = $this->subclassMap[$subclassValue];
			$primaryKey = $objects[$idx]->PrimaryKey();
			$indexes[$primaryKey] = $idx;
			if (array_key_exists($className, $classObjectIds) === false) {
				$classObjectIds[$className] = [];
			}
			$classObjectIds[$className][] = $primaryKey;
		}

		foreach ($classObjectIds as $className => $objectIds) {
			$schema = $className::DatabaseSchema();
			$primaryKeyProperty = $schema->PrimaryColumn()->PropertyName();

			$filters = $_GET;
			$filters[$primaryKeyProperty] = $objectIds;
			$instances = $className::Search($filters, true);

			foreach ($instances as $instance) {
				$primaryKey = $instance->PrimaryKey();
				$idx = $indexes[$primaryKey];
				$objects[$idx] = $instance;
			}
		}

		$results['results'] = $objects;
		return Response::NewJson($results, 200);
	}

	protected function FetchObject(string $objectId): ?DatabaseObject {
		try {
			$obj = $this->className::Fetch($objectId);
			if (!$obj) {
				return null;
			}

			if (is_null($this->subclassProperty)) {
				return $obj;
			}

			$subclassValue = $obj->GetPropertyValue($this->subclassProperty);
			if (array_key_exists($subclassValue, $this->subclassMap)) {
				return $this->subclassMap[$subclassValue]::Fetch($objectId);
			} else {
				return $obj;
			}
		} catch (Exception $err) {
			return null;
		}
	}

	public function HandleFetch(array $context): Response {
		$objectId = $context['pathParameters'][$this->varName];
		$obj = $this->FetchObject($objectId);
		if (is_null($obj) === false) {
			return Response::NewJson($obj, 200);
		} else {
			return Response::NewJsonError('Not found', null, 404);
		}
	}

	protected function WriteObject(User $user, string $primaryKeyProperty, array $member, bool $replace): array {
		$className = $this->GetClassName($member);

		if (isset($member[$primaryKeyProperty]) === false) {
			$member[$primaryKeyProperty] = $className::GenerateObjectId($member);
		}
		$primaryKey = $member[$primaryKeyProperty];

		$obj = $className::Fetch($primaryKey);
		$permissions = DatabaseObjectAuthorizer::GetPermissionsForUser(object: $obj, className: $className, objectId: $primaryKey, user: $user, options: DatabaseObjectAuthorizer::kOptionNoFetch, newObjectProperties: $member);
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
			$obj = $className::Create($member);
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
			$member = Core::BodyAsJSON();
			$className = $this->GetClassName($member);

			$schema = $className::DatabaseSchema();
			$primaryKeyProperty = $schema->PrimaryColumn()->PropertyName();
			$primaryKey = $context['pathParameters'][$this->varName];
			$user = Core::User();

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
		$primaryKeyProperties = [];
		$newObjects = [];
		$updatedObjects = [];
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		foreach ($members as $member) {
			$className = $this->GetClassName($member);
			if (array_key_exists($className, $primaryKeyProperties)) {
				$primaryKeyProperty = $primaryKeyProperties[$className];
			} else {
				$schema = $className::DatabaseSchema();
				$primaryKeyProperty = $schema->PrimaryColumn()->PropertyName();
				$primaryKeyProperties[$className] = $primaryKeyProperty;
			}

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
		try {
			$database->Commit();
		} catch (Exception $err) {
			$database->Rollback();
			return Response::NewJsonError('After saving the new objects, one or more required objects are still missing. The changes have been reverted.', null, 500);
		}

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
			$objectId = $context['pathParameters'][$this->varName];
			$obj = $this->FetchObject($objectId);
			if (is_null($obj)) {
				// Pretend success
				return Response::NewNoContent();
			}
			$primaryKeyProperty = $obj->PrimaryKeyProperty();
			$primaryKey = $obj->PrimaryKey();

			$user = Core::User();
			$permissions = DatabaseObjectAuthorizer::GetPermissionsForUser(object: $obj, className: get_class($obj), objectId: $primaryKey, user: $user, options: DatabaseObjectAuthorizer::kOptionNoFetch);
			if (($permissions & DatabaseObject::kPermissionDelete) !== DatabaseObject::kPermissionDelete) {
				return Response::NewJsonError('Forbidden', $obj, 403);
			}

			$obj->Delete();
			return Response::NewNoContent();
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
		$primaryKeyProperties = [];
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		foreach ($members as $member) {
			try {
				$className = $this->GetClassName($member);
				if (array_key_exists($className, $primaryKeyProperties)) {
					$primaryKeyProperty = $primaryKeyProperties[$className];
				} else {
					$schema = $className::DatabaseSchema();
					$primaryKeyProperty = $schema->PrimaryColumn()->PropertyName();
					$primaryKeyProperties[$className] = $primaryKeyProperty;
				}
				$primaryKey = $member[$primaryKeyProperty];
				$obj = $className::Fetch($primaryKey);
				if (is_null($obj)) {
					continue;
				}

				$permissions = DatabaseObjectAuthorizer::GetPermissionsForUser(object: $obj, className: get_class($obj), objectId: $primaryKey, user: $user, options: DatabaseObjectAuthorizer::kOptionNoFetch);
				if (($permissions & DatabaseObject::kPermissionDelete) !== DatabaseObject::kPermissionDelete) {
					$database->Rollback();
					return Response::NewJsonError('Forbidden', $member, 403);
				}

				$obj->Delete();
			} catch (Exception $err) {
				$database->Rollback();
				return Response::NewJsonError('Internal server error', $member, 500);
			}
		}
		$database->Commit();

		return Response::NewNoContent();
	}
}

?>
