<?php

function handleRequest(array $context): Response {
	BeaconAPI::ReplySuccess(Ark\Map::GetAll());
}

?>