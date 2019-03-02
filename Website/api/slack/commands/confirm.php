<?php

$email = $text;
if (filter_var($email, FILTER_VALIDATE_EMAIL) === false) {
	http_response_code(200);
	PostReply("Sorry, I can't do that. Send the request as `/confirm from@address.com`. You sent `/confirm $email`.");
	exit;
}

$database = BeaconCommon::Database();
$code = BeaconCommon::GenerateRandomKey(8);
$database->BeginTransaction();
$database->Query('DELETE FROM email_verification WHERE email_id = uuid_for_email($1);', $email);
$database->Query('INSERT INTO email_verification (email_id, code) VALUES (uuid_for_email($1, TRUE), encode(digest($2, \'sha512\'), \'hex\'));', $email, $code);
$database->Commit();

$link = BeaconCommon::AbsoluteURL('/account/login/?email=' . urlencode($email) . '&code=' . urlencode($code));
PostReply("User's confirmation link is `$link`");

?>