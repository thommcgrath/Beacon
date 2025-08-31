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

	$event = [
		'language' => $scriptLanguage,
		'context' => $scriptContext,
		'code' => $rows->Field('code'),
	];

	switch ($scriptContext) {
	case LogMessage::EventManualServiceScript:
		if (is_null($rows->Field('command_keyword')) === false) {
			$scriptContext = LogMessage::EventScriptCommand;
			$event['context'] = $scriptContext;
			$event['commandKeyword'] = $rows->Field('command_keyword');
			$event['commandArguments'] = json_decode($rows->Field('command_arguments') ?? '[]', true);
		} else {
			$webhooks = $database->Query('SELECT * FROM sentinel.script_webhooks WHERE script_id = $1;', $scriptId);
			if ($webhooks->RecordCount() > 0) {
				$scriptContext = LogMessage::EventWebhook;
				$event['context'] = $scriptContext;
				$event['webhookId'] = $webhooks->Field('webhook_id');
				$event['webhookAccessKey'] = BeaconCommon::Base64UrlEncode(BeaconEncryption::RSADecrypt(BeaconCommon::GetGlobal('Beacon_Private_Key'), BeaconCommon::Base64UrlDecode($webhooks->Field('access_key'))));
			} else {
				$event['menuText'] = $scriptName;
			}
		}
		break;
	case LogMessage::EventManualCharacterScript:
	case LogMessage::EventManualDinoScript:
	case LogMessage::EventManualTribeScript:
		$event['menuText'] = $scriptName;
		$event['menuArguments'] = array_keys(json_decode($rows->Field('parameters'), true));
		break;
	case LogMessage::EventSlashCommand:
		$event['commandKeyword'] = $rows->Field('command_keyword');
		$event['commandArguments'] = json_decode($rows->Field('command_arguments') ?? '[]', true);
		break;
	}

	$script = [
		'scriptId' => $scriptId,
		'name' => $scriptName,
		'description' => '',
		'parameters' => json_decode($rows->Field('parameters'), true),
		'events' => [
			$event,
		]
	];

	echo "Saving {$scriptId}...\n";
	Script::Create($script);
	$database->Query('UPDATE sentinel.scripts SET user_id = $2, date_created = $3, date_modified = $4 WHERE script_id = $1;', $scriptId, $rows->Field('user_id'), $rows->Field('date_created'), $rows->Field('date_modified'));

	$rows->MoveNext();
}

$database->Query('INSERT INTO sentinel.service_scripts (service_script_id, service_id, script_id, parameter_values) SELECT service_script_id, service_id, script_id, parameter_values FROM sentinel.service_scripts_legacy WHERE revision_number IS NULL;');
$database->Query('INSERT INTO sentinel.group_scripts (group_script_id, group_id, script_id, permissions_mask, parameter_values) SELECT group_script_id, group_id, script_id, permissions_mask, parameter_values FROM sentinel.group_scripts_legacy WHERE revision_number IS NULL;');

$database->Commit();

?>
