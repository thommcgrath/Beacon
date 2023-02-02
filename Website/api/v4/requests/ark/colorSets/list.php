<?php

function handleRequest(array $context): APIResponse {
	$color_sets = Ark\ColorSet::GetAll();
	BeaconAPI::ReplySuccess($color_sets);
}

?>