<?php

require(dirname(__FILE__) . '/loader.php');

BeaconAPI::Authorize(true);
$method = BeaconAPI::Method();
$remote_path = '/' . BeaconAPI::UserID();
$components = explode('/', substr($_SERVER['PATH_INFO'], 1));
foreach ($components as $component) {
	$remote_path .= '/' . urlencode($component);
}

switch ($method) {
case 'GET':
	$dir = substr($remote_path, -1, 1) === '/';
	if ($dir) {
		$prefix_len = strlen('/' . BeaconAPI::UserID());
		$list = BeaconCloudStorage::ListFiles($remote_path);
		for ($i = 0; $i < count($list); $i++) {
			$list[$i]['path'] = substr($list[$i]['path'], $prefix_len);
		}
		BeaconAPI::ReplySuccess($list);
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