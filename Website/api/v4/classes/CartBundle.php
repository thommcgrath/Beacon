<?php

namespace BeaconAPI\v4;

class CartBundle {
	protected $source;

	public function __construct(array $source) {
		$this->source = $source;
	}

	public function getQuantity(string $productId): int {
		if (array_key_exists($productId, $this->source['products'])) {
			return $this->source['products'][$productId];
		} else {
			return 0;
		}
	}

	public function isGift(): bool {
		return $this->source['isGift'] ?? false;
	}

	public function isAnnual(): bool {
		return $this->source['isAnnual'] ?? false;
	}

	public function ProductIds(): array {
		if (array_key_exists('products', $this->source)) {
			return array_keys($this->source['products']);
		} else {
			return [];
		}
	}
}

?>
