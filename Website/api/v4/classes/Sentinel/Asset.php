<?php

namespace BeaconAPI\v4\Sentinel;

interface Asset {
	public function AssetId(): string;
	public function AssetTypeMask(): int;
	public function AssetType(): string;
	public function AssetName(): string;
}

?>
