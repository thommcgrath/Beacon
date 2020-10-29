<?php

require(dirname(__FILE__) . '/loader.php');

$method = BeaconAPI::Method();
if ($method !== 'GET') {
	BeaconAPI::ReplyError('Method not allowed', null, 405);
}

$search_value = BeaconAPI::ObjectID();
if (is_numeric($search_value)) {
	$maps = BeaconMap::GetForMask($search_value);
} elseif (\BeaconCommon::IsUUID($search_value)) {
	$maps = BeaconMap::GetForMapID($search_value);
} elseif (is_string($search_value)) {
	$maps = BeaconMap::GetNamed($search_value);
} else {
	$maps = BeaconMap::GetAll();
}

BeaconAPI::ReplySuccess($maps);

?>