<?php

namespace BeaconAPI\v4\ArkSA;
use BeaconAPI\v4\{Core, DatabaseSearchParameters};
use BeaconCommon;

class Project extends \BeaconAPI\v4\Project {
	public function jsonSerialize(): mixed {
		$json = parent::jsonSerialize();
		$json['mapMask'] = $this->MapMask();
		$json['difficulty'] = $this->DifficultyValue();
		return $json;
	}
	
	protected static function ExtendSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
			
		if (isset($filters['allMaps'])) {
			$parameters->clauses[] = '(game_specific->\'map\')::int & $' . $parameters->placeholder . ' = $' . $parameters->placeholder++;
			$parameters->values[] = $filters['allMaps'];
		} else if (isset($filters['anyMaps'])) {
			$parameters->clauses[] = '(game_specific->\'map\')::int & $' . $parameters->placeholder++ . ' != 0';
			$parameters->values[] = $filters['anyMaps'];
		}
	}
	
	public function MapMask(): int {
		return array_key_exists('map', $this->gameSpecific) ? intval($this->gameSpecific['map']) : 0;
	}
	
	public function DifficultyValue(): float {
		return array_key_exists('difficulty', $this->gameSpecific) ? floatval($this->gameSpecific['difficulty']) : 0;
		return $this->difficulty_value;
	}
	
	public function RequiredContentPacks(bool $asArray): array|string {
		if (array_key_exists('contentPacks', $this->gameSpecific)) {
			$contentPacks = $this->gameSpecific['contentPacks'];
			if ($asArray) {
				return $contentPacks;
			} else {
				return implode(',', $contentPacks);
			}
		} else {
			if ($asArray) {
				return [];
			} else {
				return '';
			}
		}
	}
	
	public function ImplementedConfigs(bool $asArray): array|string {
		if (array_key_exists('included_editors', $this->gameSpecific)) {
			$editors = $this->gameSpecific['included_editors'];
			if ($asArray) {
				return $editors;
			} else {
				return implode(',', $editors);
			}
		} else {
			if ($asArray) {
				return [];
			} else {
				return '';
			}
		}
	}
	
	protected static function AddColumnValues(array $project, array &$row_values): bool {
		if (parent::AddColumnValues($project, $row_values) === false) {
			return false;
		}
		
		$database = BeaconCommon::Database();
		
		$content_pack_ids = [];
		if (isset($project['ModSelections'])) {
			$console_safe = true;
			foreach ($project['ModSelections'] as $content_pack_id => $content_pack_enabled) {
				if ($content_pack_enabled) {
					$rows = $database->Query('SELECT content_pack_id, console_safe FROM arksa.content_packs WHERE confirmed = TRUE AND content_pack_id = $1;', $content_pack_id);
					if ($rows->RecordCount() === 1) {
						$content_pack_ids[] = $content_pack_id;
						$console_safe = $console_safe && $rows->Field('console_safe');
					}
				}
			}
		} elseif (isset($project['ConsoleModsOnly'])) {
			$console_mods_only = $project['ConsoleModsOnly'];
			$rows = $database->Query('SELECT content_pack_id FROM arksa.content_packs WHERE confirmed = TRUE AND console_safe = TRUE AND default_enabled = TRUE;');
			while (!$rows->EOF()) {
				$content_pack_ids[] = $rows->Field('content_pack_id');
				$rows->MoveNext();
			}
		} else {
			$console_safe = false;
		}
		
		$editor_names = [];
		foreach ($project['EditorNames'] as $editor_name) {
			if ($editor_name === 'Difficulty' || $editor_name === 'Metadata') {
				continue;
			}
			
			$editor_names[] = $editor_name;
		}
		$project['EditorNames'] = $editor_names;
		
		$row_values['game_specific'] = json_encode([
			'map' => isset($project['Map']) ? $project['Map'] : 4,
			'difficulty' => isset($project['DifficultyValue']) ? $project['DifficultyValue'] : 4,
			'contentPacks' => $content_pack_ids,
			'included_editors' => $project['EditorNames']
		]);
		$row_values['console_safe'] = $console_safe;
		
		return true;
	}
}

?>
