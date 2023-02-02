<?php

function handleRequest(array $context): APIResponse {
	$colors = Ark\Color::GetAll();
	BeaconAPI::ReplySuccess($colors);
}

?>