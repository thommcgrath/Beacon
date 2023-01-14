<?php

function handle_request(array $context): void {
	BeaconAPI::ReplySuccess(Ark\Map::GetAll());
}

?>