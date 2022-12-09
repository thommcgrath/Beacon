<?php

function handle_request(array $context): void {
	$colors = Ark\Color::GetAll();
	BeaconAPI::ReplySuccess($colors);
}

?>