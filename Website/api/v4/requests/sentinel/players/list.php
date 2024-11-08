<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{Player};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes[] = Application::kScopeSentinelPlayersRead;
}

function handleRequest(array $context): Response {
	$filters = $_GET;
	$players = Player::Search($filters);
	return Response::NewJson($players, 200);
}

?>
