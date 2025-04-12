<?php

namespace BeaconAPI\v4\Sentinel;

trait SentinelObject {
	abstract public static function GetSentinelPermissions(string $objectId, string $userId): int;

	public static function TestSentinelPermissions(string $objectId, string $userId, int $requiredBits = 1): bool {
		return (static::GetSentinelPermissions($objectId, $userId) & $requiredBits) > 0;
	}
}

?>
