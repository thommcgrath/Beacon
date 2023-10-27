<?php

namespace BeaconAPI\v4\ArkSA;
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

		$configSets = $contents['configSetData'];
		$baseConfigSet = $configSets['94c9797d-857d-574a-bdb9-30ee6543ed12'];
		if (isset($baseConfigSet['ArkSA.LootDrops'])) {
			$lootDrops = $baseConfigSet['ArkSA.LootDrops']['Contents'];
		} else {
			$lootDrops = [];
		}

		$newLines = [
			sprintf('SupplyCrateLootQualityMultiplier=%F', $this->qualityScale)
		];

		foreach ($lootDrops as $drop) {
			$definition = null;
			$dropId = $drop['lootDropId'];
			$definition = LootDrop::Fetch($dropId);
			if (is_null($definition)) {
				continue;
			}
			if ($definition->AvailableTo($this->mapMask) === false) {
				continue;
			}

			$randomWithoutReplacement = filter_var($drop['preventDuplicates'], FILTER_VALIDATE_BOOL);
			$minItemSets = filter_var($drop['minItemSets'], FILTER_VALIDATE_INT);
			$maxItemSets = filter_var($drop['maxItemSets'], FILTER_VALIDATE_INT);
			$appendMode = filter_var($drop['appendMode'], FILTER_VALIDATE_BOOL);

			$sets = [];
			$totalWeight = $this->SumOfItemSetWeights($drop['itemSets']);
			foreach ($drop['itemSets'] as $itemSet) {
				$sets[] = $this->RenderItemSet($definition, $itemSet, $totalWeight);
			}

			$keys = [
				sprintf('SupplyCrateClassString="%s"', $definition->ClassString())
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
			$sum = $sum + max(floatval($set['weight']), 0.0001);
		}
		return $sum;
	}

	protected function SumOfEntryWeights(array $entries) {
		$sum = 0;
		foreach ($entries as $entry) {
			$sum = $sum + max(floatval($entry['weight']), 0.0001);
		}
		return $sum;
	}

	protected function QualityTagToValue(string $tag, float $crateQualityMultiplier) {
		$rawValue = 0;
		switch ($tag) {
		case 'Tier1':
			$rawValue = 0.5;
			break;
		case 'Tier2':
			$rawValue = 3.0;
			break;
		case 'Tier3':
			$rawValue = 5.0;
			break;
		case 'Tier4':
			$rawValue = 8.7;
			break;
		case 'Tier5':
			$rawValue = 12.5;
			break;
		case 'Tier6':
			$rawValue = 20.0;
			break;
		case 'Tier7':
			$rawValue = 40.0;
			break;
		case 'Tier8':
			$rawValue = 60.0;
			break;
		case 'Tier9':
			$rawValue = 80.0;
			break;
		case 'Tier10':
			$rawValue = 100.0;
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
		$randomWithoutReplacement = filter_var($set['preventDuplicates'], FILTER_VALIDATE_BOOL);
		$name = $set['label'];
		$entries = $set['entries'];
		$minEntries = min(max(filter_var($set['minEntries'], FILTER_VALIDATE_INT), 1), count($entries));
		$maxEntries = min(max(filter_var($set['maxEntries'], FILTER_VALIDATE_INT), $minEntries), count($entries));
		$localWeight = max(filter_var($set['weight'], FILTER_VALIDATE_FLOAT), 0.0001);
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
		$blueprintChance = filter_var($entry['blueprintChance'], FILTER_VALIDATE_FLOAT);
		$localWeight = max(filter_var($entry['weight'], FILTER_VALIDATE_FLOAT), 0.0001);
		$relativeWeight = round(($localWeight / $weightTotal) * 1000);
		$items = $entry['options'];
		$maxQualityTag = $entry['maxQuality'];
		$minQualityTag = $entry['minQuality'];
		$maxQuantity = filter_var($entry['maxQuantity'], FILTER_VALIDATE_INT);
		$minQuantity = filter_var($entry['minQuantity'], FILTER_VALIDATE_INT);

		$classes = [];
		$relativeWeights = [];
		$optionsWeightSum = 0;
		foreach ($items as $item) {
			$optionsWeightSum = $optionsWeightSum + max(filter_var($item['weight'], FILTER_VALIDATE_FLOAT), 0.0001);
		}
		foreach ($items as $item) {
			$engramId = $item['engramId'];
			$engram = Engram::Fetch($engramId);
			if (is_null($engram)) {
				continue;
			}

			$classes[] = $engram->ClassString();
			$relativeWeights[] = sprintf('%u', round((max(filter_var($item['weight'], FILTER_VALIDATE_FLOAT), 0.0001) / $optionsWeightSum) * 1000));
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
