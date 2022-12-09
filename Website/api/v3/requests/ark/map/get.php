<?php

function handle_request(array $context): void {
	$map_id = $context['path_parameters']['map_id'];
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