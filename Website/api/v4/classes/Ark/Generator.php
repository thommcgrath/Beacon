<?php

namespace BeaconAPI\v4\Ark;
use BeaconAPI\v4\Project;
use BeaconCommon, Exception;

class Generator {
	protected Project $project;
	protected float $qualityScale;
	protected int $mapMask;
	protected float $difficultyValue;
	
	public function __construct(Project $project) {
		$this->project = $project;
		$this->qualityScale = 1.0;
		$this->mapMask = $project->MapMask();
		$this->difficultyValue = $project->DifficultyValue();
	}
	
	public function QualityScale(): float {
		return $this->qualityScale;
	}
	
	public function SetQualityScale(float $qualityScale): void {
		$this->qualityScale = $qualityScale;
	}
	
	public function MapMask(): int {
		return $this->mapMask;
	}
	
	public function SetMapMask(int $mapMask): void {
		$this->mapMask = $mapMask;
	}
	
	public function DifficultyValue(): float {
		return $this->difficultyValue;
	}
	
	public function SetDifficultyValue(float $difficultyValue): void {
		$this->difficultyValue = $difficultyValue;
	}
	
	public function Generate(string $input = ''): string {
		$contents = $this->project->Content(false, true);
		if (empty($contents)) {
			throw new Exception('The project is empty.');
		}
		
		$version = $contents['Version'];
		if (isset($contents['Config Sets'])) {
			if (isset($contents['Config Sets']['94c9797d-857d-574a-bdb9-30ee6543ed12']['LootDrops']['Contents'])) {
				$lootSourcesJson = $contents['Config Sets']['94c9797d-857d-574a-bdb9-30ee6543ed12']['LootDrops']['Contents'];
			} elseif (isset($contents['Config Sets']['Base']['LootDrops']['Contents'])) {
				$lootSourcesJson = $contents['Config Sets']['Base']['LootDrops']['Contents'];
			} else {
				$lootSourcesJson = [];
			}
		} elseif (isset($contents['Configs'])) {
			if (isset($contents['Configs']['LootDrops']['Contents'])) {
				$lootSourcesJson = $contents['Configs']['LootDrops']['Contents'];
			} else {
				$lootSourcesJson = [];
			}
		} elseif (isset($contents['LootSources'])) {
			$lootSourcesJson = $contents['LootSources'];
		} else {
			$lootSourcesJson = [];
		}
		$newLines = [
			sprintf('SupplyCrateLootQualityMultiplier=%F', $this->qualityScale)
		];
		
		foreach ($lootSourcesJson as $json) {
			$definition = null;
			if (array_key_exists('Reference', $json)) {
				$uuid = $json['Reference']['UUID'];
				$class = $json['Reference']['Class'];
				$definition = LootDrop::Fetch($uuid);
			} elseif (array_key_exists('SupplyCrateClassString', $json)) {
				$class = $json['SupplyCrateClassString'];
				$definition = LootDrop::Fetch($class);
			} else {
				continue;
			}
			if (is_null($definition)) {
				continue;
			}
			if ($definition->AvailableTo($this->mapMask) === false) {
				continue;
			}
			
			$randomWithoutReplacement = true;
			if (array_key_exists('PreventDuplicates', $json)) {
				$randomWithoutReplacement = boolval($json['PreventDuplicates']);
			} elseif (array_key_exists('bSetsRandomWithoutReplacement', $json)) {
				$randomWithoutReplacement = boolval($json['bSetsRandomWithoutReplacement']);
			}
			
			$minItemSets = intval($json['MinItemSets']);
			$maxItemSets = intval($json['MaxItemSets']);
			
			$appendMode = false;
			if (array_key_exists('AppendMode', $json)) {
				$appendMode = boolval($json['AppendMode']);
			} elseif (array_key_exists('bAppendMode', $json)) {
				$appendMode = boolval($json['bAppendMode']);
			}
			
			$sets = [];
			$totalWeight = $this->SumOfItemSetWeights($json['ItemSets']);
			foreach ($json['ItemSets'] as $item_set) {
				$sets[] = $this->RenderItemSet($definition, $item_set, $totalWeight);
			}
			
			$keys = [
				sprintf('SupplyCrateClassString="%s"', $class)
			];
			if ($appendMode) {
				$keys[] = 'bAppendItemSets=True';
			} else {
				$keys[] = sprintf('MinItemSets=%u', $minItemSets);
				$keys[] = sprintf('MaxItemSets=%u', $maxItemSets);
				$keys[] = 'NumItemSetsPower=1';
				$keys[] = sprintf('bSetsRandomWithoutReplacement=%s', $randomWithoutReplacement ? 'true' : 'false');
			}
			$keys[] = sprintf('ItemSets=(%s)', implode(',', $sets));
			
			$newLines[] = sprintf('ConfigOverrideSupplyCrateItems=(%s)', implode(',', $keys));
		}
		
		$input = trim($input);
		$input = str_replace(chr(13) . chr(10), chr(10), $input);
		$input = str_replace(chr(13), chr(10), $input);
		$lines = explode(chr(10), $input);
		$groups = [];
		$currentGroup = '';
		
		foreach ($lines as $line) {
			$line = trim($line);
			if (empty($line)) {
				continue;
			}
			if (strlen($line) > 2 && substr($line, 0, 1) == '[' && substr($line, -1) == ']') {
				$currentGroup = strtolower(substr($line, 1, strlen($line) - 2));
				continue;
			}
			
			// don't import the keys we're going to replace
			if ($currentGroup == '/script/shootergame.shootergamemode' && strpos($line, '=') !== false) {
				list($key, $value) = explode('=', $line, 2);
				if ($key == 'ConfigOverrideSupplyCrateItems' || $key == 'SupplyCrateLootQualityMultiplier') {
					continue;
				}
			}
			
			if (array_key_exists($currentGroup, $groups)) {
				$groupLines = $groups[$currentGroup];
			} else {
				$groupLines = [];
			}
			
			$groupLines[] = $line;
			$groups[$currentGroup] = $groupLines;
		}
		
		$shooterGroup = [];
		if (array_key_exists('/script/shootergame.shootergamemode', $groups)) {
			$shooterGroup = $groups['/script/shootergame.shootergamemode'];
		}
		$shooterGroup = array_merge($shooterGroup, $newLines);
		$groups['/script/shootergame.shootergamemode'] = $shooterGroup;
		
		$outputLines = [];
		foreach ($groups as $header => $lines) {
			if ($header !== '') {
				$outputLines[] = '[' . $header . ']';
			}
			$outputLines = array_merge($outputLines, $lines);
			$outputLines[] = '';
		}
		
		return trim(implode(chr(13) . chr(10), $outputLines));
	}
	
