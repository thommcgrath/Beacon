<?php

use BeaconAPI\v4\{APIResponse, Project};

function handle_request(array $context): APIResponse {
	$project_id = $context['path_parameters']['projectId'];
	$exists = Project::Exists($project_id);
	return new APIResponse($exists ? 200 : 404, null);
}

?>