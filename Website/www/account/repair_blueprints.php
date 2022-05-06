<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');

$session = BeaconSession::GetFromCookie();
if (is_null($session)) {
	BeaconCommon::Redirect('/account/login/?return=/account/repair_blueprints');
	exit;
}
$session->Renew();

$user = BeaconUser::GetByUserID($session->UserID());
$user_id = $user->UserID();
$legacy_path = '/' . $user_id . '/Blueprints.json';

$versions = BeaconCloudStorage::VersionsForFile($legacy_path);
if (count($versions) === 0) {
	echo 'There are no legacy blueprints to migrate';
	exit;
}

$latest_version_id = null;
$latest_version_date = null;
foreach ($versions as $versioninfo) {
	$date = strtotime(substr($versioninfo['date'], 0, 19));
	if ($date === false) {
		continue;
	}
	if (is_null($latest_version_date) || $date > $latest_version_date) {
		$latest_version_date = $date;
		$latest_version_id = $versioninfo['version_id'];
	}
}
if (is_null($latest_version_id)) {
	echo 'Could not determine latest blueprint version to recover.';
	exit;
}

$legacy_contents = BeaconCloudStorage::GetFile($legacy_path, false, $latest_version_id);
if (empty($legacy_contents)) {
	echo 'Failed to recover legacy blueprints file.';
	exit;
}

$updated_path = '/' . $user_id . '/Ark/Blueprints.json';
BeaconCloudStorage::PutFile($updated_path, $legacy_contents);
	
echo 'The repair is complete. Use the Help menu in the Beacon app to sync your cloud files.';

?>