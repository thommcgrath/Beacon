<?php

use BeaconAPI\v4\{Core, Response};
use BeaconAPI\v4\Sentinel\{PermissionBits};

function handleRequest(array $context): Response {
	$channelName = $_POST['channel_name'];
	if (str_contains($channelName, '.') === false) {
		$channelNameParts = [$channelName];
	} else {
		$channelNameParts = explode('.', $channelName);
	}
	$userId = Core::UserId();
	$database = BeaconCommon::Database();
	switch ($channelNameParts[0]) {
	case 'private-users':
		$requestedUserId = $channelNameParts[1];
		if ($requestedUserId !== $userId) {
			return Response::NewJsonError(message: 'User may only join their own channel', httpStatus: 403, code: 'forbidden');
		}
		break;
	case 'private-sentinel':
		switch ($channelNameParts[1]) {
		case 'services':
			$rows = $database->Query('SELECT EXISTS(SELECT 1 FROM sentinel.service_permissions WHERE service_id = $1 AND user_id = $2 AND (permissions & $3) = $3);', $channelNameParts[2], $userId, PermissionBits::Membership);
			if ($rows->Field('exists') !== true) {
				return Response::NewJsonError(message: 'Service not found', httpStatus: 404, code: 'notFound', details: ['serviceId' => $channelNameParts[2]]);
			}
			break;
		case 'characters':
			$rows = $database->Query('SELECT EXISTS(SELECT 1 FROM sentinel.service_permissions INNER JOIN sentinel.characters ON (service_permissions.service_id = characters.service_id) WHERE character_id = $1 AND user_id = $2 AND (permissions & $3) = $3);', $channelNameParts[2], $userId, PermissionBits::Membership);
			if ($rows->Field('exists') !== true) {
				return Response::NewJsonError(message: 'Character not found', httpStatus: 404, code: 'notFound', details: ['characterId' => $channelNameParts[2]]);
			}
			break;
		case 'tribes':
			$rows = $database->Query('SELECT EXISTS(SELECT 1 FROM sentinel.service_permissions INNER JOIN sentinel.tribes ON (service_permissions.service_id = tribes.service_id) WHERE tribe_id = $1 AND user_id = $2 AND (permissions & $3) = $3);', $channelNameParts[2], $userId, PermissionBits::Membership);
			if ($rows->Field('exists') !== true) {
				return Response::NewJsonError(message: 'Tribe not found', httpStatus: 404, code: 'notFound', details: ['tribeId' => $channelNameParts[2]]);
			}
			break;
		case 'dinos':
			$rows = $database->Query('SELECT EXISTS(SELECT 1 FROM sentinel.service_permissions INNER JOIN sentinel.dinos ON (service_permissions.service_id = dinos.service_id) WHERE dino_id = $1 AND user_id = $2 AND (permissions & $3) = $3);', $channelNameParts[2], $userId, PermissionBits::Membership);
			if ($rows->Field('exists') !== true) {
				return Response::NewJsonError(message: 'Dino not found', httpStatus: 404, code: 'notFound', details: ['dinoId' => $channelNameParts[2]]);
			}
			break;
		case 'players':
			// Players are public
			break;
		case 'buckets':
			$rows = $database->Query('SELECT EXISTS(SELECT 1 FROM sentinel.bucket_permissions WHERE bucket_id = $1 AND user_id = $2 AND (permissions & $3) = $3);', $channelNameParts[2], $userId, PermissionBits::Membership);
			if ($rows->Field('exists') !== true) {
				return Response::NewJsonError(message: 'Bucket not found', httpStatus: 404, code: 'notFound', details: ['bucketId' => $channelNameParts[2]]);
			}
			break;
		case 'scripts':
			$rows = $database->Query('SELECT EXISTS(SELECT 1 FROM sentinel.script_permissions WHERE script_id = $1 AND user_id = $2 AND (permissions & $3) = $3);', $channelNameParts[2], $userId, PermissionBits::Membership);
			if ($rows->Field('exists') !== true) {
				return Response::NewJsonError(message: 'Script not found', httpStatus: 404, code: 'notFound', details: ['scriptId' => $channelNameParts[2]]);
			}
			break;
		case 'groups':
			$rows = $database->Query('SELECT EXISTS(SELECT 1 FROM sentinel.group_permissions WHERE group_id = $1 AND user_id = $2 AND (permissions & $3) = $3);', $channelNameParts[2], $userId, PermissionBits::Membership);
			if ($rows->Field('exists') !== true) {
				return Response::NewJsonError(message: 'Group not found', httpStatus: 404, code: 'notFound', details: ['groupId' => $channelNameParts[2]]);
			}
			break;
		default:
			return Response::NewJsonError(message: 'Unknown channel', httpStatus: 404, code: 'notFound', details: ['prefix' => $channelNameParts[1]]);
		}
		break;
	case 'private-projects':
		$rows = $database->Query('SELECT EXISTS(SELECT 1 FROM public.project_members INNER JOIN public.projects ON (project_members.project_id = projects.project_id) WHERE projects.project_id = $1 AND projects.deleted = FALSE AND project_members.user_id = $2);', $channelNameParts[1], $userId);
		if ($rows->Field('exists') !== true) {
			return Response::NewJsonError(message: 'Group not found', httpStatus: 404, code: 'notFound', details: ['groupId' => $channelNameParts[2]]);
		}
		break;
	default:
		if (str_starts_with($channelName, 'private-')) {
			return Response::NewJsonError(message: 'Unknown channel', httpStatus: 404, code: 'notFound');
		}
	}

	$socketId = $_POST['socket_id'];
	$signature = hash_hmac('sha256', "{$socketId}:{$channelName}", BeaconCommon::GetGlobal('Pusher Secret'));

	return Response::NewJson([
		'auth' => BeaconCommon::GetGlobal('Pusher Key') . ':' . $signature,
	], 200);
}

?>
