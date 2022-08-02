<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');

$code = null;
if (isset($_GET['code'])) {
	$code = $_GET['code'];
}

BeaconShop::TrackAffiliateClick($code);
BeaconCommon::Redirect('/omni', true);

?>
