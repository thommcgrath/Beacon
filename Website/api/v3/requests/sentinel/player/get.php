<?php

BeaconAPI::Authorize();

function handle_request(array $context): void {
	if ($context['route_key'] === 'GET /sentinel/player/{player_id}') {
		$player_id = $context['path_parameters']['player_id'];
		if (\BeaconCommon::IsUUID($player_id)) {
			$player = Sentinel\Player::GetByPlayerID($player_id);
			BeaconAPI::ReplySuccess($player);
			return;
		}
		
		$player_name = $player_id;
		$provider = null;
	} else {
		$player_name = $context['path_parameters']['player_name'];
		$provider = $context['path_parameters']['provider'];
	}
	
	$players = Sentinel\Player::GetByName($player_name, $provider);
	BeaconAPI::ReplySuccess($players);
}

?>