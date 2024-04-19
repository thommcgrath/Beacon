<?php

use BeaconAPI\v4\{Authenticator, Core, Response};

function handleRequest(array $context): Response {
	$user = Core::User();
	$userId = $user->UserId();
	$objectData = Core::BodyAsJson();
	if (BeaconCommon::HasAllKeys($objectData, 'type', 'nickname', 'metadata', 'verificationCode') === false) {
		return Response::NewJsonError('Must include type, nickname, metadata, verificationCode properties.', $objectData, 400);
	}

	$transactionStarted = false;
	try {
		$authenticatorId = $objectData['authenticatorId'] ?? BeaconCommon::GenerateUUID();
		$type = $objectData['type'];
		$nickname = $objectData['nickname'];
		$metadata = $objectData['metadata'];

		switch ($type) {
		case Authenticator::TYPE_TOTP:
			if (isset($metadata['secret']) === false || empty($metadata['secret'])) {
				BeaconAPI::ReplyError('For TOTP authenticators, metadata must include the secret.', $metadata, 400);
			}

			if (isset($metadata['setup']) === false ||  empty($metadata['setup'])) {
				$setupId = $user->Username() . '#' . $user->Suffix() . ' (' . $authenticatorId . ')';
				$setup = 'otpauth://totp/' . urlencode('Beacon:' . $setupId);
				$setup .= '?secret=' . urlencode($metadata['secret']);
				$setup .= '&issuer=Beacon';
				$metadata['setup'] = $setup;
			}

			break;
		default:
			return Response::NewJsonError('Unknown authenticator type.', $objectData, 400);
			break;
		}

		$objectData['userId'] = $userId;
		$objectData['metadata'] = json_encode($objectData['metadata']);
		$objectData['dateAdded'] = time();

		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$transactionStarted = true;
		$authenticator = Authenticator::Create($objectData);
		if ($authenticator->TestCode($objectData['verificationCode']) === false) {
			$database->Rollback();
			return Response::NewJsonError('Incorrect verification code.', $objectData, 400);
		}
		$user->Create2FABackupCodes(true);
		$database->Commit();
		$transactionStarted = false;

		return Response::NewJson($authenticator, 201);
	} catch (Exception $err) {
		if ($transactionStarted) {
			$database->Rollback();
			$transactionStarted = false;
		}
		return Response::NewJsonError($err->getMessage(), $objectData, 400);
	}
}

?>
