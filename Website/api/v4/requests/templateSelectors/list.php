<?php

use BeaconAPI\v4\{APIResponse, TemplateSelector};

function handleRequest(array $context): APIResponse {
	return APIResponse::NewJSON(TemplateSelector::Search($_GET), 200);
}

?>