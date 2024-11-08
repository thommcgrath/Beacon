<?php

use BeaconAPI\v4\{Application, Response, Core, User};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes[] = Application::kScopeUsersUpdate;
	$requiredScopes[] = Application::kScopeUsersDelete;
}

function handleRequest(array $context): Response {
	$identifier = $context['pathParameters']['userId'];
	$targetUser = User::Fetch($identifier);
	if (is_null($targetUser)) {
		return Response::NewJsonError('User not found', $identifier, 404);
	}
	$authenticatedUser = Core::User();
	if ($targetUser->UserId() !== $authenticatedUser->UserId()) {
		return Response::NewJsonError('Cannot delete other users.', $identifier, 403);
	}
	if ($targetUser->IsAnonymous() === false) {
		return Response::NewJsonError('Only anonymous users can be deleted.', $identifier, 400);
	}

	try {
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		$database->Query('DELETE FROM public.users WHERE user_id = $1;', $authenticatedUser->UserId());
		$database->Commit();

		return Response::NewJson('User was deleted', 200);
	} catch (Exception $err) {
		return Response::NewJsonError('Could not delete user', $err->getMessage(), 500);
	}
}

?>
