<?php

function handleRequest(array $context): Response {
	$color_sets = Ark\ColorSet::GetAll();
	BeaconAPI::ReplySuccess($color_sets);
}

?>