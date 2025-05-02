<?php

namespace BeaconAPI\v4;
use JsonSerializable;

class ResourceLimit implements JsonSerializable {
	protected int $usedResources;
	protected int $allowedResources;

	public function __construct(int $usedResources, int $allowedResources) {
		$this->usedResources = $usedResources;
		$this->allowedResources = $allowedResources;
	}

	public function UsedResources(): int {
		return $this->usedResources;
	}

	public function AllowedResources(): int {
		return $this->allowedResources;
	}

	public function jsonSerialize(): mixed {
		return [
			'used' => $this->usedResources,
			'allowed' => $this->allowedResources,
		];
	}

	public function SupportsMore(int $quantity): bool {
		return ($this->usedResources + $quantity) <= $this->allowedResources;
	}

	public function SupportsTotal(int $quantity): bool {
		return $quantity <= $this->allowedResources;
	}

	public function IsOverLimit(): bool {
		return $this->usedResources > $this->allowedResources;
	}
}

?>
