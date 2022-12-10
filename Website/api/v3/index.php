<?php

require(dirname(__FILE__) . '/loader.php');

BeaconAPI::RegisterRoutes(
	[
		'/ark/color_set' => [
			'GET' => 'ark/color_set/list'
		],
		'/ark/color_set/{color_set_id}' => [
			'GET' => 'ark/color_set/get'
		],
		'/ark/color' => [
			'GET' => 'ark/color/list'
		],
		'/ark/color/{color_id}' => [
			'GET' => 'ark/color/get'
		],
		'/ark/event' => [
			'GET' => 'ark/event/list'
		],
		'/ark/event/{event_id}' => [
			'GET' => 'ark/event/get'
		],
		'/ark/generate/{project_id}' => [
			'GET' => 'ark/generate',
			'POST' => 'ark/generate'
		],
		'/ark/map' => [
			'GET' => 'ark/map/list'
		],
		'/ark/map/{map_id}' => [
			'GET' => 'ark/map/get'
		],
		'/ark/mod' => [
			'GET' => 'ark/mod/list',
			'POST' => 'ark/mod/edit'
		],
		'/ark/mod/{workshop_id}' => [
			'GET' => 'ark/mod/get',
			'DELETE' => 'ark/mod/delete'
		],
		'/challenge/{user_id}' => [
			'GET' => 'challenge'
		],
		'/deltas' => [
			'GET' => 'deltas'
		],
		'/deltas/{version}' => [
			'GET' => 'deltas'
		],
		'/file' => [
			'GET' => 'file'
		],
		'/file/{...file_path}' => [
			'GET' => 'file',
			'POST' => 'file',
			'DELETE' => 'file'
		],
		'/now' => [
			'GET' => 'now'
		],
		'/project' => [
			'GET' => 'project/list'
		],
		'/project/{project_id}' => [
			'GET' => 'project/get',
			'POST' => 'project/edit',
			'DELETE' => 'project/delete',
			'HEAD' => 'project/exists'
		],
		'/project/{project_id}/publish' => [
			'GET' => 'project/publish',
			'POST' => 'project/publish'
		],
		'/project/{project_id}/versions' => [
			'GET' => 'project/versions'
		],
		'/project/{project_id}/versions/{version_id}' => [
			'GET' => 'project/get'
		],
		'/sentinel/oauth/{provider}' => [
			'GET' => 'sentinel/oauth'
		],
		'/sentinel/service' => [
			'POST' => 'sentinel/service/create',
			'GET' => 'sentinel/service/list'
		],
		'/sentinel/service/{service_id}' => [
			'POST' => 'sentinel/service/edit',
			'GET' => 'sentinel/service/get',
			'DELETE' => 'sentinel/service/delete'
		],
		'/sentinel/service_group' => [
			'POST' => 'sentinel/service_group/create',
			'GET' => 'sentinel/service_group/list'
		],
		'/sentinel/service_group/{group_id}' => [
			'POST' => 'sentinel/service_group/edit',
			'GET' => 'sentinel/service_group/get',
			'DELETE' => 'sentinel/service_group/delete'
		],
		'/session' => [
			'POST' => 'session/login'
		],
		'/session/{session_id}' => [
			'GET' => 'session/get',
			'DELETE' => 'session/logout'
		],
		'/template_selector' => [
			'GET' => 'template_selector/list'
		],
		'/template_selector/{selector_id}' => [
			'GET' => 'template_selector/get'
		],
		'/template' => [
			'GET' => 'template/list'
		],
		'/template/{template_id}' => [
			'GET' => 'template/get'
		],
		'/user' => [
			'GET' => 'user/get',
			'POST' => 'user/create'
		],
		'/user/{user_id}' => [
			'GET' => 'user/get',
			'DELETE' => 'user/delete'
		]
	]
);

BeaconObjectManager::RegisterRoutes('Ark\LootSource', 'ark', 'loot_source');
BeaconObjectManager::RegisterRoutes('Ark\Creature', 'ark', 'creature');
BeaconObjectManager::RegisterRoutes('Ark\Engram', 'ark', 'engram');
BeaconObjectManager::RegisterRoutes('Ark\ConfigLine', 'ark', 'ini_option');
BeaconObjectManager::RegisterRoutes('Ark\SpawnPoint', 'ark', 'spawn_point');

BeaconAPI::HandleRequest(dirname(__FILE__) . '/requests');

?>