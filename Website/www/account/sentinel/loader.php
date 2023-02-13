<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');

use BeaconAPI\v4\Session;

$session = Session::GetFromCookie();
if (is_null($session)) {
	BeaconCommon::Redirect('/account/login/');
	exit;
}
$session->Renew();
$session->User();

BeaconTemplate::SetTemplate('sentinel');

?>