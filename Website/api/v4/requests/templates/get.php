<?php

use BeaconAPI\v4\{Response, Template};

function handleRequest(array $context): Response {
	$templateId = $context['pathParameters']['templateId'];
	$template = Template::Fetch($templateId);
	if (is_null($template)) {
		return Response::NewJsonError('Template not found', null, 404);
	} else {
		return Response::NewJson($template, 200);
	}
}

?>