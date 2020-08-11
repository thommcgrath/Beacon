<?php

namespace BeaconAPI

class Generator {
	protected $document, $quality_scale, $map_mask, $difficulty_value;
	
	public function __construct(\BeaconDocument $document) {
		$this->document = $document;
		$this->quality_scale = 1.0;
		$this->map_mask = $document->MapMask();
		$this->difficulty_value = $document->DifficultyValue();
	}
	
	public function SetQualityScale(float $quality_scale) {
		$this->quality_scale = $quality_scale;
	}
	
	public function SetMapMask(int $map_mask) {
		$this->map_mask = $map_mask;
	}
	
	public function SetDifficultyValue(float $difficulty_value) {
		$this->difficulty_value = $difficulty_value;
	}
	
	public function Generate(string $input = '') {
		$contents = $this->document->Content(false, true);
		
		$version = $contents['Version'];
		if ($version >= 3) {
			if (isset($contents['Configs']['LootDrops']['Contents'])) {
				$loot_sources_json = $contents['Configs']['LootDrops']['Contents'];
			} else {
				$loot_sources_json = array();
			}
		} else {
			$loot_sources_json = $contents['LootSources'];
		}
		$new_lines = array(
			sprintf('SupplyCrateLootQualityMultiplier=%F', $this->quality_scale)
		);
		
		foreach ($loot_sources_json as $json) {
			$class = $json['SupplyCrateClassString'];
			$definition = \BeaconLootSource::Get($class);
			if (count($definition) != 1) {
				$definition = new \BeaconLootSource();
				$definition->SetMultiplierMin($json['Multiplier_Min']);
				$definition->SetMultiplierMax($json['Multiplier_Max']);
				$definition->SetAvailability($json['Availability']);
			} else {
				$definition = $definition[0];
			}
			if ($definition->AvailableTo($this->map_mask) == false) {
				continue;
			}
			
			$random_without_replacement = boolval($json['bSetsRandomWithoutReplacement']);
			$min_item_sets = intval($json['MinItemSets']);
			$max_item_sets = intval($json['MaxItemSets']);
			
			$sets = array();
			$total_weight = $this->SumOfItemSetWeights($json['ItemSets']);
			foreach ($json['ItemSets'] as $item_set) {
				$sets[] = $this->RenderItemSet($definition, $item_set, $total_weight);
			}
			
			$keys = array(
				sprintf('SupplyCrateClassString="%s"', $class),
				sprintf('MinItemSets=%u', $min_item_sets),
				sprintf('MaxItemSets=%u', $max_item_sets),
				'NumItemSetsPower=1',
				sprintf('bSetsRandomWithoutReplacement=%s', $random_without_replacement ? 'true' : 'false'),
				sprintf('ItemSets=(%s)', implode(',', $sets))
			);
			
			$new_lines[] = sprintf('ConfigOverrideSupplyCrateItems=(%s)', implode(',', $keys));
		}
		
		$input = trim($input);
		$input = str_replace(chr(13) . chr(10), chr(10), $input);
		$input = str_replace(chr(13), chr(10), $input);
		$lines = explode(chr(10), $input);
		$groups = array();
		$current_group = '';
		
		foreach ($lines as $line) {
			$line = trim($line);
			if (empty($line)) {
				continue;
			}
			if (strlen($line) > 2 && substr($line, 0, 1) == '[' && substr($line, -1) == ']') {
				$current_group = strtolower(substr($line, 1, strlen($line) - 2));
				continue;
			}
			
			// don't import the keys we're going to replace
			if ($current_group == '/script/shootergame.shootergamemode' && strpos($line, '=') !== false) {
				list($key, $value) = explode('=', $line, 2);
				if ($key == 'ConfigOverrideSupplyCrateItems' || $key == 'SupplyCrateLootQualityMultiplier') {
					continue;
				}
			}
			
			if (array_key_exists($current_group, $groups)) {
				$group_lines = $groups[$current_group];
			} else {
				$group_lines = array();
			}
			
			$group_lines[] = $line;
			$groups[$current_group] = $group_lines;
		}
		
		$shooter_group = array();
		if (array_key_exists('/script/shootergame.shootergamemode', $groups)) {
			$shooter_group = $groups['/script/shootergame.shootergamemode'];
		}
		$shooter_group = array_merge($shooter_group, $new_lines);
		$groups['/script/shootergame.shootergamemode'] = $shooter_group;
		
		$output_lines = array();
		foreach ($groups as $header => $lines) {
			if ($header !== '') {
				$output_lines[] = '[' . $header . ']';
			}
			$output_lines = array_merge($output_lines, $lines);
			$output_lines[] = '';
		}
		
		return trim(implode(chr(13) . chr(10), $output_lines));
	}
	
