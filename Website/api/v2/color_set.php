<?php

require(dirname(__FILE__) . '/loader.php');

$method = BeaconAPI::Method();
if ($method !== 'GET') {
	BeaconAPI::ReplyError('Method not allowed', null, 405);
}

$search_value = BeaconAPI::ObjectID();
if (BeaconCommon::IsUUID($search_value)) {
	$sets = BeaconColorSet::GetForUUID($search_value);
} else {
	$sets = BeaconColorSet::GetAll();
}

BeaconAPI::ReplySuccess($sets);

?>