	protected function SumOfItemSetWeights(array $sets) {
		$sum = 0;
		foreach ($sets as $set) {
			$sum = $sum + max(floatval($set['SetWeight']), 0.0001);
		}
		return $sum;
	}
	
	protected function SumOfEntryWeights(array $entries) {
		$sum = 0;
		foreach ($entries as $entry) {
			$sum = $sum + max(floatval($entry['EntryWeight']), 0.0001);
		}
		return $sum;
	}
	
	protected function QualityTagToValue(string $tag, float $crateQualityMultiplier) {
		$rawValue = 0;
		switch ($tag) {
		case 'Tier2':
			$rawValue = 4.8;
			break;
		case 'Tier3':
			$rawValue = 7.68;
			break;
		case 'Tier4':
			$rawValue = 14.4;
			break;
		case 'Tier5':
			$rawValue = 21.12;
			break;
		case 'Tier6':
			$rawValue = 26.88;
			break;
		case 'Tier7':
			$rawValue = 34.56;
			break;
		case 'Tier8':
			$rawValue = 42.24;
			break;
		case 'Tier9':
			$rawValue = 53.76;
			break;
		}
		
		$crateArbitraryQuality = $crateQualityMultiplier + (($crateQualityMultiplier - 1) * 0.2);
		$difficultyOffset = min(($this->difficultyValue - 0.5) / (ceil($this->difficultyValue) - 0.5), 1.0);
		if ($difficultyOffset <= 0) {
			$difficultyOffset = 1.0;
		}
		$baseArbitraryQuality = 0.75 + ($difficultyOffset * 1.75);
		return $rawValue / ($baseArbitraryQuality * $crateArbitraryQuality);
	}
	
