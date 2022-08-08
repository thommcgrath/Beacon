<?php

namespace BeaconAPI\Ark;

class Project extends \BeaconAPI\Project {
	public function MapMask(): int {
		return array_key_exists('map', $this->game_specific) ? intval($this->game_specific['map']) : 0;
	}
	
	public function DifficultyValue(): float {
		return array_key_exists('difficulty', $this->game_specific) ? floatval($this->game_specific['difficulty']) : 0;
		return $this->difficulty_value;
	}
	
	public function RequiredMods(bool $as_array): array|string {
		if (array_key_exists('mods', $this->game_specific)) {
			$mods = $this->game_specific['mods'];
			if ($as_array) {
				return $mods;
			} else {
				return implode(',', $mods);
			}
		} else {
			if ($as_array) {
				return [];
			} else {
				return '';
			}
		}
	}
	
	public function ImplementedConfigs(bool $as_array): array|string {
		if (array_key_exists('included_editors', $this->game_specific)) {
			$editors = $this->game_specific['included_editors'];
			if ($as_array) {
				return $editors;
			} else {
				return implode(',', $editors);
			}
		} else {
			if ($as_array) {
				return [];
			} else {
				return '';
			}
		}
	}
	
	protected static function HookHandleSearchKey(string $column, $value, array &$clauses, array &$values, int &$next_placeholder) {
		switch ($column) {
		case 'map':
		case 'map_mask':
		case 'map_all':
			$values[] = intval($value);
			$clauses[] = '(game_specific->\'map\')::int & $' . $next_placeholder . ' = $' . $next_placeholder++;
			break;
		case 'map_any':
			$values[] = intval($value);
			$clauses[] = '(game_specific->\'map\')::int & $' . $next_placeholder++ . ' != 0';
			break;
		}
	}
	
	protected static function HookValidateMultipart(array &$required_vars, string &$reason) {
		parent::HookValidateMultipart($required_vars, $reason);
		
		$required_vars[] = 'difficulty';
		$required_vars[] = 'editors';
		$required_vars[] = 'map';
		$required_vars[] = 'mods';
		
		return true;
	}
	
	protected static function HookMultipartAddProjectValues(array &$project, string &$reason) {
		$project['Map'] = intval($_POST['map']);
		$project['DifficultyValue'] = floatval($_POST['difficulty']);
		$project['EditorNames'] = array_unique(explode(',', $_POST['editors']));
		sort($project['EditorNames']);
		
		$mods_members = explode(',', $_POST['mods']);
		$mods = [];
		foreach ($mods_members as $mod_id) {
			if (\BeaconCommon::IsUUID($mod_id) === false) {
				$reason = 'Mod UUID `' . $mod_id . '` is not a v4 UUID.';
				return false;
			}
			$mods[$mod_id] = true;
		}
		$project['ModSelections'] = $mods;
		
		return true;
	}
	
	public static function HookRowSaveData(array $project, array &$row_values) {
		$database = \BeaconCommon::Database();
		
		$mod_ids = [];
		if (isset($project['ModSelections'])) {
			$console_safe = true;
			foreach ($project['ModSelections'] as $mod_id => $mod_enabled) {
				if ($mod_enabled) {
					$rows = $database->Query('SELECT mod_id, console_safe FROM ark.mods WHERE confirmed = TRUE AND mod_id = $1;', $mod_id);
					if ($rows->RecordCount() === 1) {
						$mod_ids[] = $mod_id;
						$console_safe = $console_safe && $rows->Field('console_safe');
					}
				}
			}
		} elseif (isset($project['ConsoleModsOnly'])) {
			$console_mods_only = $project['ConsoleModsOnly'];
			$rows = $database->Query('SELECT mod_id FROM ark.mods WHERE confirmed = TRUE AND console_safe = TRUE AND default_enabled = TRUE;');
			while (!$rows->EOF()) {
				$mod_ids[] = $rows->Field('mod_id');
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
			'mods' => $mod_ids,
			'included_editors' => $project['EditorNames']
		]);
		$row_values['console_safe'] = $console_safe;
	}
	
