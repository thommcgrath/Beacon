<?php

use BeaconAPI\v4\{Application, APIResponse, Core};

function handle_request(array $context): APIResponse {
	if (BeaconCommon::HasAllKeys($_GET, 'client_id', 'redirect_uri', 'state', 'response_type', 'scope') === false) {
		return APIResponse::NewJsonError('Missing parameters', null, 400);
	}
	
	if ($_GET['response_type'] !== 'code') {
		return APIResponse::NewJsonError('Response type should be code', null, 400);
	}
	
	$application = Application::Fetch($_GET['client_id']);
	if (is_null($application)) {
		return APIResponse::NewJsonError('Invalid client id', null, 400);
	}
	
	$redirect_uri = $_GET['redirect_uri'];
	$scopes = explode(' ', $_GET['scope']);
	$state = $_GET['state'];
	
	$loginId = $application->BeginLogin($scopes, $redirect_uri, $state);
	if (is_null($loginId)) {
		return APIResponse::NewJsonError('Invalid scope or redirect_uri', null, 400);
	}
	
	$loginUrl = BeaconCommon::AbsoluteUrl('/account/login?flowId=' . urlencode($loginId));
	return APIResponse::NewRedirect($loginUrl);
}

?>
