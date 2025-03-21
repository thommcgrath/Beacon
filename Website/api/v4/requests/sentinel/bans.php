<?php

use BeaconAPI\v4\{Response, Core};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes = [];
	$authScheme = Core::kAuthSchemeNone;
}

function handleRequest(array $context): Response {
	$serviceId = $context['pathParameters']['serviceId'];
	if (BeaconCommon::IsUUID($serviceId) === false) {
		return Response::NewCustom('That\'s not a Beacon Sentinel Server ID.', 400, 'text/plain');
	}

	$database = BeaconCommon::Database();
	$rows = $database->Query('SELECT DISTINCT player_identifiers.identifier FROM sentinel.service_resolved_assets INNER JOIN sentinel.bans ON (service_resolved_assets.asset_id = bans.ban_id) INNER JOIN sentinel.player_identifiers ON (bans.player_id = player_identifiers.player_id AND player_identifiers.provider = $1) WHERE service_resolved_assets.service_id = $2 AND (bans.expiration IS NULL OR bans.expiration > CURRENT_TIMESTAMP) ORDER BY player_identifiers.identifier;', 'EOS', $serviceId);
	$lines = [];
	while (!$rows->EOF()) {
		$lines[] = $rows->Field('identifier');
		$rows->MoveNext();
	}

	return Response::NewCustom(implode("\n", $lines), 200, 'text/plain');
}

?>
