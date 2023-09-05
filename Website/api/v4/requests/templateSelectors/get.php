<?php

use BeaconAPI\v4\{Response, TemplateSelector};

function handleRequest(array $context): Response {
	$templateSelectorId = $context['pathParameters']['templateSelectorId'];
	$templateSelector = TemplateSelector::Fetch($templateSelectorId);
	if (is_null($templateSelector)) {
		return Response::NewJsonError('Template selector not found', null, 404);
	} else {
		return Response::NewJson($templateSelector, 200);
	}
}

?>