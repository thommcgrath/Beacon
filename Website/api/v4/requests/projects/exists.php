<?php

use BeaconAPI\v4\{APIResponse, Project};

function handleRequest(array $context): APIResponse {
	$project_id = $context['pathParameters']['projectId'];
	$exists = Project::Exists($project_id);
	return new APIResponse($exists ? 200 : 404, null);
}

?>