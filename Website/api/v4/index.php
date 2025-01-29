<?php

namespace BeaconAPI\v4;

require(dirname(__FILE__) . '/loader.php');

Core::RegisterRoutes(
	[
		'/applications' => [
			'GET' => 'applications/list',
			'POST' => 'applications/create',
		],
		'/applications/{applicationId}' => [
			'GET' => 'applications/get',
			'PATCH' => 'applications/edit',
			'DELETE' => 'applications/delete',
		],
		'/applications/{applicationId}/avatar' => [
			'PUT' => 'applications/avatar',
		],
		'/ark/projects/{projectId}/Game.ini' => [
			'GET' => 'ark/generate',
			'PUT' => 'ark/generate',
		],
		'/arksa/projects/{projectId}/Game.ini' => [
			'GET' => 'arksa/generate',
			'PUT' => 'arksa/generate',
		],
		'/authenticators' => [
			'POST' => 'authenticators/create',
			'GET' => 'authenticators/list',
		],
		'/authenticators/{authenticatorId}' => [
			'POST' => 'authenticators/edit',
			'GET' => 'authenticators/get',
			'DELETE' => 'authenticators/delete',
		],
		'/contentPacks/{contentPackId}/confirm' => [
			'GET' => 'contentPacks/confirm',
		],
		'/dbtest' => [
			'GET' => 'dbtest',
		],
		'/deltas' => [
			'GET' => 'deltas',
		],
		'/deltas/{version}' => [
			'GET' => 'deltas',
		],
		'/discovery' => [
			'GET' => 'discovery/list',
		],
		'/discovery/{contentPackId}' => [
			'PUT' => 'discovery/edit',
			'GET' => 'discovery/get',
			'HEAD' => 'discovery/get',
		],
		'/files' => [
			'GET' => 'file',
		],
		'/files/{...filePath}' => [
			'GET' => 'file',
			'PUT' => 'file',
			'DELETE' => 'file',
		],
		'/licenses/{licenseId}' => [
			'GET' => 'licenses/get',
			'PUT' => 'licenses/edit',
		],
		'/login' => [
			'GET' => 'login',
			'POST' => 'login',
		],
		'/now' => [
			'GET' => 'now',
		],
		'/projects' => [
			'GET' => 'projects/list',
			'DELETE' => 'projects/delete',
			'POST' => 'projects/write',
		],
		'/projects/{projectId}' => [
			'GET' => 'projects/get',
			'DELETE' => 'projects/delete',
			'HEAD' => 'projects/exists',
		],
		'/projects/{projectId}/members' => [
			'GET' => 'projects/members/list',
		],
		'/projects/{projectId}/members/{userId}' => [
			'GET' => 'projects/members/get',
			'PUT' => 'projects/members/create',
			'DELETE' => 'projects/members/delete',
		],
		'/projects/{projectId}/metadata' => [
			'GET' => 'projects/get',
			'PATCH' => 'projects/metadata',
		],
		'/projects/{projectId}/versions' => [
			'GET' => 'projects/get',
		],
		'/projects/{projectId}/versions/{versionId}' => [
			'GET' => 'projects/get',
		],
		'/pusher' => [
			'GET' => 'pusher',
		],
		'/sentinel/services/{serviceId}/logs' => [
			'GET' => 'sentinel/service/logs',
		],
		'/sentinel/serviceGroups/{serviceGroupId}/members' => [
			'GET' => 'sentinel/serviceGroups/members/list',
			'POST' => 'sentinel/serviceGroups/members/edit',
		],
		'/sessions/{sessionId}' => [
			'GET' => 'sessions/get',
			'DELETE' => 'sessions/delete',
		],
		'/templateSelectors' => [
			'GET' => 'templateSelectors/list',
		],
		'/templateSelectors/{templateSelectorId}' => [
			'GET' => 'templateSelectors/get',
		],
		'/templates' => [
			'GET' => 'templates/list',
		],
		'/templates/{templateId}' => [
			'GET' => 'templates/get',
		],
		'/tokens/{tokenId}' => [
			'GET' => 'tokens/get',
			'DELETE' => 'tokens/delete',
		],
		'/users/{userId}' => [
			'GET' => 'users/get',
			'PATCH' => 'users/edit',
			'DELETE' => 'users/delete',
		],
		'/users/{userId}/licenses' => [
			'GET' => 'licenses/list',
		],
		'/users/{userId}/merge' => [
			'POST' => 'users/merge',
		],
		'/users/{userId}/projects' => [
			'GET' => 'projects/list',
		],
		'/users/{userId}/tokens' => [
			'GET' => 'tokens/list',
			'POST' => 'tokens/create',
		]
	]
);

DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\ContentPack', 'contentPacks', 'contentPackId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\RCONCommand', 'rconCommands', 'commandId', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\Blueprint', 'ark/blueprints', 'blueprintId', DatabaseObjectManager::kFeatureAll, 'blueprintGroup', ['creatures' => 'BeaconAPI\v4\Ark\Creature', 'engrams' => 'BeaconAPI\v4\Ark\Engram', 'lootDrops' => 'BeaconAPI\v4\Ark\LootDrop', 'spawnPoints' => 'BeaconAPI\v4\Ark\SpawnPoint']);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\Color', 'ark/colors', 'colorId', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\ColorSet', 'ark/colorSets', 'colorSetId', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\ConfigOption', 'ark/configOptions', 'configOptionId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\Creature', 'ark/creatures', 'creatureId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\Engram', 'ark/engrams', 'engramId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\Event', 'ark/events', 'eventId', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\GameVariable', 'ark/gameVariables', 'key');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\LootDrop', 'ark/lootDrops', 'lootDropId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\LootDropIcon', 'ark/lootDropIcons', 'lootDropIconId', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\Map', 'ark/maps', 'mapId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\SpawnPoint', 'ark/spawnPoints', 'spawnPointId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\ArkSA\Blueprint', 'arksa/blueprints', 'blueprintId', DatabaseObjectManager::kFeatureAll, 'blueprintGroup', ['creatures' => 'BeaconAPI\v4\ArkSA\Creature', 'engrams' => 'BeaconAPI\v4\ArkSA\Engram', 'lootDrops' => 'BeaconAPI\v4\ArkSA\LootDrop', 'spawnPoints' => 'BeaconAPI\v4\ArkSA\SpawnPoint']);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\ArkSA\Color', 'arksa/colors', 'colorId', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\ArkSA\ColorSet', 'arksa/colorSets', 'colorSetId', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\ArkSA\ConfigOption', 'arksa/configOptions', 'configOptionId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\ArkSA\Creature', 'arksa/creatures', 'creatureId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\ArkSA\Engram', 'arksa/engrams', 'engramId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\ArkSA\Event', 'arksa/events', 'eventId', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\ArkSA\GameVariable', 'arksa/gameVariables', 'key');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\ArkSA\LootDrop', 'arksa/lootDrops', 'lootDropId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\ArkSA\LootDropIcon', 'arksa/lootDropIcons', 'lootDropIconId', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\ArkSA\Map', 'arksa/maps', 'mapId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\ArkSA\SpawnPoint', 'arksa/spawnPoints', 'spawnPointId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Sentinel\Player', 'sentinel/players', 'playerId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Sentinel\PlayerNote', 'sentinel/playerNotes', 'playerNoteId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Sentinel\Service', 'sentinel/services', 'serviceId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Sentinel\ServiceGroup', 'sentinel/serviceGroups', 'serviceGroupId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Palworld\ConfigOption', 'palworld/configOptions', 'configOptionId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Palworld\GameVariable', 'palworld/gameVariables', 'key');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\SDTD\ConfigOption', '7dtd/configOptions', 'configOptionId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\ProjectInvite', 'projectInvites', 'inviteCode');

Core::HandleRequest(dirname(__FILE__) . '/requests');

?>
