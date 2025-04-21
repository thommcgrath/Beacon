<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');

$code = null;
if (isset($_GET['code'])) {
	$code = $_GET['code'];
}

$destination = BeaconShop::TrackAffiliateClick($code);
BeaconCommon::Redirect($destination, true);

?>
