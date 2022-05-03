<?php

namespace Ark;

abstract class Project extends \BeaconAPI\Ark\Project {
	public function ResourceURL() {
		return \BeaconAPI::URL('project/' . urlencode($this->project_id) . '?name=' . urlencode($this->title));
	}
}

?>
