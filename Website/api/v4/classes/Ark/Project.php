<?php

namespace BeaconAPI\v4\Ark;
use BeaconAPI\v4\{Core};

class Project extends \BeaconAPI\v4\Project {
	public function jsonSerialize(): mixed {
		$json = parent::jsonSerialize();
		$json['map_mask'] = $this->MapMask();
		$json['difficulty'] = $this->DifficultyValue();
		return $json;
	}
	
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
	
	public function ResourceURL() {
		return Core::URL('projects/' . urlencode($this->project_id) . '?name=' . urlencode($this->title));
	}
	
	protected static function HookValidateMultipart(array &$required_vars, string &$reason) {
		parent::HookValidateMultipart($required_vars, $reason);
		$required_vars[] = 'game_id';
		return true;
	}
	
	protected static function HookMultipartAddProjectValues(array &$project, string &$reason) {
		parent::HookMultipartAddProjectValues($project, $reason);
		$project['GameID'] = $_POST['game_id'];
		return true;
	}
}

?>
