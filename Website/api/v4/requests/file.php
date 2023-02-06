<?php

BeaconAPI::Authorize();
	
function handleRequest(array $context): Response {
	$user = BeaconAPI::User();
	$prefix = '/' . $user->UserID();
	$prefix_len = strlen($prefix);
	$remote_path = $prefix . '/';
	if (isset($context['pathParameters']['filePath'])) {
		$remote_path .= $context['pathParameters']['filePath'];
	}
	
	$prohibited_path = '/' . $user->UserID() . '/Documents/';
	if (str_starts_with($remote_path, $prohibited_path)) {
		BeaconAPI::ReplyError('Use the projects API for accessing projects', null, 446);
	}
	
	switch ($context['routeKey']) {
	case 'GET /file':
	case 'GET /file/{...filePath}':
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
			BeaconAPI::ReplySuccess($filtered);
		} else {
			BeaconCloudStorage::StreamFile($remote_path);
		}
		break;
	case 'POST /file/{...filePath}':
	case 'PUT /file/{...filePath}':
		if (BeaconCloudStorage::PutFile($remote_path, BeaconAPI::Body())) {
			$details = BeaconCloudStorage::DetailsForFile($remote_path);
			$details['path'] = substr($details['path'], $prefix_len);
			BeaconAPI::ReplySuccess($details);
		} else {
			BeaconAPI::ReplyError('Something went wrong');
		}
		break;
	case 'DELETE /file/{...filePath}':
		BeaconCloudStorage::DeleteFile($remote_path);
		break;
	}
}

?>