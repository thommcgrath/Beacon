<?php

use BeaconAPI\v4\{APIResponse, Core, Project, User};
Core::Authorize();
	
function handleRequest(array $context): APIResponse {
	if (Core::ContentType() !== 'application/x-beacon-project') {
		return APIResponse::NewJSONError('Unsupported media type', 'Send application/x-beacon-project', 415);
	}

	return APIResponse::NewJSONError('Not implemented yet', $project_id, 500);
}

?>
