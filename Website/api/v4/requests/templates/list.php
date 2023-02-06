<?php

use BeaconAPI\v4\{Response, Template};

function handleRequest(array $context): Response {
	return Response::NewJson(Template::Search($_GET), 200);
}

?>