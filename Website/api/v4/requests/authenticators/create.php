<?php

BeaconAPI::Authorize();
	
function handle_request(array $context): void {
	$user = BeaconAPI::User();
	$user_id = $user->UserID();
	$object_data = BeaconAPI::JSONPayload();
	if (BeaconCommon::HasAllKeys($object_data, 'type', 'nickname', 'metadata') === false) {
		BeaconAPI::ReplyError('Must include type, nickname, and metadata properties.', $object_data, 400);
	}
	
	$transaction_started = false;
	try {
		$authenticator_id = $object_data['authenticator_id'] ?? BeaconCommon::GenerateUUID();
		$type = $object_data['type'];
		$nickname = $object_data['nickname'];
		$metadata = $object_data['metadata'];
		
		switch ($type) {
		case Authenticator::TYPE_TOTP:
			if (isset($metadata['secret']) === false || empty($metadata['secret'])) {
				BeaconAPI::ReplyError('For TOTP authenticators, metadata must include the secret.', $metadata, 400);
			}
			
			if (isset($metadata['setup']) === false ||  empty($metadata['setup'])) {
				$setup_id = $user->Username() . '#' . $user->Suffix() . ' (' . $authenticator_id . ')';
				$setup = 'otpauth://totp/' . urlencode('Beacon:' . $setup_id);
				$setup .= '?secret=' . urlencode($metadata['secret']);
				$setup .= '&issuer=Beacon';
				$metadata['setup'] = $setup;
			}
			
			break;
		default:
			BeaconAPI::ReplyError('Unknown authenticator type.', $object_data, 400);
			break;
		}
		
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$transaction_started = true;
		$authenticator = Authenticator::Create($authenticator_id, $user_id, $type, $nickname, $metadata);
		$user->Create2FABackupCodes(true);
		$database->Commit();
		$transaction_started = false;
		
		BeaconAPI::ReplySuccess($authenticator);
	} catch (Exception $err) {
		if ($transaction_started) {
			$database->Rollback();
			$transaction_started = false;
		}
		BeaconAPI::ReplyError($err->getMessage(), $object_data, 400);
	}
}

?>