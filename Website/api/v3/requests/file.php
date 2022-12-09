<?php

BeaconAPI::Authorize();
	
function handle_request(array $context): void {
	$user = BeaconAPI::User();
	$prefix = '/' . $user->CloudUserID();
	$prefix_len = strlen($prefix);
	$remote_path = $prefix . '/';
	if (isset($context['path_parameters']['file_path'])) {
		$remote_path .= $context['path_parameters']['file_path'];
	}
	
	$prohibited_path = '/' . $user->CloudUserID() . '/Documents/';
	if (str_starts_with($remote_path, $prohibited_path)) {
		BeaconAPI::ReplyError('Use the document API for accessing documents', null, 446);
	}
	
	switch ($context['route_key']) {
	case 'GET /file':
	case 'GET /file/{...file_path}':
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
	case 'POST /file/{...file_path}':
	case 'PUT /file/{...file_path}':
		if (BeaconCloudStorage::PutFile($remote_path, BeaconAPI::Body())) {
			$details = BeaconCloudStorage::DetailsForFile($remote_path);
			$details['path'] = substr($details['path'], $prefix_len);
			BeaconAPI::ReplySuccess($details);
		} else {
			BeaconAPI::ReplyError('Something went wrong');
		}
		break;
	case 'DELETE /file/{...file_path}':
		BeaconCloudStorage::DeleteFile($remote_path);
		break;
	}
}

?>