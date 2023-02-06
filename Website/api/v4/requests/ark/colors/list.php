<?php

function handleRequest(array $context): Response {
	$colors = Ark\Color::GetAll();
	BeaconAPI::ReplySuccess($colors);
}

?>