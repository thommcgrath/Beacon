<?php

use BeaconAPI\v4\{Application, Response, Core};
use BeaconAPI\v4\Sentinel\{Group, PermissionBits};

function setupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
	$requiredScopes[] = Application::kScopeSentinelRead;
}

function handleRequest(array $context): Response {
	$groupId = $context['pathParameters']['groupId'];
	if (BeaconCommon::IsUUID($groupId) === false) {
		return Response::NewJsonError(message: 'Group not found', httpStatus: 404, code: 'notFound');
	}

	$group = Group::Fetch($groupId);
	if (is_null($group)) {
		return Response::NewJsonError(message: 'Group not found', httpStatus: 404, code: 'notFound');
	}
	if (Group::TestSentinelPermissions($groupId, Core::UserId()) === false) {
		return Response::NewJsonError(message: 'Group not found', httpStatus: 404, code: 'notFound');
	}

	$guildId = $group->DiscordGuildId();
	$channels = [];
	if (is_null($guildId) === false) {
		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT * FROM public.discord_channels WHERE guild_id = $1 ORDER BY channel_name;', $guildId);
		while (!$rows->EOF()) {
			$channels[] = [
				'channelId' => $rows->Field('channel_id'),
				'name' => $rows->Field('channel_name'),
				'type' => (int)$rows->Field('channel_type'),
				'parentChannelId' => $rows->Field('channel_parent_id'),
			];
			$rows->MoveNext();
		}
	}

	return Response::NewJson($channels, 200);
}

?>
