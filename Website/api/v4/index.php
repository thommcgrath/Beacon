<?php

namespace BeaconAPI\v4;

require(dirname(__FILE__) . '/loader.php');

Core::RegisterRoutes(
	[
		'/ark/projects/{projectId}/generatedLines' => [
			'GET' => 'ark/generate',
			'POST' => 'ark/generate'
		],
		'/ark/maps' => [
			'GET' => 'ark/maps/list'
		],
		'/ark/maps/{mapId}' => [
			'GET' => 'ark/maps/get'
		],
		/*'/ark/mods' => [
			'GET' => 'ark/mods/list',
			'POST' => 'ark/mods/bulk',
			'DELETE' => 'ark/mods/bulk'
		],
		'/ark/mods/{modId}' => [
			'GET' => 'ark/mods/get',
			'POST' => 'ark/mods/edit',
			'DELETE' => 'ark/mods/delete'
		],*/
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
		'/challenge/{userId}' => [
			'GET' => 'challenge'
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
		'/now' => [
			'GET' => 'now'
		],
		'/projects' => [
			'GET' => 'projects/list',
			'POST' => 'projects/create'
		],
		'/projects/{projectId}' => [
			'GET' => 'projects/get',
			'POST' => 'projects/edit',
			'DELETE' => 'projects/delete',
			'HEAD' => 'projects/exists'
		],
		'/projects/{projectId}/Game.ini' => [
			'GET' => 'projects/generate'
		],
		'/projects/{projectId}/versions' => [
			'GET' => 'projects/versions/list'
		],
		'/projects/{projectId}/versions/{versionId}' => [
			'GET' => 'project/versions/get'
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
			'GET' => 'users/list',
			'POST' => 'users/create'
		],
		'/users/{userId}' => [
			'GET' => 'users/get',
			'POST' => 'users/edit',
			'DELETE' => 'users/delete'
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
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\ConfigLine', 'ark/configOptions', 'configOptionId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\Engram', 'ark/engrams', 'engramId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\Event', 'ark/events', 'eventId', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\Mod', 'ark/mods', 'modId');


//BeaconObjectManager::RegisterRoutes('Ark\LootSource', 'ark', 'lootContainers');
//BeaconObjectManager::RegisterRoutes('Ark\Creature', 'ark', 'creatures');
//BeaconObjectManager::RegisterRoutes('Ark\ConfigLine', 'ark', 'configOptions');
//BeaconObjectManager::RegisterRoutes('Ark\SpawnPoint', 'ark', 'spawnPoints');

Core::HandleRequest(dirname(__FILE__) . '/requests');

?>