	public static function SaveFromContent(string $project_id, \BeaconUser $user, $file_content, string &$reason) {
		if (empty($file_content)) {
			$reason = 'File is empty';
			return false;
		}
		
		if (\BeaconCommon::IsCompressed($file_content)) {
			$file_content_compressed = $file_content;
			$file_content = gzdecode($file_content_compressed);
		} else {
			$file_content_compressed = null;
		}
		
		try {
			$iter = \JsonMachine\JsonMachine::fromString($file_content, '', new \JsonMachine\JsonDecoder\PassThruDecoder);
		} catch (\Exception $err) {
			$reason = 'Unable to parse JSON.';
			return false;
		}
		
		$project = ['EditorNames' => []];
		foreach ($iter as $key => $value) {
			switch ($key) {
			case 'Version':
			case 'Identifier':
			case 'EncryptionKeys':
			case 'Map':
			case 'Description':
			case 'Title':
			case 'DifficultyValue':
			case 'ModSelections':
			case 'ConsoleModsOnly';
				$project[$key] = json_decode($value, true);
				break;
			case 'Configs':
				$configs_iterator = \JsonMachine\JsonMachine::fromString($value, '', new \JsonMachine\JsonDecoder\PassThruDecoder);
				foreach ($configs_iterator as $config_name => $config_contents) {
					if ($config_name === 'Metadata') {
						$config_parsed = json_decode($config_contents, true);
						$project['Title'] = $config_parsed['Title'];
						$project['Description'] = $config_parsed['Description'];
					} elseif ($config_name === 'Difficulty') {
						$config_parsed = json_decode($config_contents, true);
						$project['DifficultyValue'] = $config_parsed['MaxDinoLevel'] / 30;
					} else {
						$project['EditorNames'][] = $config_name;
					}
				}
				break;
			case 'Config Sets':
				$sets_iterator = \JsonMachine\JsonMachine::fromString($value, '', new \JsonMachine\JsonDecoder\PassThruDecoder);
				foreach ($sets_iterator as $set_name => $set_contents) {
					$configs_iterator = \JsonMachine\JsonMachine::fromString($set_contents, '', new \JsonMachine\JsonDecoder\PassThruDecoder);
					foreach ($configs_iterator as $config_name => $config_contents) {
						if ($set_name === 'Base' && $config_name === 'Metadata') {
							$config_parsed = json_decode($config_contents, true);
							$project['Title'] = $config_parsed['Title'];
							$project['Description'] = $config_parsed['Description'];
						} elseif ($set_name === 'Base' && $config_name === 'Difficulty') {
							$config_parsed = json_decode($config_contents, true);
							$project['DifficultyValue'] = $config_parsed['MaxDinoLevel'] / 30;
						} else {
							$project['EditorNames'][] = $config_name;
						}
					}
				}
				break;
			case 'LootSources':
				$project['EditorNames'][] = 'LootDrops';
				break;
			}
		}
		$project['EditorNames'] = array_unique($project['EditorNames']);
		sort($project['EditorNames']);
		
		// Catch some common errors
		if (!\BeaconCommon::HasAllKeys($project, 'Version', 'Identifier')) {
			$reason = 'Not all keys are present.';
			return false;
		}
		if (empty($project_id) == false && strtolower($project['Identifier']) !== strtolower($project_id)) {
			$reason = 'Document UUID of ' . strtolower($project['Identifier']) . ' in content does not match the resource UUID of ' . strtolower($project_id) . '.';
			return false;
		}
		
		if (is_null($file_content_compressed)) {
			$file_content_compressed = gzencode($file_content);
		}
		
		return self::SaveFromArray($project, $user, $file_content_compressed, $reason);
	}
}

?>
