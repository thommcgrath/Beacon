<?php

use BeaconAPI\v4\{APIResponse, TemplateSelector};

function handle_request(array $context): APIResponse {
	$templateSelectorId = $context['path_parameters']['templateSelectorId'];
	$templateSelector = TemplateSelector::Fetch($templateSelectorId);
	if (is_null($templateSelector)) {
		return APIResponse::NewJSONError('Template selector not found', null, 404);
	} else {
		return APIResponse::NewJSON($templateSelector, 200);
	}
}

?>