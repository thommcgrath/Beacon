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
		'/emailVerification/{email}' => [
			'GET' => 'emailVerification/get',
			'PUT' => 'emailVerification/create'
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
			'GET' => 'login'
		],
		'/now' => [
			'GET' => 'now'
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
		'/sentinel/oauth/{provider}' => [
			'GET' => 'sentinel/oauth'
		],
		'/sentinel/players' => [
			'GET' => 'sentinel/players/list'
		],
		'/sentinel/playerNote' => [
			'GET' => 'sentinel/playerNotes/list',
			'POST' => 'sentinel/playerNotes/create'
		],
		'/sentinel/services' => [
			'POST' => 'sentinel/services/create',
			'GET' => 'sentinel/services/list'
		],
		'/sentinel/services/{serviceId}' => [
			'POST' => 'sentinel/services/edit',
			'GET' => 'sentinel/services/get',
			'DELETE' => 'sentinel/services/delete'
		],
		'/sentinel/services/{serviceId}/logs' => [
			'GET' => 'sentinel/service/logs'
		],
		'/sentinel/serviceGroups' => [
			'POST' => 'sentinel/serviceGroups/create',
			'GET' => 'sentinel/serviceGroups/list'
		],
		'/sentinel/serviceGroups/{serviceGroupId}' => [
			'POST' => 'sentinel/serviceGroups/edit',
			'GET' => 'sentinel/serviceGroups/get',
			'DELETE' => 'sentinel/serviceGroups/delete'
		],
		'/sentinel/serviceGroups/{serviceGroupId}/members' => [
			'GET' => 'sentinel/serviceGroups/members/list',
			'POST' => 'sentinel/serviceGroups/members/edit'
		],
		'/sessions' => [
			'POST' => 'sessions/create'
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
			'PATCH' => 'users/edit',
			'PUT' => 'users/create'
		],
		'/users/{userId}/challenge' => [
			'GET' => 'users/challenge'
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
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\LootContainer', 'ark/lootContainers', 'lootContainerId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\LootContainerIcon', 'ark/lootContainerIcons', 'lootContainerIconId', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\Map', 'ark/maps', 'mapId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\SpawnPoint', 'ark/spawnPoints', 'spawnPointId');

Core::HandleRequest(dirname(__FILE__) . '/requests');

?>