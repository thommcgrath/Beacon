<?php

require(dirname(__FILE__) . '/loader.php');

$method = \BeaconAPI::Method();

switch ($method) {
case 'GET':
	$object_id = \BeaconAPI::ObjectID();
			
	if ($object_id === null) {
		// list all
		$objects = \BeaconAPI\Template::GetAll(\BeaconCommon::MinVersion());
		\BeaconAPI::ReplySuccess($objects);
	} else {
		// specific objects
		$object = \BeaconAPI\Template::GetByObjectID($object_id, \BeaconCommon::MinVersion());
		if (is_null($object)) {
			\BeaconAPI::ReplyError('Object not found', null, 404);
		} else {
			\BeaconAPI::ReplySuccess($object);
		}
	}
	break;
default:
	\BeaconAPI::ReplyError('Method not allowed', null, 405);
	break;
}

?>
