<?php

namespace BeaconAPI\v4;

Core::RegisterRoutes(
	[
		'/applications' => [
			'GET' => 'applications/list',
			'POST' => 'applications/create',
			'DELETE' => 'applications/delete',
		],
		'/applications/{applicationId}' => [
			'GET' => 'applications/get',
			'PATCH' => 'applications/edit',
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
			'DELETE' => 'authenticators/delete',
		],
		'/authenticators/{authenticatorId}' => [
			'POST' => 'authenticators/edit',
			'GET' => 'authenticators/get',
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
		'/device' => [
			'POST' => 'login',
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
			'GET' => 'pusher/details',
		],
		'/pusher/channelAuth' => [
			'POST' => 'pusher/channelAuth',
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
		],
		'/sentinel/gameCommands' => [
			'POST' => 'sentinel/gameCommands',
		],
		'/sentinel/chat' => [
			'POST' => 'sentinel/chat',
		],
		'/sentinel/services/{serviceId}/bans.txt' => [
			'GET' => 'sentinel/bans/banlist',
			'POST' => 'sentinel/bans/import',
		],
		'/sentinel/groups/{groupId}/bans.txt' => [
			'POST' => 'sentinel/bans/import',
		],
		'/sentinel/scripts/test' => [
			'POST' => 'sentinel/scripts/test',
		],
		'/sentinel/scripts/{scriptId}/revisions' => [
			'GET' => 'sentinel/scripts/revisions',
		],
		'/sentinel/scriptWebhooks/{scriptWebhookId}/trigger' => [
			'POST' => 'sentinel/scripts/trigger',
		],
		'/sentinel/scriptMenuItems' => [
			'GET' => 'sentinel/scripts/menuItems',
		],
		'/sentinel/scriptMenuItems/{scriptEventId}' => [
			'POST' => 'sentinel/scripts/run',
		],
		'/sentinel/dinos/{dinoId}/locate' => [
			'POST' => 'sentinel/dinos/locate',
		],
		'/sentinel/dinos/{dinoId}/restore' => [
			'POST' => 'sentinel/dinos/restore',
		],
		'/sentinel/dinos/{dinoId}/edit' => [
			'POST' => 'sentinel/dinos/edit',
		],
		'/sentinel/characters/{characterId}/giveItem' => [
			'POST' => 'sentinel/characters/giveItem',
		],
		'/sentinel/characters/{characterId}/giveDino' => [
			'POST' => 'sentinel/characters/giveDino',
		],
		'/sentinel/characters/{characterId}/locate' => [
			'POST' => 'sentinel/characters/locate',
		],
		'/sentinel/groups/{groupId}/discordChatChannels' => [
			'GET' => 'sentinel/groups/discordChatChannels',
		],
		'/users/{userId}/billingPortal' => [
			'GET' => 'users/billingUrl',
		],
		'/users/{userId}/createCustomerSession' => [
			'POST' => 'users/createCustomerSession',
		],
		'/beginCheckout' => [
			'POST' => 'beginCheckout',
		],
		'/discordBotStatus/{botId}' => [
			'GET' => 'discord/botStatus',
		],
	]
);

DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\ContentPack', 'contentPacks', 'contentPackId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\Blueprint', 'ark/blueprints', 'blueprintId', DatabaseObjectManager::kFeatureAll, 'blueprintGroup', ['creatures' => 'BeaconAPI\v4\Ark\Creature', 'engrams' => 'BeaconAPI\v4\Ark\Engram', 'lootDrops' => 'BeaconAPI\v4\Ark\LootDrop', 'spawnPoints' => 'BeaconAPI\v4\Ark\SpawnPoint']);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\Color', 'ark/colors', 'colorId', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\ColorSet', 'ark/colorSets', 'colorSetId', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\ConfigOption', 'ark/configOptions', 'configOptionId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\Creature', 'ark/creatures', 'creatureId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\Engram', 'ark/engrams', 'engramId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\Event', 'ark/events', 'eventId', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\GameVariable', 'ark/gameVariables', 'key', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\LootDrop', 'ark/lootDrops', 'lootDropId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\LootDropIcon', 'ark/lootDropIcons', 'lootDropIconId', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\Map', 'ark/maps', 'mapId', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Ark\SpawnPoint', 'ark/spawnPoints', 'spawnPointId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\ArkSA\Blueprint', 'arksa/blueprints', 'blueprintId', DatabaseObjectManager::kFeatureAll, 'blueprintGroup', ['creatures' => 'BeaconAPI\v4\ArkSA\Creature', 'engrams' => 'BeaconAPI\v4\ArkSA\Engram', 'lootDrops' => 'BeaconAPI\v4\ArkSA\LootDrop', 'spawnPoints' => 'BeaconAPI\v4\ArkSA\SpawnPoint']);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\ArkSA\Color', 'arksa/colors', 'colorId', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\ArkSA\ColorSet', 'arksa/colorSets', 'colorSetId', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\ArkSA\ConfigOption', 'arksa/configOptions', 'configOptionId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\ArkSA\Creature', 'arksa/creatures', 'creatureId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\ArkSA\Engram', 'arksa/engrams', 'engramId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\ArkSA\Event', 'arksa/events', 'eventId', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\ArkSA\GameVariable', 'arksa/gameVariables', 'key', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\ArkSA\GeneTrait', 'arksa/geneTraits', 'geneTraitId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\ArkSA\LootDrop', 'arksa/lootDrops', 'lootDropId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\ArkSA\LootDropIcon', 'arksa/lootDropIcons', 'lootDropIconId', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\ArkSA\Map', 'arksa/maps', 'mapId', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\ArkSA\SpawnPoint', 'arksa/spawnPoints', 'spawnPointId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Palworld\ConfigOption', 'palworld/configOptions', 'configOptionId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Palworld\GameVariable', 'palworld/gameVariables', 'key', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\SDTD\ConfigOption', '7dtd/configOptions', 'configOptionId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\ProjectInvite', 'projectInvites', 'inviteCode');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Sentinel\Bucket', 'sentinel/buckets', 'bucketId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Sentinel\BucketValue', 'sentinel/bucketValues', 'bucketValueId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Sentinel\Character', 'sentinel/characters', 'characterId', DatabaseObjectManager::kFeatureAll & ~DatabaseObjectManager::kFeatureCreate);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Sentinel\Dino', 'sentinel/dinos', 'dinoId', DatabaseObjectManager::kFeatureAll & ~DatabaseObjectManager::kFeatureCreate);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Sentinel\Group', 'sentinel/groups', 'groupId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Sentinel\GroupBan', 'sentinel/groupBans', 'groupBanId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Sentinel\GroupBucket', 'sentinel/groupBuckets', 'groupBucketId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Sentinel\GroupScript', 'sentinel/groupScripts', 'groupScriptId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Sentinel\GroupService', 'sentinel/groupServices', 'groupServiceId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Sentinel\GroupUser', 'sentinel/groupUsers', 'groupUserId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Sentinel\LogMessage', 'sentinel/logMessages', 'messageId', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Sentinel\Player', 'sentinel/players', 'playerId', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Sentinel\PlayerIdentifier', 'sentinel/playerIdentifiers', 'playerIdentifierId', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Sentinel\PlayerNameChange', 'sentinel/playerNameChanges', 'historyId', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Sentinel\PlayerNote', 'sentinel/playerNotes', 'playerNoteId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Sentinel\PlayerSession', 'sentinel/playerSessions', 'playerSessionId', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Sentinel\Script', 'sentinel/scripts', 'scriptId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Sentinel\Service', 'sentinel/services', 'serviceId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Sentinel\ServiceBan', 'sentinel/serviceBans', 'serviceBanId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Sentinel\ServiceScript', 'sentinel/serviceScripts', 'serviceScriptId');
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Sentinel\ServiceUser', 'sentinel/serviceUsers', 'serviceUserId', DatabaseObjectManager::kFeatureReadOnly);
DatabaseObjectManager::RegisterRoutes('BeaconAPI\v4\Sentinel\Tribe', 'sentinel/tribes', 'tribeId', DatabaseObjectManager::kFeatureAll & ~DatabaseObjectManager::kFeatureCreate);

?>
