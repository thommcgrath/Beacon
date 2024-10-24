<?php

namespace BeaconAPI\v4;

trait PermissibleObject {
	abstract public function GetUserPermissions(string $userId): int;

	public function UserHasPermission(string $userId, int $desiredPermissions): bool {
		$permissions = $this->GetUserPermissions($userId);
		return ($permissions & $desiredPermissions) === $desiredPermissions;
	}
}

?>
