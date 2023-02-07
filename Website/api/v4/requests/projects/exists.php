<?php

use BeaconAPI\v4\{Project, Response};

function handleRequest(array $context): Response {
	$projectId = $context['pathParameters']['projectId'];
	$exists = is_null(Project::Fetch($projectId)) === false;
	return new Response($exists ? 200 : 404, '');
}

?>