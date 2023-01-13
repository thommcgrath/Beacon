<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');

$session = BeaconSession::GetFromCookie();
if (is_null($session)) {
	BeaconCommon::Redirect('/account/login/');
	exit;
}
$session->Renew();
$user = BeaconUser::GetByUserID($session->UserID());

BeaconTemplate::SetTemplate('sentinel');

?>