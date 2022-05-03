<?php

require(dirname(__FILE__) . '/loader.php');

$method = BeaconAPI::Method();
if ($method !== 'GET') {
	BeaconAPI::ReplyError('Method not allowed', null, 405);
}

$search_value = BeaconAPI::ObjectID();
if (is_numeric($search_value)) {
	$colors = Ark\Color::GetForID($search_value);
} else {
	$colors = Ark\Color::GetAll();
}

BeaconAPI::ReplySuccess($colors);

?>