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
	$rows = $database->Query('SELECT DISTINCT ON (player_identifiers.identifier) player_identifiers.identifier, COALESCE(EXTRACT(EPOCH FROM active_bans.expiration)::INTEGER, 0) AS expiration FROM sentinel.active_bans INNER JOIN sentinel.player_identifiers ON (active_bans.player_id = player_identifiers.player_id AND player_identifiers.provider = $1) WHERE active_bans.service_id = $2 ORDER BY player_identifiers.identifier;', 'EOS', $serviceId);
	$lines = [];
	while (!$rows->EOF()) {
		$lines[] = $rows->Field('identifier') . ',' . $rows->Field('expiration');
		$rows->MoveNext();
	}

	return Response::NewCustom(implode("\n", $lines), 200, 'text/plain');
}

?>
