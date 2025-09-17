#!/usr/bin/php -q
<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

use BeaconAPI\v4\Sentinel\{LogMessage, Script};
use BeaconAPI\v4\{Application, Core, Session, User};

$database = BeaconCommon::Database();
$database->BeginTransaction();

$_SERVER['REMOTE_ADDR'] = '127.0.0.1';
$session = Session::Create(User::Fetch('00000000-60b4-4e15-91b1-a29ebd4651cd'), '8e245f46-f1ee-489e-ae2a-aa0ed7e2f681', [Application::kScopeSentinelRead, Application::kScopeSentinelWrite]);
Core::SetSession($session);

$rows = $database->Query('SELECT * FROM sentinel.scripts_legacy;');
while (!$rows->EOF()) {
	$scriptName = $rows->Field('name');
	$scriptId = $rows->Field('script_id');
	echo "Working on {$scriptId}...\n";
	$scriptContext = $rows->Field('context');
	$scriptLanguage = $rows->Field('language');
	$scriptCode = $rows->Field('code');
	$parameterDefinitions = json_decode($rows->Field('parameters') ?? '[]', true);

	$mainEvent = [
		'language' => $scriptLanguage,
		'context' => $scriptContext,
		'code' => $scriptCode,
	];

	$events = [
		&$mainEvent,
	];

	switch ($scriptContext) {
	case LogMessage::EventManualServiceScript:
	case LogMessage::EventManualCharacterScript:
	case LogMessage::EventManualDinoScript:
	case LogMessage::EventManualTribeScript:
		$mainEvent['keyword'] = $scriptName;
		$mainEvent['arguments'] = $parameterDefinitions;

		if ($scriptContext === LogMessage::EventManualServiceScript && is_null($rows->Field('command_keyword')) === false) {
			$parameterMap = [];
			foreach ($parameterDefinitions as $parameter) {
				$parameterName = $parameter['name'];
				$parameterMap[$parameterName] = $parameter;
			}

			$argumentPositions = json_decode($rows->Field('command_arguments') ?? '[]', true);
			$arguments = [];
			foreach ($argumentPositions as $parameterName) {
				if (array_key_exists($parameterName, $parameterMap)) {
					$arguments[] = $parameterMap[$parameterName];
				}
			}

			$events[] = [
				'language' => $scriptLanguage,
				'context' => LogMessage::EventScriptCommand,
				'code' => $scriptCode,
				'keyword' => $rows->Field('command_keyword'),
				'arguments' => $arguments,
			];
		}

		$webhooks = $database->Query('SELECT * FROM sentinel.script_webhooks WHERE script_id = $1;', $scriptId);
		while (!$webhooks->EOF()) {
			$events[] = [
				'language' => $scriptLanguage,
				'context' => LogMessage::EventWebhook,
				'code' => $scriptCode,
				'keyword' => 'Converted Webhook ' . substr($webhooks->Field('webhook_id'), 0, 8),
				'arguments' => $parameterDefinitions,
			];
			$webhooks->MoveNext();
		}

		break;
	case LogMessage::EventSlashCommand:
		$mainEvent['keyword'] = $rows->Field('command_keyword');
		$parameterMap = [];
		foreach ($parameterDefinitions as $parameter) {
			$parameterName = $parameter['name'];
			$parameterMap[$parameterName] = $parameter;
		}

		$argumentPositions = json_decode($rows->Field('command_arguments') ?? '[]', true);
		$arguments = [];
		foreach ($argumentPositions as $parameterName) {
			if (array_key_exists($parameterName, $parameterMap)) {
				$arguments[] = $parameterMap[$parameterName];
			}
		}
		$mainEvent['arguments'] = $arguments;
		break;
	case LogMessage::EventCron:
		for ($idx = 0; $idx < count($parameterDefinitions); $idx++) {
			$definition = $parameterDefinitions[$idx];
			if ($definition['name'] === 'schedule') {
				$mainEvent['keyword'] = $definition['default'];
				array_splice($parameterDefinitions, $idx, 1);
				break;
			}
		}
		$mainEvent['arguments'] = [];
		break;
	}

	$script = [
		'scriptId' => $scriptId,
		'name' => $scriptName,
		'description' => '',
		'parameters' => $parameterDefinitions,
		'events' => $events,
	];

	$eventCount = count($events);
	echo "Saving {$scriptId} with {$eventCount} events...\n";
	try {
		Script::Create($script);
	} catch (Exception $err) {
		echo $err->getMessage();
		$database->Rollback();
		exit;
	}
	$database->Query('UPDATE sentinel.scripts SET user_id = $2, date_created = $3, date_modified = $4 WHERE script_id = $1;', $scriptId, $rows->Field('user_id'), $rows->Field('date_created'), $rows->Field('date_modified'));

	$rows->MoveNext();
}

$database->Query('INSERT INTO sentinel.service_scripts (service_script_id, service_id, script_id, parameter_values) SELECT service_script_id, service_id, script_id, parameter_values FROM sentinel.service_scripts_legacy WHERE revision_number IS NULL;');
$database->Query('INSERT INTO sentinel.group_scripts (group_script_id, group_id, script_id, permissions_mask, parameter_values) SELECT group_script_id, group_id, script_id, permissions_mask, parameter_values FROM sentinel.group_scripts_legacy WHERE revision_number IS NULL;');

$database->Commit();

?>
