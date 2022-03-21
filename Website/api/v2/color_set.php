<?php

require(dirname(__FILE__, 2) . '/loader.php');

$method = BeaconAPI::Method();
if ($method !== 'GET') {
	BeaconAPI::ReplyError('Method not allowed', null, 405);
}

$search_value = BeaconAPI::ObjectID();
if (BeaconCommon::IsUUID($search_value)) {
	$sets = Ark\ColorSet::GetForUUID($search_value);
} else {
	$sets = Ark\ColorSet::GetAll();
}

BeaconAPI::ReplySuccess($sets);

?>
