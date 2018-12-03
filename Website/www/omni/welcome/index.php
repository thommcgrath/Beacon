<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');

BeaconCommon::StartSession();
$email = '';
if (isset($_SESSION['client_reference_id'])) {
	$client_reference_id = $_SESSION['client_reference_id'];
	
	$database = BeaconCommon::Database();
	$results = $database->Query('SELECT * FROM purchases WHERE client_reference_id = $1;', $client_reference_id);
	if ($results->RecordCount() == 1) {
		$email = $results->Field('purchaser_email');
		$status = 'confirmed';
	} else {
		$status = 'pending';
	}
} else {
	$status = 'unknown';
}

echo $client_reference_id . $email . $status;

?>