	protected function RenderItemSet(LootDrop $source, array $set, float $weightTotal): string {
		$randomWithoutReplacement = boolval($set['bItemsRandomWithoutReplacement']);
		$name = $set['Label'];
		$entries = $set['ItemEntries'];
		$minEntries = min(max(intval($set['MinNumItems']), 1), count($entries));
		$maxEntries = min(max(intval($set['MaxNumItems']), $minEntries), count($entries));
		$localWeight = max(floatval($set['SetWeight']), 0.0001);
		$relativeWeight = round(($localWeight / $weightTotal) * 1000);
		
		$entriesWeightSum = $this->SumOfEntryWeights($entries);
		$children = [];
		foreach ($entries as $entry) {
			$children[] = $this->RenderEntry($source, $entry, $entriesWeightSum);
		}
		
		$keys = [
			sprintf('SetName="%s"', $name),
			sprintf('MinNumItems=%u', $minEntries),
			sprintf('MaxNumItems=%u', $maxEntries),
			'NumItemsPower=1',
			sprintf('SetWeight=%u', $relativeWeight),
			sprintf('bItemsRandomWithoutReplacement=%s', $randomWithoutReplacement ? 'true' : 'false'),
			sprintf('ItemEntries=(%s)', implode(',', $children))
		];
		
		return '(' . implode(',', $keys) . ')';
	}
	
	protected function RenderEntry(LootDrop $source, array $entry, float $weightTotal): string {
		$blueprintChance = floatval($entry['ChanceToBeBlueprintOverride']);
		$localWeight = max(floatval($entry['EntryWeight']), 0.0001);
		$relativeWeight = round(($localWeight / $weightTotal) * 1000);
		$items = $entry['Items'];
		$maxQualityTag = $entry['MaxQuality'];
		$minQualityTag = $entry['MinQuality'];
		$maxQuantity = intval($entry['MaxQuantity']);
		$minQuantity = intval($entry['MinQuantity']);
		
		$classes = [];
		$relativeWeights = [];
		$optionsWeightSum = 0;
		foreach ($items as $item) {
			$optionsWeightSum = $optionsWeightSum + max(floatval($item['Weight']), 0.0001);
		}
		foreach ($items as $item) {
			if (isset($item['Blueprint']['Class'])) {
				$classes[] = sprintf('"%s"', $item['Blueprint']['Class']);
			} elseif (isset($item['Class'])) {
				$classes[] = sprintf('"%s"', $item['Class']);
			}
			
			$relativeWeights[] = sprintf('%u', round((max(floatval($item['Weight']), 0.0001) / $optionsWeightSum) * 1000));
		}
		
		$keys = [
			sprintf('EntryWeight=%u', $relativeWeight),
			sprintf('MinQuantity=%u', $minQuantity),
			sprintf('MaxQuantity=%u', $maxQuantity),
			sprintf('bForceBlueprint=%s', $blueprintChance >= 1 ? 'true' : 'false'),
			sprintf('ChanceToBeBlueprintOverride=%F', $blueprintChance),
			sprintf('MinQuality=%F', $this->QualityTagToValue($minQualityTag, $source->MultiplierMin())),
			sprintf('MaxQuality=%F', $this->QualityTagToValue($maxQualityTag, $source->MultiplierMax())),
			sprintf('ItemClassStrings=(%s)', implode(',', $classes)),
			sprintf('ItemsWeights=(%s)', implode(',', $relativeWeights))
		];
		
		return '(' . implode(',', $keys) . ')';
	}
}

?>
