<?php

use BeaconAPI\v4\{Authenticator, Core, Response};

function handleRequest(array $context): Response {
	$user = Core::User();
	$userId = $user->UserId();
	$authenticatorId = $context['pathParameters']['authenticatorId'];
	$authenticator = Authenticator::Fetch($authenticatorId);
	if ($authenticator && $authenticator->UserId() === $userId) {
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$authenticator->Delete();
		if ($user->Is2FAProtected() === false) {
			$user->Clear2FABackupCodes(true);
		}
		$database->Commit();
		return Response::NewJson('Authenticator was deleted.', 200);
	} else {
		return Response::NewJsonError('Authenticator not found', null, 404);
	}
}

?>
