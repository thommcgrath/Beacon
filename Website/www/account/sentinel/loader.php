<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');

use BeaconAPI\v4\Session;

$session = BeaconCommon::GetSession();
if (is_null($session)) {
	BeaconCommon::Redirect('/account/login/');
	exit;
}
$session->User();

BeaconTemplate::SetTemplate('sentinel');

?>