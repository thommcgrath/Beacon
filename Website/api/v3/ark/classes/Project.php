<?php

namespace Ark;

class Project extends \BeaconAPI\Ark\Project {
	public function jsonSerialize() {
		return [
			'project_id' => $this->project_id,
			'game_id' => $this->game_id,
			'user_id' => $this->user_id,
			'owner_id' => $this->owner_id,
			'name' => $this->title,
			'description' => $this->description,
			'revision' => $this->revision,
			'download_count' => $this->download_count,
			'last_updated' => $this->last_update->format('Y-m-d H:i:sO'),
			'console_safe' => $this->console_safe,
			'map_mask' => $this->MapMask(),
			'difficulty' => $this->DifficultyValue(),
			'resource_url' => $this->ResourceURL()
		];
	}
	
	public function ResourceURL() {
		return \BeaconAPI::URL('project/' . urlencode($this->project_id) . '?name=' . urlencode($this->title));
	}
}

?>
