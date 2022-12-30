<?php

function handle_request(array $context): void {
	$color_sets = Ark\ColorSet::GetAll();
	BeaconAPI::ReplySuccess($color_sets);
}

?>