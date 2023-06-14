<?php

use BeaconAPI\v4\{Application, Core, User, Response};

$requiredScopes[] = Application::kScopeUsersRead;

function handleRequest(array $context): Response {
	$identifier = $context['pathParameters']['userId'];
	$user = User::Fetch($identifier);
	if (is_null($user)) {
		return Response::NewJsonError('User not found', $identifier, 404);
	}
	
	if ($user->UserId() === Core::UserId()) {
		if (isset($_GET['deviceId']) && ($deviceId = $_GET['deviceId']) && BeaconCommon::IsUUID($deviceId)) {
			$user->PrepareSignatures($deviceId);
		}
		$userInfo = $user->jsonSerialize();
		
		$session = Core::Session();
		$privateKey = $session->PrivateKeyEncrypted();
		if (is_null($privateKey) === false) {
			$userInfo['privateKey'] = json_decode($privateKey, true);
			$userInfo['cloudKey'] = $user->CloudKey();
		}
	} else {
		// don't use the regular method that includes lots of values
		$userInfo = [
			'userId' => $user->UserId(),
			'username' => $user->Username(false),
			'usernameFull' => $user->Username(true),
			'publicKey' => $user->PublicKey()
		];
	}
	
	return Response::NewJson($userInfo, 200);
}
