<?php

function handle_request(array $context): void {
	$project_id = $context['path_parameters']['project_id'];
	$database = BeaconCommon::Database();
	$results = $database->Query('SELECT project_id, user_id FROM ' . \BeaconAPI\Project::SchemaName() . '.' . \BeaconAPI\Project::TableName() . ' WHERE project_id = $1 AND deleted = FALSE;', $project_id);
	if ($results->RecordCount() == 1) {
		http_response_code(200);
	} else {
		http_response_code(404);
	}
}

?>