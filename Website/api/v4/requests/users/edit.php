<?php

use BeaconAPI\v4\{Response, Core, EmailVerificationCode, User};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes[] = Application::kScopeUserUpdate;
}

function handleRequest(array $context): Response {
	$identifier = $context['pathParameters']['userId'];
	$user = User::Fetch($identifier);
	if (is_null($user)) {
		return Response::NewJsonError('User not found', $identifier, 404);
	}

	if ($user->UserId() !== Core::UserId()) {
		return Response::NewJsonError('Forbidden', $identifier, 403);
	}

	try {
		$body = Core::BodyAsJson();

		$email = $body['email'] ?? null;
		if (empty($email) === false) {
			$verificationCode = $body['verificationCode'] ?? null;
			if (empty($verificationCode)) {
				return Response::NewJsonError('Missing verification code', $body, 400);
			}

			$emailVerification = EmailVerificationCode::Fetch($email, $verificationCode);
			if (is_null($emailVerification)) {
				return Response::NewJsonError('Incorrect verification code', $body, 400);
			}
		}

		$user->Edit($body);
		EmailVerificationCode::Clear($email);
		return Response::NewJson($user, 200);
	} catch (Exception $err) {
		return Response::NewJsonError($err->getMessage(), $body, 400);
	}
}

?>
