<?php

BeaconAPI::Authorize();
	
function handleRequest(array $context): APIResponse {
	$user_id = BeaconAPI::UserID();
	$authenticator_id = $context['pathParameters']['authenticator_id'];
	$authenticator = Authenticator::GetByAuthenticatorID($authenticator_id);
	if ($authenticator && $authenticator->UserID() === $user_id) {
		$object_data = BeaconAPI::JSONPayload();
		
		if (isset($object_data['nickname'])) {
			$authenticator->SetNickname($object_data['nickname']);
		}
		
		$authenticator->Save();
		BeaconAPI::ReplySuccess($authenticator);
	} else {
		BeaconAPI::ReplyError('Authenticator not found', null, 404);
	}
}

?>