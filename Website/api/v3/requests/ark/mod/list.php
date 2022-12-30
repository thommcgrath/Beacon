<?php

BeaconAPI::Authorize();
	
function handle_request(array $context): void {
	BeaconAPI::ReplySuccess(Ark\Mod::GetAll(BeaconAPI::UserID()));
}

?>