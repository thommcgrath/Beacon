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
	abstract public function CodeVerifierHash(): string;
	abstract public function CodeVerifierMethod(): string;

	public function NewChallenge(string $deviceId, User $user, int $expiration): string {
		$challengeSecret = $this->Application()->Secret() ?? '';
		$challengeRaw = $deviceId . $expiration . $challengeSecret . $this->FlowId() . $user->UserId();
		return BeaconCommon::Base64UrlEncode(hash('sha3-512', $challengeRaw, true));
	}

	protected static function ValidateCodeVerifier(string $codeVerifierHash, string $codeVerifierMethod): void {
		if (is_null($codeVerifierMethod) || $codeVerifierMethod !== 'S256') {
			throw new APIException(message: 'Unsupported code verifier has method.', code: 'invalidCodeVerifierMethod', httpStatus: 400);
		}
		if (is_null($codeVerifierHash) || strlen($codeVerifierHash) !== 43) {
			throw new APIException(message: 'Verifier hash should be 43 base64url characters.', code: 'invalidCodeVerifierHash', httpStatus: 400);
		}
		if ($codeVerifierHash === '47DEQpj8HBSa-_TImW-5JCeuQeRkm5NMpJWZG3hSuFU') {
			throw new APIException(message: 'Your challenge is built from an empty sha256 hash. This indicates a problem with your verifier generation or hashing code.', code: 'invalidCodeVerifierHash', httpStatus: 400);
		}
	}

	protected function CheckCodeVerifier(string $codeVerifier): bool {
		if (empty($codeVerifier)) {
			return false;
		}

		switch ($this->CodeVerifierMethod()) {
		case 'S256':
			return $this->CodeVerifierHash() === BeaconCommon::Base64UrlEncode(hash('sha256', $codeVerifier, true));
			break;
		default:
			return false;
		}
	}
}

?>
