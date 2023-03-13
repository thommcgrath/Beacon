<?php

namespace BeaconAPI\v4;

require(dirname(__FILE__) . '/loader.php');

Core::RegisterRoutes(
	[
		'/applications' => [
			'GET' => 'applications/list',
			'POST' => 'applications/create'
		],
		'/applications/{applicationId}' => [
			'GET' => 'applications/get',
			'PATCH' => 'applications/edit',
			'DELETE' => 'applications/delete'
		],
		'/applications/{applicationId}/avatar' => [
			'PUT' => 'applications/avatar'
		],
		'/ark/projects/{projectId}/generatedLines' => [
			'GET' => 'ark/generate',
			'POST' => 'ark/generate'
		],
		'/ark/mods/{modId}/checkConfirmation' => [
			'GET' => 'ark/mods/confirm'
		],
		'/ark/mods/{modId}/engrams' => [
			'GET' => 'ark/engrams/list'
		],
		'/authenticators' => [
			'POST' => 'authenticators/create',
			'GET' => 'authenticators/list'
		],
		'/authenticators/{authenticatorId}' => [
			'POST' => 'authenticators/edit',
			'GET' => 'authenticators/get',
			'DELETE' => 'authenticators/delete'
		],
		'/deltas' => [
			'GET' => 'deltas'
		],
		'/deltas/{version}' => [
			'GET' => 'deltas'
		],
		'/files' => [
			'GET' => 'file'
		],
		'/files/{...filePath}' => [
			'GET' => 'file',
			'POST' => 'file',
			'DELETE' => 'file'
		],
		'/login' => [
			'GET' => 'login',
			'POST' => 'login'
		],
		'/now' => [
			'GET' => 'now'
		],
		'/oauth/{provider}' => [
			'GET' => 'oauth'
		],
		'/projects' => [
			'GET' => 'projects/list',
			'POST' => 'projects/create',
			'DELETE' => 'projects/delete'
		],
		'/projects/{projectId}' => [
			'GET' => 'projects/get',
			'PATCH' => 'projects/edit',
			'DELETE' => 'projects/delete',
			'HEAD' => 'projects/exists'
		],
		'/projects/{projectId}/Game.ini' => [
			'GET' => 'projects/generate'
		],
		'/projects/{projectId}/metadata' => [
			'GET' => 'projects/get'
		],
		'/projects/{projectId}/versions' => [
			'GET' => 'projects/get'
		],
		'/projects/{projectId}/versions/{versionId}' => [
			'GET' => 'projects/get'
		],
		'/sentinel/services/{serviceId}/logs' => [
			'GET' => 'sentinel/service/logs'
		],
		'/sentinel/serviceGroups/{serviceGroupId}/members' => [
			'GET' => 'sentinel/serviceGroups/members/list',
			'POST' => 'sentinel/serviceGroups/members/edit'
		],
		'/sessions/{sessionId}' => [
			'GET' => 'sessions/get',
			'DELETE' => 'sessions/delete'
		],
		'/templateSelectors' => [
			'GET' => 'templateSelectors/list'
		],
		'/templateSelectors/{templateSelectorId}' => [
			'GET' => 'templateSelectors/get'
		],
		'/templates' => [
			'GET' => 'templates/list'
		],
		'/templates/{templateId}' => [
			'GET' => 'templates/get'
		],
		'/users' => [
			'POST' => 'users/create'
		],
		'/users/{userId}' => [
			'GET' => 'users/get',
			'PATCH' => 'users/edit'
		],
		'/users/{userId}/merge' => [
			'POST' => 'users/merge'
		],
		'/users/{userId}/ark/mods' => [
			'GET' => 'ark/mods/list'
		],
		'/users/{userId}/projects' => [
			'GET' => 'projects/list'
		]
	]
);

DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\Blueprint', 'ark/blueprints', 'blueprintId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\Color', 'ark/colors', 'colorId', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\ColorSet', 'ark/colorSets', 'colorSetId', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\ConfigOption', 'ark/configOptions', 'configOptionId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\ContentPack', 'ark/contentPacks', 'contentPackId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\Creature', 'ark/creatures', 'creatureId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\Engram', 'ark/engrams', 'engramId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\Event', 'ark/events', 'eventId', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\GameVariable', 'ark/gameVariables', 'key');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\LootDrop', 'ark/lootDrops', 'lootDropId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\LootDropIcon', 'ark/lootDropIcons', 'lootDropIconId', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\Map', 'ark/maps', 'mapId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\SpawnPoint', 'ark/spawnPoints', 'spawnPointId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Sentinel\Player', 'sentinel/players', 'playerId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Sentinel\PlayerNote', 'sentinel/playerNotes', 'playerNoteId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Sentinel\Service', 'sentinel/services', 'serviceId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Sentinel\ServiceGroup', 'sentinel/serviceGroups', 'serviceGroupId');

Core::HandleRequest(dirname(__FILE__) . '/requests');

?>