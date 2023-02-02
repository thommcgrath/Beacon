<?php

use BeaconAPI\v4\{APIResponse, Template};

function handleRequest(array $context): APIResponse {
	return APIResponse::NewJSON(Template::Search($_GET), 200);
}

?>