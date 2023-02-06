<?php

use BeaconAPI\v4\{Response, TemplateSelector};

function handleRequest(array $context): Response {
	return Response::NewJson(TemplateSelector::Search($_GET), 200);
}

?>