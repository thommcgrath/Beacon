<?php

use BeaconAPI\v4\{Authenticator, Core, Response, User};

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

		if ($user->Is2FAProtected()) {
			$authCode = $objectData['password'] ?? '';
			if ($user->Verify2FACode($authCode, true, User::VerifyWithAuthenticators) === false) {
				return Response::NewJsonError(message: 'The provided code is not correct for any of your authenticators. Since you already have an authenticator on your account, you must provide a code from a different authenticator to add a new one.', code: 'invalidAuthCode', httpStatus: 403);
			}
		} else {
			$accountPassword = $objectData['password'] ?? '';
			if ($user->TestPassword($accountPassword) === false) {
				return Response::NewJsonError(message: 'Your password is incorrect.', code: 'incorrectPassword', httpStatus: 403);
			}
		}

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
		$user->Create2FABackupCodes();
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
