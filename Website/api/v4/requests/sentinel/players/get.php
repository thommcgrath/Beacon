<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{Player};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes[] = Application::kScopeSentinelPlayersRead;
}

function handleRequest(array $context): Response {
	$playerId = $context['pathParameters']['playerId'];
	$player = Player::Fetch($playerId);
	if (is_null($player)) {
		return Response::NewJsonError('Player not found', $playerId, 404);
	}
	return Response::NewJson($player, 200);
}

?>
