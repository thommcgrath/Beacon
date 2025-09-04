<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{LogMessage, PermissionBits, Service};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes[] = Application::kScopeSentinelRead;
}

function handleRequest(array $context): Response {
	$context = $_GET['context'] ?? '';
	$serviceId = $_GET['serviceId'] ?? '';
	$menuItems = [];
	if (empty($context) === false || BeaconUUID::Validate($serviceId) === false) {
		try {
			$database = BeaconCommon::Database();
			$rows = $database->Query('SELECT DISTINCT script_event_id, keyword, arguments FROM sentinel.active_scripts WHERE service_id = $1 AND context = $2 AND context IN ($5, $6, $7, $8) AND script_id IN (SELECT script_id FROM sentinel.script_permissions WHERE user_id = $3 AND (permissions & $4) = $4) ORDER BY keyword', $serviceId, $context, Core::UserId(), PermissionBits::Membership | PermissionBits::ControlServices, LogMessage::EventManualCharacterScript, LogMessage::EventManualDinoScript, LogMessage::EventManualServiceScript, LogMessage::EventManualTribeScript);
			while (!$rows->EOF()) {
				$menuItems[] = [
					'menuText' => $rows->Field('keyword'),
					'scriptEventId' => $rows->Field('script_event_id'),
					'arguments' => json_decode($rows->Field('arguments'), true),
				];
				$rows->MoveNext();
			}
		} catch (Exception $err) {
			$menuItems = [];
		}
	}
	return Response::NewJson($menuItems, 200);
}

?>
