<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{Subscription};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes[] = Application::kScopeSentinelRead;
}

function handleRequest(array $context): Response {
	$subscriptions = Subscription::Search(['userId' => Core::UserId()], true);
	if (count($subscriptions) === 1) {
		return Response::NewJson($subscriptions[0], 200);
	} else {
		return Response::NewJsonError('Subscription not found', null, 404);
	}
}

?>
