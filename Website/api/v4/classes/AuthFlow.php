<?php

namespace BeaconAPI\v4;
use BeaconCommon;

trait AuthFlow {
	abstract public function IsExpired(): bool;
	abstract public function IsCompleted(): bool;
	abstract public function FlowId(): string;
	abstract public function ApplicationId(): string;
	abstract public function Application(): Application;
	abstract public function Scopes(): array;
	abstract public function HasScope(string $scope): bool;
	abstract public function UserId(): ?string;
	abstract public function User(): ?User;
	abstract public function Authorize(string $deviceId, string $challenge, int $expiration, User $user, ?string $userPassword = null): string;

	public function NewChallenge(string $deviceId, User $user, int $expiration): string {
		$challengeSecret = $this->Application()->Secret() ?? '';
		$challengeRaw = $deviceId . $expiration . $challengeSecret . $this->FlowId() . $user->UserId();
		return BeaconCommon::Base64UrlEncode(hash('sha3-512', $challengeRaw, true));
	}
}

?>
