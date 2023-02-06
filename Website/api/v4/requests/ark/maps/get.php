<?php

function handleRequest(array $context): Response {
	$map_id = $context['pathParameters']['map_id'];
	if (is_numeric($map_id)) {
		$maps = Ark\Map::GetForMask($map_id);
	} elseif (BeaconCommon::IsUUID($map_id)) {
		$maps = Ark\Map::GetForMapID($map_id);
	} else {
		$maps = Ark\Map::GetNamed($map_id);
	}
	BeaconAPI::ReplySuccess($maps);
}

?>