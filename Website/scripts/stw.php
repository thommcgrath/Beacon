#!/usr/bin/php -q
<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

$database = BeaconCommon::Database();
	
// Clear out old requests
$database->BeginTransaction();
$database->Query('DELETE FROM stw_applicants WHERE generated_purchase_id IS NULL AND CURRENT_TIMESTAMP - date_applied > $1::INTERVAL;', '6 months');
$database->Commit();

$purchase_count = GetPurchaseCount($database);
if ($purchase_count === 0) {
	echo "No free copies to give away today\n";
	exit;
}

$results = $database->Query('SELECT stw_id, original_purchase_id FROM stw_purchases WHERE generated_purchase_id IS NULL LIMIT 1;');
if ($results->RecordCount() != 1) {
	echo "No free copies to give away today\n";
	exit;
}
$original_purchase_id = $results->Field('original_purchase_id');
$stw_id = $results->Field('stw_id');

$applicant_count = GetApplicantCount($database);
if ($applicant_count == 0) {
	echo "All requests have been fulfilled!\n";
	exit;
}

$num = random_int(1, $applicant_count);
$results = $database->Query('SELECT applicant_id, encrypted_email, email_id, desired_product FROM stw_applicants WHERE generated_purchase_id IS NULL OFFSET $1 LIMIT 1;', $num - 1);
if ($results->RecordCount() == 0) {
	BeaconCommon::PostSlackMessage("Failed to select a STW winner.");
	echo "Something went wrong, a winner was not selected.\n";
	exit;
}

$applicant_id = $results->Field('applicant_id');
$email_id = $results->Field('email_id');
$product_id = $results->Field('desired_product');
try {
	$email = BeaconEncryption::SymmetricDecrypt(BeaconCommon::GetGlobal('Email_Encryption_Key'), base64_decode($results->Field('encrypted_email')));
} catch (Exception $e) {
	echo "Something went wrong, unable to decrypt email address.\n";
	exit;
}

// Make the purchase record in the database
$database->BeginTransaction();
$generated_purchase_id = BeaconShop::CreateGiftPurchase($email_id, $product_id, 1, 'STW Winner', false);
$database->Query('UPDATE stw_applicants SET generated_purchase_id = $2, encrypted_email = NULL WHERE applicant_id = $1;', $applicant_id, $generated_purchase_id);
$database->Query('UPDATE stw_purchases SET generated_purchase_id = $2 WHERE stw_id = $1;', $stw_id, $generated_purchase_id);
$database->Query('UPDATE purchases SET merchant_reference = $2 WHERE purchase_id = $1;', $generated_purchase_id, $original_purchase_id);
BeaconShop::IssuePurchases($generated_purchase_id);
	
// Check the applicant and purchase count before committing
$new_applicant_count = GetApplicantCount($database);
$new_purchase_count = GetPurchaseCount($database);
if (($new_applicant_count !== $applicant_count - 1) || ($new_purchase_count !== $purchase_count - 1)) {
	echo "Sanity check failed.\n";
	BeaconCommon::PostSlackMessage("STW sanity check failed. New applicant and/or purchase counts don't make sense.");
	$database->Rollback();
	exit;
}

$database->Commit();

// See if the recipient already has an account
$link_url = '/account/login/?return=' . urlencode(BeaconCommon::AbsoluteURL('/account/#omni'));
$results = $database->Query('SELECT user_id FROM users WHERE email_id = $1;', $email_id);
if ($results->RecordCount() == 0) {
	$link_url .= '&email=' . urlencode($email) . '#create';
	$instruction_text = "You will need to create an account with the email address <$email> using the link below. Once you've created your account, setup instructions should be shown to you under the 'Omni' header in your account control panel. The link will take you there automatically after account creation.";
} else {
	$link_url .= '&email=' . urlencode($email);
	$instruction_text = "Since you already have an account with Beacon, just sign into your account control panel using the link below and look in the 'Omni' header for setup instructions.";
}
$link_url = BeaconCommon::AbsoluteURL($link_url);

// Send the recipient an email
$subject = "You've been given a free copy of Beacon Omni!";
$sender = '"Beacon Share The Wealth" <help@' . BeaconCommon::Domain() . '>';
$body = "Beacon Share The Wealth is a program that allows buyers of Beacon Omni to gift free copies to random strangers, and today you're the lucky recipient! Really, there's no strings attached!\n\n$instruction_text\n\n<$link_url>\n\nIf you have any questions, feel free to respond to this email.";
$notified = BeaconEmail::SendMail($email, $subject, $body);

// Build the status
$status = '';
if ($new_applicant_count === 1) {
	$status = 'There is 1 applicant remaining';
} else {
	$status = 'There are ' . $new_applicant_count . ' applicants remaining';
}
if ($new_purchase_count === 1) {
	$status .= ' and 1 purchase waiting to be awarded.';
} else {
	$status .= ' and ' . $new_purchase_count . ' purchases waiting to be awarded.';
}

// Notify slack maybe?
if ($notified) {
	BeaconCommon::PostSlackMessage("`$email` has been selected as today's Share The Wealth winner! $status");
} else {
	BeaconCommon::PostSlackMessage("`$email` has been selected as today's Share The Wealth winner, but an automated email was not sent. $status");
}

echo "Winner is $email!\n";
exit;

function GetPurchaseCount(BeaconDatabase $database): int {
	$results = $database->Query('SELECT COUNT(stw_id) AS purchase_count FROM stw_purchases WHERE generated_purchase_id IS NULL;');
	return $results->Field('purchase_count');
}

function GetApplicantCount(BeaconDatabase $database): int {
	$results = $database->Query('SELECT COUNT(applicant_id) AS applicant_count FROM stw_applicants WHERE generated_purchase_id IS NULL;');
	return $results->Field('applicant_count');
}

?>
