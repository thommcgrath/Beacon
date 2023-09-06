<?php
	
// /changeemail from@address.com to@address.com

use BeaconAPI\v4\{EmailVerificationCode, User};
	
if (strpos($text, ' ') === false) {
	PostReply("Incorrect number of parameters. Use `/changeemail from@address.com to@address.com`.");
	return;
}

list($from_address, $toAddress) = explode(' ', $text);
if (filter_var($from_address, FILTER_VALIDATE_EMAIL) === false || filter_var($toAddress, FILTER_VALIDATE_EMAIL) === false) {
	PostReply("One or both parameters are not email addresses.");
	return;
}

$database = BeaconCommon::Database();
$results = $database->Query('SELECT uuid_for_email($1) AS email_id;', $from_address);
$oldEmailId = $results->Field('email_id');
if (is_null($oldEmailId)) {
	PostReply("Nothing is registered to `$from_address`.");
	return;
}

try {
	$results = $database->Query('SELECT merchant_reference FROM purchases WHERE purchaser_email = $1;', $oldEmailId);
	$stripeApi = null;
	while (!$results->EOF()) {
		$merchantReference = $results->Field('merchant_reference');
		if (substr($merchantReference, 0, 3) == 'pi_') {
			if (is_null($stripeApi)) {
				$stripeApi = new BeaconStripeAPI(BeaconCommon::GetGlobal('Stripe_Secret_Key'));
			}
			if (!$stripeApi->ChangeEmailForPaymentIntent($merchantReference, $toAddress)) {
				PostReply("I could not change the email address of PaymentIntent `$merchantReference`.");
				exit;
			}
		}
		$results->MoveNext();
	}
	
	$database->BeginTransaction();
	$results = $database->Query('SELECT uuid_for_email($1, TRUE) AS email_id;', $toAddress);
	$newEmailId = $results->Field('email_id');
	if ($newEmailId == $oldEmailId) {
		$database->Rollback();
		PostReply("Uh.... both addresses are the same.");
		exit;
	}
	$database->Query('UPDATE purchases SET purchaser_email = $1 WHERE purchaser_email = $2;', $newEmailId, $oldEmailId);
	$database->Query('DELETE FROM public.email_verification_codes WHERE email_id = $1;', $oldEmailId);
	
	$results = $database->Query('SELECT user_id FROM users WHERE email_id = $1;', $newEmailId);
	if ($results->RecordCount() == 0) {
		$database->Query('UPDATE users SET email_id = $1 WHERE email_id = $2;', $newEmailId, $oldEmailId);
	}
	$database->Query('DELETE FROM email_addresses WHERE email_id = $1;', $oldEmailId);
	$database->Commit();
	
	$user = User::Fetch($toAddress);
	if (is_null($user)) {
		EmailVerificationCode::Create($toAddress);
	}
} catch (Exception $e) {
	PostReply("I can't do that: {$e->getMessage()}");
	exit;
}

PostReply("All references to `$from_address` have been changed to `$toAddress`.");
return;

?>
