<?php

BeaconAPI::Authorize();

function handle_request(array $context): void {
	if (isset($_GET['player_id'])) {
		$player_id = trim($_GET['player_id']);
		$player = Sentinel\Player::GetByPlayerID($player_id);
		BeaconAPI::ReplySuccess($player);
	} elseif (isset($_GET['player_name'])) {
		$player_name = trim($_GET['player_name']);
		if (isset($_GET['provider'])) {
			$provider = trim($_GET['provider']);
		} else {
			$provider = null;
		}
		$players = Sentinel\Player::GetByName($player_name, $provider);
		BeaconAPI::ReplySuccess($players);
	} else {
		BeaconAPI::ReplyError('Bad request', null, 400);
	}
}

?>