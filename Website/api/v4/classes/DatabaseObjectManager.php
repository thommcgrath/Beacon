<?php

namespace BeaconAPI\v4;
use BeaconCommon, BeaconQueryException, BeaconUUID, Exception;

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

		// Include schema route
		Core::RegisterRoutes(["/schemas/{$this->path}" => [
			"GET" => [
				'handleRequest' => [$this, 'HandleSchemaRequest'],
			],
		]]);

		$collectFrontMatter = isset($_SERVER['DBOMFrontMatter']);
		if ($collectFrontMatter) {
			$className = substr($this->className, 13);
			if (str_contains($className, '\\')) {
				$classParts = explode('\\', $className);
				$classTitle = $classParts[count($classParts) - 1];
				$classParent = $classParts[count($classParts) - 2];
				if (count($classParts) > 2) {
					$classGrandParent = $classParts[count($classParts) - 3];
				} else {
					$classGrandParent = 'Classes';
				}
				$location = strtolower(implode('/', array_slice($classParts, 0, count($classParts) - 1))) . '/' . strtolower($classTitle);
			} else {
				$classTitle = $className;
				$classParent = 'Classes';
				$classGrandParent = 'Version ' . Core::ApiVersionNumber();
				$location = strtolower($classTitle);
			}

			$frontMatter = [
				'title' => $classTitle,
				'parent' => $classParent,
				'grand_parent' => $classGrandParent,
				'has_children' => false,
				'apiVersion' => Core::ApiVersionNumber(),
				'classPath' => $this->path,
				'identifierProperty' => $this->varName,
				'supportedClassMethods' => [],
				'supportedInstanceMethods' => [],
			];
			$fileLocation = dirname(API_ROOT, 2) . '/docs/api/v' . Core::ApiVersionNumber() . '/classes/' . $location;
		}

		if ($bulk) {
			$methods = [];

			if ($create || $update) {
				$methods['POST'] = [
					'handleRequest' => [$this, 'HandleBulkUpdate'],
					'setupAuthParameters' => [$this->className, 'SetupAuthParameters'],
				];
			}
			if ($read) {
				$methods['GET'] = [
					'handleRequest' => [$this, 'HandleList'],
					'setupAuthParameters' => [$this->className, 'SetupAuthParameters'],
				];
			}
			if ($update) {
				$methods['PATCH'] = [
					'handleRequest' => [$this, 'HandleBulkUpdate'],
					'setupAuthParameters' => [$this->className, 'SetupAuthParameters'],
				];
			}
			if ($delete) {
				$methods['DELETE'] = [
					'handleRequest' => [$this, 'HandleBulkDelete'],
					'setupAuthParameters' => [$this->className, 'SetupAuthParameters'],
				];
			}

			if ($collectFrontMatter) {
				$frontMatter['supportedClassMethods'] = array_keys($methods);
			}
			Core::RegisterRoutes(["/{$this->path}" => $methods]);
		}
		if ($single) {
			$methods = [];

			if ($create || $update) {
				$methods['PUT'] = [
					'handleRequest' => [$this, 'HandleReplace'],
					'setupAuthParameters' => [$this->className, 'SetupAuthParameters'],
				];
			}
			if ($read) {
				$methods['GET'] = [
					'handleRequest' => [$this, 'HandleFetch'],
					'setupAuthParameters' => [$this->className, 'SetupAuthParameters'],
				];
			}
			if ($update) {
				$methods['PATCH'] = [
					'handleRequest' => [$this, 'HandleUpdate'],
					'setupAuthParameters' => [$this->className, 'SetupAuthParameters'],
				];
			}
			if ($delete) {
				$methods['DELETE'] = [
					'handleRequest' => [$this, 'HandleDelete'],
					'setupAuthParameters' => [$this->className, 'SetupAuthParameters'],
				];
			}

			if ($collectFrontMatter) {
				$frontMatter['supportedInstanceMethods'] = array_keys($methods);
			}
			Core::RegisterRoutes(["/{$this->path}/{{$this->varName}}" => $methods]);
		}

		if ($collectFrontMatter) {
			$_SERVER['DBOMFrontMatter'][$fileLocation] = $frontMatter;
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
		$filters = $_GET;
		try {
			$this->className::AuthorizeListRequest($filters);
		} catch (APIException $err) {
			return Response::NewJsonError(code: $err->getBeaconErrorCode(), message: $err->getMessage(), httpStatus: $err->getHttpStatus());
		} catch (Exception $err) {
			return Response::NewJsonError(code: 'forbidden', message: 'Forbidden', details: $err->getMessage(), httpStatus: 403);
		}
		$results = $this->className::Search($filters);
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
			return Response::NewJsonError(code: 'objectNotFound', message: 'Not found', httpStatus: 404);
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
				'code' => 'forbidden',
				'status' => 403,
				'success' => false,
				'keyProperty' => $primaryKeyProperty,
				$primaryKeyProperty => $primaryKey,
				'object' => $member,
				'reason' => 'Forbidden',
			];
		}

		if (is_null($obj)) {
			if (isset($member['userId']) === false) {
				$member['userId'] = $user->UserId(); // In case it is needed
			}
			$obj = $className::Create($member);
			if (is_null($obj)) {
				return [
					'code' => 'exception',
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
			return Response::NewJsonError(code: 'badContentType', message: 'This endpoint expects a JSON body. Make sure the Content-Type header is application/json.', details: $_SERVER['HTTP_CONTENT_TYPE'], httpStatus: 400);
		}

		$database = BeaconCommon::Database();
		$inTransaction = false;
		try {
			$member = Core::BodyAsJSON();
			$className = $this->GetClassName($member);

			$user = Core::User();
			$schema = $className::DatabaseSchema();
			$primaryKeyProperty = $schema->PrimaryColumn()->PropertyName();
			$primaryKey = $context['pathParameters'][$this->varName];
			$member[$primaryKeyProperty] = $primaryKey;

			$database->BeginTransaction();
			$inTransaction = true;
			$status = $this->WriteObject($user, $primaryKeyProperty, $member, $replace);
			if ($status['success'] === true) {
				if ($status['status'] === 201) {
					$limits = $className::GetResourceLimitsForUser($user);
					if (is_null($limits) === false && $limits->IsOverLimit()) {
						$database->Rollback();
						$inTransaction = false;
						return Response::NewJsonError(code: 'tooManyResources', message: 'Cannot create more of this resource. ' . $limits->UsedResources() . ' used of ' . $limits->AllowedResources() . ' allowed.', details: $limits, httpStatus: 400);
					}
				}
				$database->Commit();
				$inTransaction = false;
				return Response::NewJson($status['object'], $status['status']);
			} else {
				$database->Rollback();
				$inTransaction = false;
				return Response::NewJsonError(code: $status['code'], message: $status['reason'], details: $status['object'], httpStatus: $status['status']);
			}
		} catch (APIException $err) {
			if ($inTransaction) {
				$database->Rollback();
			}
			return Response::NewJsonError(code: $err->getBeaconErrorCode(), message: $err->getMessage(), httpStatus: $err->getHttpStatus());
		} catch (Exception $err) {
			if ($inTransaction) {
				$database->Rollback();
			}
			return Response::NewJsonError(code: 'exception', message: $err->getMessage(), httpStatus: 500);
		}
	}

	protected function HandleBulkWrite(array $context, bool $replace): Response {
		if (Core::IsJsonContentType() === false) {
			return Response::NewJsonError(code: 'badContentType', message: 'This endpoint expects a JSON body. Make sure the Content-Type header is application/json.', details: $_SERVER['HTTP_CONTENT_TYPE'], httpStatus: 400);
		}

		$members = Core::BodyAsJSON();
		if (count($members) === 0) {
			return Response::NewJsonError(code: 'noObjects', message: 'No objects to save', httpStatus: 400);
		}
		if (BeaconCommon::IsAssoc($members)) {
			$members = [$members];
		}

		$user = Core::User();
		$newObjectCounts = [];
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
					return Response::NewJsonError(code: $response['code'], message: $response['reason'], details: $response['object'], httpStatus: $response['status']);
				}
				if ($response['status'] === 201) {
					$newObjects[] = $response['object'];
					$newObjectCounts[$className] = ($newObjectCounts[$className] ?? 0) + 1;
				} else {
					$updatedObjects[] = $response['object'];
				}
			} catch (APIException $err) {
				$database->Rollback();
				return Response::NewJsonError(code: $err->getBeaconErrorCode(), message: $err->getMessage(), details: $member, httpStatus: $err->getHttpStatus());
			} catch (Exception $err) {
				$database->Rollback();
				return Response::NewJsonError(code: 'exception', message: $err->getMessage(), details: $member, httpStatus: 500);
			}
		}
		foreach ($newObjectCounts as $className => $objectCount) {
			$limits = $className::GetResourceLimitsForUser($user);
			if (is_null($limits) === false && $limits->IsOverLimit()) {
				$database->Rollback();
				return Response::NewJsonError(code: 'tooManyResources', message: 'Cannot create ' . $objectCount . ' more of this resource. ' . $limits->UsedResources() . ' used of ' . $limits->AllowedResources() . ' allowed.', details: $limits, httpStatus: 400);
			}
		}
		try {
			$database->Commit();
		} catch (Exception $err) {
			$database->Rollback();

			$details = [
				'code' => $err->getCode(),
				'message' => $err->getMessage(),
			];
			if ($err instanceof BeaconQueryException && $details['code'] === 23503) {
				// Foreign key violation
				unset($details['message']);
				if (preg_match('/insert or update on table "(.+)" violates foreign key constraint "(.+)"/', $err->getMessage(), $matches) === 1) {
					$details['sourceTable'] = $matches[1];
				}

				if (preg_match('/Key \((.+)\)=\((.+)\) is not present in table "(.+)"./', $err->getMessage(), $matches) === 1) {
					$details['column'] = $matches[1];
					$details['value'] = $matches[2];
					$details['targetTable'] = $matches[3];
				}
			}

			return Response::NewJsonError(code: 'exception', message: 'After saving the new objects, one or more required objects are still missing. The changes have been reverted.', details: $details, httpStatus: 500);
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
				return Response::NewJsonError(code: 'forbidden', message: 'Forbidden', details: $obj, httpStatus: 403);
			}

			$obj->Delete();
			return Response::NewNoContent();
		} catch (APIException $err) {
			return Response::NewJsonError(code: $err->getBeaconErrorCode(), message: $err->getMessage(), httpStatus: $err->getHttpStatus());
		} catch (Exception $err) {
			return Response::NewJsonError(code: 'exception', message: $err->getMessage(), httpStatus: 500);
		}
	}

	public function HandleBulkDelete(array $context): Response {
		if (Core::IsJsonContentType() === false) {
			return Response::NewJsonError(code: 'badContentType', message: 'This endpoint expects a JSON body. Make sure the Content-Type header is application/json.', details: $_SERVER['HTTP_CONTENT_TYPE'], httpStatus: 400);
		}

		$members = Core::BodyAsJSON();
		if (count($members) === 0) {
			return Response::NewJsonError(code: 'noObjects', message: 'No objects to delete', details: 400);
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
					return Response::NewJsonError(code: 'forbidden', message: 'Forbidden', details: $member, httpStatus: 403);
				}

				$obj->Delete();
			} catch (APIException $err) {
				$database->Rollback();
				return Response::NewJsonError(code: $err->getBeaconErrorCode(), message: $err->getMessage(), details: $member, httpStatus: $err->getHttpStatus());
			} catch (Exception $err) {
				$database->Rollback();
				return Response::NewJsonError(code: 'exception', message: $err->getMessage(), details: $member, httpStatus: 500);
			}
		}
		try {
			$database->Commit();
		} catch (Exception $err) {
			$database->Rollback();
			return Response::NewJsonError(code: 'objectStillReferenced', message: 'One or more of the deleted objects is needed by another object. The changes have been reverted.', httpStatus: 500);
		}

		return Response::NewNoContent();
	}

	public function HandleSchemaRequest(array $context): Response {
		$schema = $this->className::JSONSchema();
		if (is_null($schema)) {
			return Response::NewJsonError(code: 'schemaNotFound', message: 'Sorry, a schema for this class is not ready yet.', httpStatus: 404);
		}
		return Response::NewJson($schema, 200);
	}
}

?>
