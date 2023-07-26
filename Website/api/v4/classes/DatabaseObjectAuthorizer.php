<?php

namespace BeaconAPI\v4;
use BeaconCommon;

abstract class DatabaseObjectAuthorizer {
	public const kOptionNoCache = 1;
	public const kOptionNoFetch = 2;
	
	private static array $permissions = [];
	
	private static function CacheId(string $objectId, User $user): string {
		return $objectId . ':' . $user->UserId();
	}
	
	public static function GetPermissionsForUser(string $className, string $objectId, User $user, ?DatabaseObject $object = null, int $options = 0, ?array $newObjectProperties = null): int {
		$useCache = ($options & static::kOptionNoCache) === 0;
		$fetchObject = ($options & static::kOptionNoFetch) === 0;
		
		$cacheId = static::CacheId($objectId, $user);
		if ($useCache === false || array_key_exists($cacheId, static::$permissions) === false) {
			if ($fetchObject) {
				$object = $className::Fetch($objectId);
			}
			if (is_null($object)) {
				static::$permissions[$cacheId] = $className::GetNewObjectPermissionsForUser($user, $newObjectProperties);
			} else {
				static::$permissions[$cacheId] = $object->GetPermissionsForUser($user);
			}
		}
		return static::$permissions[$cacheId];
	}
}

?>
