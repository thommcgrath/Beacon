<?php

use BeaconAPI\v4\{Response, Project};

function handleRequest(array $context): Response {
	$project_id = $context['pathParameters']['projectId'];
	$exists = Project::Exists($project_id);
	return new Response($exists ? 200 : 404, null);
}

?>