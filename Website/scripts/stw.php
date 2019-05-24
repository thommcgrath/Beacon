#!/usr/bin/php -q
<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

$database = BeaconCommon::Database();
$results = $database->Query('SELECT stw_id, original_purchase_id FROM stw_purchases WHERE generated_purchase_id IS NULL LIMIT 1;');
if ($results->RecordCount() != 1) {
	echo "No free copies to give away today\n";
	exit;
}
$original_purchase_id = $results->Field('original_purchase_id');
$stw_id = $results->Field('stw_id');

$results = $database->Query('SELECT COUNT(applicant_id) AS applicant_count FROM stw_applicants WHERE generated_purchase_id IS NULL;');
$applicant_count = $results->Field('applicant_count');
if ($applicant_count == 0) {
	echo "All requests have been fulfilled!\n";
	exit;
}

$num = random_int(1, $applicant_count);
$results = $database->Query('SELECT applicant_id, encrypted_email, email_id FROM stw_applicants WHERE generated_purchase_id IS NULL OFFSET $1 LIMIT 1;', $num - 1);
if ($results->RecordCount() == 0) {
	echo "Something went wrong, a winner was not selected.\n";
	exit;
}

$applicant_id = $results->Field('applicant_id');
$email_id = $results->Field('email_id');
try {
	$email = BeaconEncryption::SymmetricDecrypt(BeaconCommon::GetGlobal('Email_Encryption_Key'), base64_decode($results->Field('encrypted_email')));
} catch (Exception $e) {
	echo "Something went wrong, unable to decrypt email address.\n";
	exit;
}

// Make the purchase record in the database
$results = $database->Query('SELECT product_id, retail_price FROM products WHERE product_id = \'972f9fc5-ad64-4f9c-940d-47062e705cc5\';');
$product_id = $results->Field('product_id');
$retail_price = $results->Field('retail_price');
$subtotal = $retail_price;
$total = 0;
$generated_purchase_id = BeaconCommon::GenerateUUID();
$database->BeginTransaction();
$database->Query('INSERT INTO purchases (purchase_id, purchaser_email, subtotal, discount, tax, total_paid, merchant_reference) VALUES ($1, $2, $3, $4, $5, $6, $7);', $generated_purchase_id, $email_id, $subtotal, $subtotal - $total, 0, $total, 'STW ' . $applicant_id);
$database->Query('INSERT INTO purchase_items (purchase_id, product_id, retail_price, discount, quantity, line_total) VALUES ($1, $2, $3, $4, $5, $6);', $generated_purchase_id, $product_id, $retail_price, $retail_price, 1, 0);
$database->Query('UPDATE stw_applicants SET generated_purchase_id = $2, encrypted_email = NULL WHERE applicant_id = $1;', $applicant_id, $generated_purchase_id);
$database->Query('UPDATE stw_purchases SET generated_purchase_id = $2 WHERE stw_id = $1;', $stw_id, $generated_purchase_id);
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
$sender = '"Beacon Share The Wealth" <forgotmyparachute@beaconapp.cc>';
$body = "Beacon Share The Wealth is a program that allows buyers of Beacon Omni to gift free copies to random strangers, and today you're the lucky recipient! Really, there's no strings attached!\n\n$instruction_text\n\n<$link_url>\n\nIf you have any questions, feel free to respond to this email.";
$notified = BeaconEmail::SendMail($email, $subject, $body);

// Notify slack maybe?
if ($notified) {
	BeaconCommon::PostSlackMessage("`$email` has been selected as today's Share The Wealth winner!");
} else {
	BeaconCommon::PostSlackMessage("`$email` has been selected as today's Share The Wealth winner, but an automated email was not sent.");
}

echo "Winner is $email!\n";
exit;

?>