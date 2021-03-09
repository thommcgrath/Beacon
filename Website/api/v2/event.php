<?php

require(dirname(__FILE__) . '/loader.php');

$method = BeaconAPI::Method();
if ($method !== 'GET') {
	BeaconAPI::ReplyError('Method not allowed', null, 405);
}

$search_value = BeaconAPI::ObjectID();
if (\BeaconCommon::IsUUID($search_value)) {
	$events = BeaconEvent::GetForUUID($search_value);
} elseif (is_string($search_value)) {
	$events = BeaconEvent::GetForArkCode($search_value);
} else {
	$events = BeaconEvent::GetAll();
}

BeaconAPI::ReplySuccess($events);

?>