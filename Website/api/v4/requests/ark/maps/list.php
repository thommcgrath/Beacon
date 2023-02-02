<?php

function handleRequest(array $context): APIResponse {
	BeaconAPI::ReplySuccess(Ark\Map::GetAll());
}

?>