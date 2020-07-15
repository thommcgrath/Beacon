<?php

require(dirname(__FILE__) . '/loader.php');

BeaconAPI::Authorize(true);
$method = BeaconAPI::Method();
$remote_path = '/' . BeaconAPI::UserID();
$components = explode('/', substr($_SERVER['PATH_INFO'], 1));
foreach ($components as $component) {
	$remote_path .= '/' . urlencode($component);
}

$prohibited_path = '/' . BeaconAPI::UserID() . '/Documents/';
$prohibited_path_len = strlen($prohibited_path);
if (substr($remote_path, 0, $prohibited_path_len) === $prohibited_path) {
	BeaconAPI::ReplyError('Use the document API for accessing documents', null, 446);
}

switch ($method) {
case 'GET':
	$dir = substr($remote_path, -1, 1) === '/';
	if ($dir) {
		$prefix_len = strlen('/' . BeaconAPI::UserID());
		$list = BeaconCloudStorage::ListFiles($remote_path);
		$filtered = array();
		foreach ($list as $file) {
			if (substr($file['path'], 0, $prohibited_path_len) === $prohibited_path) {
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
case 'POST':
case 'PUT':
	if (BeaconCloudStorage::PutFile($remote_path, BeaconAPI::Body())) {
		$prefix_len = strlen('/' . BeaconAPI::UserID());
		$details = BeaconCloudStorage::DetailsForFile($remote_path);
		$details['path'] = substr($details['path'], $prefix_len);
		BeaconAPI::ReplySuccess($details);
	} else {
		BeaconAPI::ReplyError('Something went wrong');
	}
	break;
case 'DELETE':
	BeaconCloudStorage::DeleteFile($remote_path);
	break;
}

?>