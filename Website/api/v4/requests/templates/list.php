<?php

function handle_request(array $context): void {
	$templates = BeaconAPI\Template::GetAll(\BeaconCommon::MinVersion());
	BeaconAPI::ReplySuccess($templates);
}

?>