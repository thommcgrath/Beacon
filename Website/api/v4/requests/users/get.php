<?php

use BeaconAPI\v4\{Application, Core, User, Response};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes[] = Application::kScopeUsersRead;
}

function handleRequest(array $context): Response {
	$identifier = $context['pathParameters']['userId'];
	$user = User::Fetch($identifier);
	if (is_null($user)) {
		return Response::NewJsonError('User not found', $identifier, 404);
	}

	if ($user->UserId() === Core::UserId()) {
		$requiredPolicies = explode(',', $_GET['requiredPolicies'] ?? '');
		if (count($requiredPolicies) > 0) {
			$returnUrl = $_GET['return'] ?? Core::Application()->Website();
			$database = BeaconCommon::Database();
			foreach ($requiredPolicies as $policyName) {
				$policy = $database->Query('SELECT policies.policy_id, MAX(policies.current_revision) AS current_revision, COALESCE(MAX(revision_number), 0) AS signed_revision FROM public.policies LEFT JOIN public.policy_signatures ON (policies.policy_id = policy_signatures.policy_id AND policy_signatures.user_id = $1) WHERE policies.lookup_key = $2 GROUP BY policies.policy_id;', $user->UserId(), $policyName);
				if ($policy->RecordCount() === 1 && intval($policy->Field('current_revision')) > intval($policy->Field('signed_revision'))) {
					// fail, need to start a signature request
					$database->BeginTransaction();
					$signingRequest = $database->Query('INSERT INTO public.policy_signing_requests (policy_id, user_id, return_url, challenge) VALUES ($1, $2, $3, $4) ON CONFLICT (policy_id, user_id) DO UPDATE SET expiration = DEFAULT, return_url = EXCLUDED.return_url RETURNING policy_signing_request_id;', $policy->Field('policy_id'), $user->UserId(), $returnUrl, BeaconUUID::v4());
					$database->Commit();
					return Response::NewJsonError(message: 'Policy signature required', httpStatus: 412, code: 'policyRequired', details: [
						'policySigningRequestId' => $signingRequest->Field('policy_signing_request_id'),
						'url' => BeaconCommon::AbsoluteUrl('/policies/' . urlencode($signingRequest->Field('policy_signing_request_id'))),
					]);
				}
			}
		}

		if (isset($_GET['deviceId']) && ($deviceId = $_GET['deviceId']) && BeaconCommon::IsUUID($deviceId)) {
			$user->PrepareSignatures($deviceId);
		}
		$userInfo = $user->jsonSerialize();

		$session = Core::Session();
		$privateKey = $session->PrivateKeyEncrypted();
		if (is_null($privateKey) === false) {
			$userInfo['privateKey'] = json_decode($privateKey, true);
		}
		$userInfo['cloudKey'] = base64_encode(hex2bin($user->CloudKey()));
	} else {
		// don't use the regular method that includes lots of values
		$userInfo = [
			'userId' => $user->UserId(),
			'username' => $user->Username(false),
			'usernameFull' => $user->Username(true),
			'isAnonymous' => $user->IsAnonymous(),
			'publicKey' => $user->PublicKey()
		];
	}

	return Response::NewJson($userInfo, 200);
}
