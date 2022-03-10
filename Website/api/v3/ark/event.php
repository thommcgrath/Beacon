<?php

require(dirname(__FILE__, 2) . '/loader.php');

$method = BeaconAPI::Method();
if ($method !== 'GET') {
	BeaconAPI::ReplyError('Method not allowed', null, 405);
}

$search_value = BeaconAPI::ObjectID();
if (BeaconCommon::IsUUID($search_value)) {
	$events = Ark\Event::GetForUUID($search_value);
} elseif (is_string($search_value)) {
	$events = Ark\Event::GetForArkCode($search_value);
} else {
	$events = Ark\Event::GetAll();
}

BeaconAPI::ReplySuccess($events);

?>