<?php

namespace BeaconAPI\v4\Ark;

class BlueprintGroup {
	protected string $humanVersion;
	protected string $urlVersion;
	protected string $apiVersion;
	
	protected function __construct(string $humanVersion, string $urlVersion, string $apiVersion) {
		$this->humanVersion = $humanVersion;
		$this->urlVersion = $urlVersion;
		$this->apiVersion = $apiVersion;
	}
	
	public static function CreaturesGroup(): static {
		return new static('Creatures', 'Creatures', 'creatures');
	}
	
	public static function EngramsGroup(): static {
		return new static('Engrams', 'Engrams', 'engrams');
	}
	
	public static function LootDropsGroup(): static {
		return new static('Loot Drops', 'LootDrops', 'lootDrops');
	}
	
	public static function SpawnPointsGroup(): static {
		return new static('Spawn Points', 'SpawnPoints', 'spawnPoints');
	}
	
	public static function Groups(): array {
		return [
			static::CreaturesGroup(),
			static::EngramsGroup(),
			static::LootDropsGroup(),
			static::SpawnPointsGroup()
		];
	}
	
	public static function FindGroup(string $id): ?static {
		switch (strtolower($id)) {
		case 'creatures':
			return static::CreaturesGroup();
		case 'engrams':
			return static::EngramsGroup();
		case 'loot drops':
		case 'lootdrops':
			return static::LootDropsGroup();
		case 'spawn points':
		case 'spawnpoints':
			return static::SpawnPointsGroup();
		default:
			return null;
		}
	}
	
	public function HumanVersion(): string {
		return $this->humanVersion;
	}
	
	public function UrlVersion(): string {
		return $this->urlVersion;
	}
	
	public function ApiVersion(): string {
		return $this->apiVersion;
	}
}

?>
