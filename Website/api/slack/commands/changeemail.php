<?php
	
// /changeemail from@address.com to@address.com
	
if (strpos($text, ' ') === false) {
	PostReply("Incorrect number of parameters. Use `/changeemail from@address.com to@address.com`.");
	return;
}

list($from_address, $to_address) = explode(' ', $text);
if (filter_var($from_address, FILTER_VALIDATE_EMAIL) === false || filter_var($to_address, FILTER_VALIDATE_EMAIL) === false) {
	PostReply("One or both parameters are not email addresses.");
	return;
}

$database = BeaconCommon::Database();
$results = $database->Query('SELECT uuid_for_email($1) AS email_id;', $from_address);
$old_email_id = $results->Field('email_id');
if (is_null($old_email_id)) {
	PostReply("Nothing is registered to `$from_address`.");
	return;
}

try {
	$database->BeginTransaction();
	$results = $database->Query('SELECT uuid_for_email($1, TRUE) AS email_id;', $to_address);
	$new_email_id = $results->Field('email_id');
	$database->Query('UPDATE purchases SET purchaser_email = $1 WHERE purchaser_email = $2;', $new_email_id, $old_email_id);
	$database->Query('DELETE FROM email_verification WHERE email_id = $1;', $old_email_id);
	$results = $database->Query('SELECT applicant_id FROM stw_applicants WHERE email_id = $1;', $new_email_id);
	if ($results->RecordCount() == 0) {
		$encrypted_email = BeaconEncryption::BlowfishEncrypt(BeaconCommon::GetGlobal('Email_Encryption_Key'), $to_address);
		$database->Query('UPDATE stw_applicants SET email_id = $1, encrypted_email = $2 WHERE email_id = $3;', $new_email_id, bin2hex($encrypted_email), $old_email_id);
	}
	$results = $database->Query('SELECT user_id FROM users WHERE email_id = $1;', $new_email_id);
	if ($results->RecordCount() == 0) {
		$database->Query('UPDATE users SET email_id = $1 WHERE email_id = $2;', $new_email_id, $old_email_id);
	}
	$database->Query('DELETE FROM email_addresses WHERE email_id = $1;', $old_email_id);
	$database->Commit();
} catch (Exception $e) {
	PostReply("I can't do that: {$e->getMessage()}");
	exit;
}

PostReply("All references to `$from_address` have been changed to `$to_address`.");
return;

?>