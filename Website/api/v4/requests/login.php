<?php

use BeaconAPI\v4\{Application, ApplicationAuthFlow, Core, Response, Session};

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
		
		$flow = null;
		try {
			$redirect_uri = $_GET['redirect_uri'];
			$scopes = explode(' ', $_GET['scope']);
			$state = $_GET['state'];
			$codeVerifierHash = $_GET['code_challenge'];
			$codeVerifierMethod = $_GET['code_challenge_method'];
			
			$flow = ApplicationAuthFlow::Create($application, $scopes, $redirect_uri, $state, $codeVerifierHash, $codeVerifierMethod);
		} catch (Exception $err) {
		}
		if (is_null($flow)) {
			return Response::NewJsonError('Invalid scope or redirect_uri', null, 400);
		}
		
		$loginUrl = BeaconCommon::AbsoluteUrl('/account/login?flow_id=' . urlencode($flow->FlowId()));
		return Response::NewRedirect($loginUrl);
	case 'POST /login':
		if (Core::IsJsonContentType()) {
			$obj = Core::BodyAsJson();
		} else {
			$obj = $_POST;
		}
		$grantType = $obj['grant_type'] ?? null;
		$clientId = $obj['client_id'] ?? null;
		$clientSecret = $obj['client_secret'] ?? null;	
		
		if (is_null($grantType)) {
			return Response::NewJsonError('Invalid grant type', ['code' => 'INVALID_GRANT'], 400);
		}
		
		switch ($grantType) {
		case 'authorization_code':
			$code = $obj['code'] ?? null;
			$redirectUri = $obj['redirect_uri'] ?? null;
			$codeVerifier = $obj['code_verifier'] ?? null;
			
			if (is_null($grantType) || is_null($code) || is_null($clientId) || is_null($redirectUri)) {
				return Response::NewJsonError('Missing parameters', ['code' => 'INVALID_GRANT'], 400);
			}
			
			$session = ApplicationAuthFlow::Redeem($clientId, $clientSecret, $redirectUri, $code, $codeVerifier);
			if (is_null($session)) {
				return Response::NewJsonError('Invalid code', ['code' => 'INVALID_CODE'], 400);
			}
			Core::SetSession($session);
			return Response::NewJson($session->OAuthResponse(), 201);
		case 'refresh_token':
			$refreshToken = $obj['refresh_token'] ?? null;
			$scopes = explode(' ', $obj['scope']) ?? null;
			$session = Session::Fetch($refreshToken);
			if (is_null($session) || $session->IsRefreshTokenExpired()) {
				return Response::NewJsonError('Unauthorized', ['code' => 'EXPIRED'], 403);
			}
			$app = $session->Application();
			if (is_null($scopes) === false) {
				if ($session->HasScopes($scopes) === false) {
					return Response::NewJsonError('Invalid scopes', ['code' => 'INVALID_SCOPES'], 400);
				}
			} else {
				$scopes = $session->Scopes();
			}
			if ($app->IsConfidential() && (is_null($clientId) || is_null($clientSecret) || $app->ApplicationId() !== $clientId || $app->Secret() !== $clientSecret)) {
				return Response::NewJsonError('Invalid client', ['code' => 'INVALID_CLIENT'], 400);
			}
			$newSession = $session->Renew(true);
			Core::SetSession($newSession);
			return Response::NewJson($newSession->OAuthResponse(), 201);
			break;
		default:
			return Response::NewJsonError('Invalid grant type', ['code' => 'INVALID_GRANT'], 400);
		}
	default:
		return Response::NewJsonError('Unknown route', null, 500);
	}
}

?>
