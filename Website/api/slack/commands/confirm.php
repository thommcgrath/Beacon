<?php

$link = BeaconLogin::GenerateVerificationLink($text);
if (is_null($link)) {
	http_response_code(200);
	PostReply("Sorry, I can't do that. Send the request as `/confirm from@address.com`. You sent `/confirm $text`.");
	exit;
}

PostReply("User's confirmation link is `$link`");

?>