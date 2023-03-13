<?php

use BeaconAPI\v4\{Application, ApplicationAuthFlow, Response, Core};

$requiredScopes = [];
$authScheme = Core::kAuthSchemeNone;

function handleRequest(array $context): Response {
	switch ($context['routeKey']) {
	case 'GET /login':
		if (BeaconCommon::HasAllKeys($_GET, 'client_id', 'redirect_uri', 'state', 'response_type', 'scope', 'code_challenge', 'code_challenge_method') === false) {
			return Response::NewJsonError('Missing parameters', null, 400);
		}
		
		if ($_GET['response_type'] !== 'code') {
			return Response::NewJsonError('Response type should be code', null, 400);
		}
		if ($_GET['code_challenge_method'] !== 'S256') {
			return Response::NewJsonError('This API does not support the supplied code challenge method', null, 400);
		}
		if (strlen($_GET['code_challenge']) !== 43) {
			return Response::NewJsonError('The code challenge should be exactly 43 characters when Base64URL encoded', null, 400);
		}
		
		$application = Application::Fetch($_GET['client_id']);
		if (is_null($application)) {
			return Response::NewJsonError('Invalid client id', null, 400);
		}
		
		$redirect_uri = $_GET['redirect_uri'];
		$scopes = explode(' ', $_GET['scope']);
		$state = $_GET['state'];
		$codeVerifierHash = $_GET['code_challenge'];
		$codeVerifierMethod = $_GET['code_challenge_method'];
		
		$flow = null;
		try {
			$flow = ApplicationAuthFlow::Create($application, $scopes, $redirect_uri, $state, $codeVerifierHash, $codeVerifierMethod);
		} catch (Exception $err) {
		}
		if (is_null($flow)) {
			return Response::NewJsonError('Invalid scope or redirect_uri', null, 400);
		}
		
		$loginUrl = BeaconCommon::AbsoluteUrl('/account/login?flow_id=' . urlencode($flow->FlowId()));
		return Response::NewRedirect($loginUrl);
	case 'POST /login':
		$obj = Core::BodyAsJson();
		if ($obj['grant_type'] !== 'authorization_code') {
			return Response::NewJsonError('Invalid grant type', ['code' => 'INVALID_GRANT'], 400);
		}
		$session = ApplicationAuthFlow::Redeem($obj['client_id'] ?? '', $obj['client_secret'] ?? null, $obj['redirect_uri'] ?? '', $obj['code'] ?? '', $obj['code_verifier'] ?? '');
		if (is_null($session)) {
			return Response::NewJsonError('Invalid code', ['code' => 'INVALID_CODE'], 400);
		}
		Core::SetSession($session);
		return Response::NewJson($session, 201);
	default:
		return Response::NewJsonError('Unknown route', null, 500);
	}
}

?>
