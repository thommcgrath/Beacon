<?php

use BeaconAPI\v4\{Response, Core};
	
function handleRequest(array $context): ?Response {
	$user = Core::User();
	$prefix = '/' . $user->UserId();
	$prefix_len = strlen($prefix);
	$remote_path = $prefix . '/';
	if (isset($context['pathParameters']['filePath'])) {
		$remote_path .= $context['pathParameters']['filePath'];
	}
	
	$prohibited_path = '/' . $user->UserId() . '/Documents/';
	if (str_starts_with($remote_path, $prohibited_path)) {
		return Response::NewJsonError('Use the projects API for accessing projects', null, 446);
	}
	
	switch ($context['routeKey']) {
	case 'GET /files':
	case 'GET /files/{...filePath}':
		$dir = str_ends_with($remote_path, '/');
		if ($dir) {
			$list = BeaconCloudStorage::ListFiles($remote_path);
			$filtered = [];
			foreach ($list as $file) {
				if (str_starts_with($file['path'], $prohibited_path)) {
					continue;
				}
				
				$file['path'] = substr($file['path'], $prefix_len);
				$filtered[] = $file;
			}
			return Response::NewJson($filtered, 200);
		} else {
			BeaconCloudStorage::StreamFile($remote_path);
			return null;
		}
	case 'POST /files/{...filePath}':
	case 'PUT /files/{...filePath}':
		if (BeaconCloudStorage::PutFile($remote_path, Core::Body())) {
			$details = BeaconCloudStorage::DetailsForFile($remote_path);
			$details['path'] = substr($details['path'], $prefix_len);
			BeaconPusher::SharedInstance()->TriggerEvent($user->PusherChannelName(), 'cloud-updated', '');
			return Response::NewJson($details, 200);
		} else {
			return Response::NewJsonError('Something went wrong', null, 500);
		}
	case 'DELETE /files/{...filePath}':
		BeaconCloudStorage::DeleteFile($remote_path);
		BeaconPusher::SharedInstance()->TriggerEvent($user->PusherChannelName(), 'cloud-updated', '');
		return Response::NewNoContent();
	}
	
	return Response::NewJsonError('Route not found', null, 404);
}

?>