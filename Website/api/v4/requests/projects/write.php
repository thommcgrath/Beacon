<?php

use BeaconAPI\v4\{Response, Core, Project, User};
Core::Authorize();
	
function handleRequest(array $context): Response {
	if (Core::ContentType() !== 'application/x-beacon-project') {
		return Response::NewJsonError('Unsupported media type', 'Send application/x-beacon-project', 415);
	}

	return Response::NewJsonError('Not implemented yet', $project_id, 500);
}

?>
