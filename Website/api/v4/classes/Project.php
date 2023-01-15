<?php

namespace BeaconAPI\v4;
use BeaconAPI\Core;

abstract class Project extends \BeaconAPI\Project {
	public function ResourceURL() {
		return Core::URL('projects/' . urlencode($this->project_id) . '?name=' . urlencode($this->title));
	}
}

?>
