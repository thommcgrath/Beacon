<?php

BeaconAPI::Authorize();
	
function handleRequest(array $context): APIResponse {
	$user = BeaconAPI::User();
	$user_id = $user->UserID();
	$authenticator_id = $context['pathParameters']['authenticator_id'];
	$authenticator = Authenticator::GetByAuthenticatorID($authenticator_id);
	if ($authenticator && $authenticator->UserID() === $user_id) {
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$authenticator->Delete();
		if ($user->Is2FAProtected() === false) {
			$user->Clear2FABackupCodes(true);
		}
		$database->Commit();
		BeaconAPI::ReplySuccess('Authenticator was deleted.');
	} else {
		BeaconAPI::ReplyError('Authenticator not found', null, 404);
	}
}

?>