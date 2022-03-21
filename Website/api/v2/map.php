<?php

require(dirname(__FILE__, 2) . '/loader.php');

$method = BeaconAPI::Method();
if ($method !== 'GET') {
	BeaconAPI::ReplyError('Method not allowed', null, 405);
}

$search_value = BeaconAPI::ObjectID();
if (is_numeric($search_value)) {
	$maps = Ark\Map::GetForMask($search_value);
} elseif (BeaconCommon::IsUUID($search_value)) {
	$maps = Ark\Map::GetForMapID($search_value);
} elseif (is_string($search_value)) {
	$maps = Ark\Map::GetNamed($search_value);
} else {
	$maps = Ark\Map::GetAll();
}

BeaconAPI::ReplySuccess($maps);

?>