<?php

// These challenges are used for signing in with a signature, but Beacon never
// makes a request for a challenge. That could be a bug, but this feature looks
// to be unused at the moment.

use BeaconAPI\v4\{Application, Response, BatchResponse, Core, Project, User};

$requiredScopes[] = Application::kScopeUsersUpdate;
$requiredScopes[] = Application::kScopeUsersDelete;

function handleRequest(array $context): Response {
	$identifier = $context['pathParameters']['userId'];
	$authenticatedUser = User::Fetch($identifier);
	if (is_null($authenticatedUser)) {
		return Response::NewJsonError('User not found', $identifier, 404);
	}

	$body = Core::BodyAsJson();
	if (BeaconCommon::IsAssoc($body)) {
		$anonymousUsers = [$body];
		$multi = false;
	} else {
		$anonymousUsers = $body;
		$multi = true;
	}

	$batch = new BatchResponse('userId');
	$database = BeaconCommon::Database();
	foreach ($anonymousUsers as $anonymousUser) {
		$response = MergeUser($authenticatedUser, $anonymousUser);
		$batch->AddResponse($anonymousUser['userId'] ?? $anonymousUser['user_id'] ?? '', $response);
	}
	return $batch;
}

// Returns an Response
function MergeUser(User $authenticatedUser, array $anonymousUser): Response {
	if (BeaconCommon::HasAllKeys($anonymousUser, 'userId', 'privateKey') === false) {
		return Response::NewJsonError('Must include userId and privateKey properties.', $anonymousUser, 400);
	}

	$userId = $anonymousUser['userId'];
	$privateKey = $anonymousUser['privateKey'];
	$user = User::Fetch($userId);
	if (is_null($user)) {
		return Response::NewJsonError('User not found.', $anonymousUser, 404);
	}
	if ($user->IsAnonymous() === false) {
		return Response::NewJsonError('User is not anonymous.', $anonymousUser, 403);
	}

	// To confirm ownership, we're going to try to encrypt something with the user's public key and decrypt it with the private
	$privateKeyPem = null;
	$publicKeyPem = null;
	try {
		$privateKeyPem = BeaconEncryption::PrivateKeyToPEM($privateKey); // Will do nothing if already pem-encoded
		$publicKeyPem = BeaconEncryption::PublicKeyToPEM($user->PublicKey());
		$testValue = BeaconCommon::GenerateUUID();
		$encrypted = BeaconEncryption::RSAEncrypt($publicKeyPem, $testValue);
		$decrypted = BeaconEncryption::RSADecrypt($privateKeyPem, $encrypted);
		if ($decrypted !== $testValue) {
			return Response::NewJsonError('Could not confirm ownership of user.', 'Test value did not match', 400);
		}
	} catch (Exception $err) {
		return Response::NewJsonError('Could not confirm ownership of user.', $err->getMessage(), 400);
	}

	$authenticatedUserId = $authenticatedUser->UserId();
	$singleTables = ['public.user_backup_codes', 'public.user_challenges'];
	$multiTables = ['public.affiliate_links', 'public.applications', 'public.exception_comments', 'public.exception_users', 'public.gift_code_log', 'public.trusted_devices', 'public.user_authenticators'];
	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	foreach ($singleTables as $table) {
		$rows = $database->Query('SELECT EXISTS(SELECT 1 FROM ' . $table . ' WHERE user_id = $1);', $authenticatedUserId);
		if ($rows->Field('exists')) {
			$database->Query('DELETE FROM ' . $table . ' WHERE user_id = $1;', $userId);
		} else {
			$database->Query('UPDATE ' . $table . ' SET user_id = $1 WHERE user_id = $2;', $authenticatedUserId, $userId);
		}
	}
	foreach ($multiTables as $table) {
		$database->Query('UPDATE ' . $table . ' SET user_id = $1 WHERE user_id = $2;', $authenticatedUserId, $userId);
	}
	$temp = 'temp_' . BeaconCommon::GenerateRandomKey();

	// Migrating project members is hard
	$database->Query('CREATE TEMPORARY TABLE ' . $temp . ' (project_id UUID, role public.project_role);');
	$database->Query('INSERT INTO ' . $temp . ' (project_id, role) SELECT project_id, MIN(role) FROM public.project_members WHERE user_id IN ($1, $2) GROUP BY project_id;', $authenticatedUserId, $userId);
	$database->Query('DELETE FROM public.project_members WHERE user_id = $1;', $userId);
	$database->Query('INSERT INTO public.project_members (project_id, user_id, role) SELECT project_id, $1, role FROM ' . $temp . ' ON CONFLICT (project_id, user_id) DO UPDATE SET role = EXCLUDED.role WHERE project_members.role != EXCLUDED.role', $authenticatedUserId);
	$database->Query('DROP TABLE ' . $temp . ';');

	$database->Commit();

	return Response::NewJson('User merged.', 200);
}

?>
