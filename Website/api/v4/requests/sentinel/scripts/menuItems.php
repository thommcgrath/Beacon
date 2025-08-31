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
			$rows = $database->Query('SELECT DISTINCT menu_text, script_event_id, parameters, menu_arguments FROM sentinel.active_scripts WHERE service_id = $1 AND context = $2 AND menu_text IS NOT NULL AND script_id IN (SELECT script_id FROM sentinel.script_permissions WHERE user_id = $3 AND (permissions & $4) = $4) ORDER BY menu_text', $serviceId, $context, Core::UserId(), PermissionBits::Membership | PermissionBits::ControlServices);
			while (!$rows->EOF()) {
				$parameterDefinitions = json_decode($rows->Field('parameters'), true);
				$parameterWhitelist = json_decode($rows->Field('menu_arguments'), true);
				$parameters = [];
				foreach ($parameterDefinitions as $definition) {
					$parameterName = $definition['name'];
					if (in_array($parameterName, $parameterWhitelist)) {
						$parameters[] = $definition;
					}
				}

				$menuItems[] = [
					'menuText' => $rows->Field('menu_text'),
					'scriptEventId' => $rows->Field('script_event_id'),
					'parameters' => $parameters,
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
