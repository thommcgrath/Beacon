<?php

use BeaconAPI\v4\{APIResponse, TemplateSelector};

function handle_request(array $context): APIResponse {
	return APIResponse::NewJSON(TemplateSelector::Search($_GET), 200);
}

?>