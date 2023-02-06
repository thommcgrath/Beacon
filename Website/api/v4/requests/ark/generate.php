<?php

BeaconAPI::Authorize(true);

function handleRequest(array $context): Response {
	$project_id = $context['pathParameters']['project_id'];
	if (\BeaconCommon::IsUUID($project_id) === false) {
		BeaconAPI::ReplyError('Request a specific project', null, 400);
	}
	
	$projects = Ark\Project::GetByDocumentID($project_id);
	if (count($projects) != 1) {
		BeaconAPI::ReplyError('Project not found', null, 404);
	}
	$project = $projects[0];
	
	if ($project->IsPublic() && $project->UserID() !== BeaconAPI::UserID()) {
		header('WWW-Authenticate: Basic realm="Beacon API"');
		BeaconAPI::ReplyError('Unauthorized', null, 401);
	}
	
	$generator = new Ark\Generator($project);
	if (isset($_REQUEST['quality_scale'])) {
		$generator->SetQualityScale(floatval($_REQUEST['quality_scale']));
	}
	if (isset($_REQUEST['difficulty_value'])) {
		$generator->SetDifficultyValue(floatval($_REQUEST['difficulty_value']));
	}
	if (isset($_REQUEST['map_mask'])) {
		$generator->SetMapMask(intval($_REQUEST['map_mask']));
	}
	
	$original_ini = '';
	if ($context['routeKey'] === 'POST /ark/generate/{project_id}') {
		if (BeaconAPI::ContentType() === 'application/x-www-form-urlencoded' || BeaconAPI::ContentType() === 'multipart/form-data') {
			if (isset($_POST['content'])) {
				$original_ini = $_POST['content'];
			}
		} else {
			$original_ini = BeaconAPI::Body();
		}
	}
	
	$output = $generator->Generate($original_ini);
	
	http_response_code(200);
	header('Content-Type: text/plain');
	header('Content-MD5: ' . md5($output));
	ob_clean();
	echo $output;
}

