<?php

use BeaconAPI\v4\{APIResponse, Template};

function handleRequest(array $context): APIResponse {
	$templateId = $context['pathParameters']['templateId'];
	$template = Template::Fetch($templateId);
	if (is_null($template)) {
		return APIResponse::NewJSONError('Template not found', null, 404);
	} else {
		return APIResponse::NewJSON($template, 200);
	}
}

?>