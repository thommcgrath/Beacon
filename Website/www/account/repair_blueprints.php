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

$legacy_contents = BeaconCloudStorage::GetFile($legacy_path);
if (empty($legacy_contents)) {
	echo 'There are no legacy blueprints to migrate';
	exit;
}

$updated_path = '/' . $user_id . '/Ark/Blueprints.json';
BeaconCloudStorage::PutFile($updated_path, $legacy_contents);
	
echo 'The repair is complete. Use the Help menu in the Beacon app to sync your cloud files.';

?>