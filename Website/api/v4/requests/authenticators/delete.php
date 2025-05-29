<?php

use BeaconAPI\v4\{Application, Authenticator, Core, Response};

function handleRequest(array $context): Response {
	$user = Core::User();
	$body = Core::BodyAsJson();
	$authenticatorId = $body['authenticatorId'];
	$authCode = $body['authCode'];

	$authenticator = Authenticator::Fetch($authenticatorId);
	if ($authenticator && $authenticator->UserId() === $user->UserId()) {
		if ($authenticator->TestCode($authCode) === false) {
			return Response::NewJsonError(message: 'The provided code is not correct for this authenticator.', code: 'invalidAuthCode', httpStatus: 403);
		}

		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$authenticator->Delete();
		if ($user->Is2FAProtected() === false) {
			$apps = Application::Search(['userId' => $user->UserId()], true);
			if (count($apps) > 0) {
				$database->Rollback();
				return Response::NewJsonError(message: 'One or more applications are registered to this account. Two step authentication cannot be disabled.', code: 'requiredByApps', httpStatus: 400);
			}
			$user->Clear2FABackupCodes(true);
		}
		$database->Commit();
		return Response::NewJson('Authenticator was deleted.', 200);
	} else {
		return Response::NewJsonError('Authenticator not found', null, 404);
	}
}

?>