	protected function SumOfItemSetWeights(array $sets) {
		$sum = 0;
		foreach ($sets as $set) {
			$sum = $sum + floatval($set['SetWeight']);
		}
		return $sum;
	}
	
	protected function SumOfEntryWeights(array $entries) {
		$sum = 0;
		foreach ($entries as $entry) {
			$sum = $sum + floatval($entry['EntryWeight']);
		}
		return $sum;
	}
	
	protected function QualityTagToValue(string $tag, float $crate_quality_multiplier) {
		$raw_value = 0;
		switch ($tag) {
		case 'Tier2':
			$raw_value = 4.8;
			break;
		case 'Tier3':
			$raw_value = 7.68;
			break;
		case 'Tier4':
			$raw_value = 14.4;
			break;
		case 'Tier5':
			$raw_value = 21.12;
			break;
		case 'Tier6':
			$raw_value = 26.88;
			break;
		case 'Tier7':
			$raw_value = 34.56;
			break;
		case 'Tier8':
			$raw_value = 42.24;
			break;
		case 'Tier9':
			$raw_value = 53.76;
			break;
		}
		
		$crate_arbitrary_quality = $crate_quality_multiplier + (($crate_quality_multiplier - 1) * 0.2);
		$difficulty_offset = min(($this->difficulty_value - 0.5) / (ceil($this->difficulty_value) - 0.5), 1.0);
		if ($difficulty_offset <= 0) {
			$difficulty_offset = 1.0;
		}
		$base_arbitrary_quality = 0.75 + ($difficulty_offset * 1.75);
		return $raw_value / ($base_arbitrary_quality * $crate_arbitrary_quality);
	}
	
	protected function RenderItemSet(\BeaconLootSource $source, array $set, float $weight_total) {
		$random_without_replacement = boolval($set['bItemsRandomWithoutReplacement']);
		$name = $set['Label'];
		$entries = $set['ItemEntries'];
		$min_entries = min(max(intval($set['MinNumItems']), 1), count($entries));
		$max_entries = min(max(intval($set['MaxNumItems']), $min_entries), count($entries));
		$local_weight = floatval($set['SetWeight']);
		$relative_weight = round(($local_weight / $weight_total) * 1000);
		
		$entries_weight_sum = $this->SumOfEntryWeights($entries);
		$children = array();
		foreach ($entries as $entry) {
			$children[] = $this->RenderEntry($source, $entry, $entries_weight_sum);
		}
		
		$keys = array(
			sprintf('SetName="%s"', $name),
			sprintf('MinNumItems=%u', $min_entries),
			sprintf('MaxNumItems=%u', $max_entries),
			'NumItemsPower=1',
			sprintf('SetWeight=%u', $relative_weight),
			sprintf('bItemsRandomWithoutReplacement=%s', $random_without_replacement ? 'true' : 'false'),
			sprintf('ItemEntries=(%s)', implode(',', $children))
		);
		
		return '(' . implode(',', $keys) . ')';
	}
	
	protected function RenderEntry(\BeaconLootSource $source, array $entry, float $weight_total) {
		$blueprint_chance = floatval($entry['ChanceToBeBlueprintOverride']);
		$local_weight = floatval($entry['EntryWeight']);
		$relative_weight = round(($local_weight / $weight_total) * 1000);
		$items = $entry['Items'];
		$max_quality_tag = $entry['MaxQuality'];
		$min_quality_tag = $entry['MinQuality'];
		$max_quantity = intval($entry['MaxQuantity']);
		$min_quantity = intval($entry['MinQuantity']);
		
		$classes = array();
		$relative_weights = array();
		$options_weight_sum = 0;
		foreach ($items as $item) {
			$options_weight_sum = $options_weight_sum + floatval($item['Weight']);
		}
		foreach ($items as $item) {
			$classes[] = sprintf('"%s"', $item['Class']);
			$relative_weights[] = sprintf('%u', round((floatval($item['Weight']) / $options_weight_sum) * 1000));
		}
		
		$keys = array(
			sprintf('EntryWeight=%u', $relative_weight),
			sprintf('MinQuantity=%u', $min_quantity),
			sprintf('MaxQuantity=%u', $max_quantity),
			sprintf('bForceBlueprint=%s', $blueprint_chance >= 1 ? 'true' : 'false'),
			sprintf('ChanceToBeBlueprintOverride=%F', $blueprint_chance),
			sprintf('MinQuality=%F', $this->QualityTagToValue($min_quality_tag, $source->MultiplierMin())),
			sprintf('MaxQuality=%F', $this->QualityTagToValue($max_quality_tag, $source->MultiplierMax())),
			sprintf('ItemClassStrings=(%s)', implode(',', $classes)),
			sprintf('ItemsWeights=(%s)', implode(',', $relative_weights))
		);
		
		return '(' . implode(',', $keys) . ')';
	}
}

?>
