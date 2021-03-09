<?php

require(dirname(__FILE__) . '/loader.php');

$method = BeaconAPI::Method();
if ($method !== 'GET') {
	BeaconAPI::ReplyError('Method not allowed', null, 405);
}

$search_value = BeaconAPI::ObjectID();
if (is_numeric($search_value)) {
	$colors = BeaconColor::GetForID($search_value);
} else {
	$colors = BeaconColor::GetAll();
}

BeaconAPI::ReplySuccess($colors);

?>