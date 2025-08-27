<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{LogMessage, PermissionBits, Service};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes[] = Application::kScopeSentinelRead;
}

function handleRequest(array $context): Response {
	$context = $_GET['context'] ?? '';
	$menuItems = [];
	if (empty($context) === false) {
		try {
			$database = BeaconCommon::Database();
			$rows = $database->Query('SELECT DISTINCT menu_text, script_event_id FROM sentinel.active_scripts WHERE context = $1 AND menu_text IS NOT NULL AND script_id IN (SELECT script_id FROM sentinel.script_permissions WHERE user_id = $2 AND (permissions & $3) = $3) ORDER BY menu_text', $context, Core::UserId(), PermissionBits::Membership | PermissionBits::ControlServices);
			while (!$rows->EOF()) {
				$menuItems[] = [
					'menuText' => $rows->Field('menu_text'),
					'scriptEventId' => $rows->Field('script_event_id'),
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
