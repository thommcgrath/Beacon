<?php

namespace BeaconAPI\Ark;

class Project extends \BeaconAPI\Project {
	protected $map_mask = 0;
	protected $difficulty_value = 0;
	protected $mod_ids = '{}';
	protected $editors = '{}';
	
	public static function SchemaName() {
		return 'ark';
	}
	
	public static function SQLColumns() {
		$columns = parent::SQLColumns();
		if (($key = array_search('game_id', $columns)) !== false) {
			unset($columns[$key]);
		}
		$columns[] = "'Ark' AS game_id";
		$columns[] = 'map';
		$columns[] = 'difficulty';
		$columns[] = 'mods';
		$columns[] = 'included_editors';
		return $columns;
	}
	
	protected static function GetFromResult(\BeaconRecordSet $results) {
		$project = parent::GetFromResult($results);
		$project->map_mask = intval($results->Field('map'));
		$project->difficulty_value = floatval($results->Field('difficulty'));
		$project->mod_ids = is_null($results->Field('mods')) ? '{}' : $results->Field('mods');
		$project->editors = is_null($results->Field('included_editors')) ? '{}' : $results->Field('included_editors');
		return $project;
	}
	
	public function jsonSerialize() {
		$json = parent::jsonSerialize();
		if (\BeaconAPI::GetAPIVersion() < 3) {
			$project_id = $json['project_id'];
			unset($json['project_id']);
			unset($json['game_id']);
			$json['document_id'] = $project_id;
		}
		$json['map_mask'] = $this->map_mask;
		$json['difficulty_value'] = $this->difficulty_value;
		return $json;
	}
	
	public function MapMask() {
		return $this->map_mask;
	}
	
	public function DifficultyValue() {
		return $this->difficulty_value;
	}
	
	public function RequiredMods(bool $as_array) {
		if ($as_array) {
			if ($this->mod_ids === '{}') {
				return array();
			} else {
				return explode(',', substr($this->mod_ids, 1, strlen($this->mod_ids) - 2));
			}
		} else {
			return $this->mod_ids;
		}
	}
	
	public function ImplementedConfigs(bool $as_array) {
		if ($as_array) {
			if ($this->editors === '{}') {
				return array();
			} else {
				return explode(',', substr($this->editors, 1, strlen($this->editors) - 2));
			}
		} else {
			return $this->editors;
		}
	}
	
	protected static function HookHandleSearchKey(string $column, $value, array &$clauses, array &$values, int &$next_placeholder) {
		switch ($column) {
		case 'map':
		case 'map_mask':
		case 'map_all':
			$values[] = intval($value);
			$clauses[] = 'map & $' . $next_placeholder . ' = $' . $next_placeholder++;
			break;
		case 'map_any':
			$values[] = intval($value);
			$clauses[] = 'map & $' . $next_placeholder++ . ' != 0';
			break;
		}
	}
	
	protected static function HookValidateMultipart(array &$required_vars, string &$reason) {
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
		
		$idx = array_search('Difficulty', $project['EditorNames']);
		if ($idx !== false) {
			unset($project['EditorNames'][$idx]);
		}
		$idx = array_search('Metadata', $project['EditorNames']);
		if ($idx !== false) {
			unset($project['EditorNames'][$idx]);
		}
		
		$row_values['difficulty'] = isset($project['DifficultyValue']) ? $project['DifficultyValue'] : 4;
		$row_values['map'] = isset($project['Map']) ? $project['Map'] : 4;
		$row_values['console_safe'] = $console_safe;
		$row_values['mods'] = '{' . implode(',', $mod_ids) . '}';
		$row_values['included_editors'] = '{' . implode(',', $document['EditorNames']) . '}';
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
	
	public function ResourceURL() {
		if (\BeaconAPI::GetAPIVersion() >= 3) {
			return \BeaconAPI::URL('/ark/project/' . urlencode($this->project_id) . '?name=' . urlencode($this->title));
		} else {
			return \BeaconAPI::URL('/document/' . urlencode($this->project_id) . '?name=' . urlencode($this->title));
		}
	}
}

?>
