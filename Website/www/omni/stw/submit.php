<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');
header('Content-Type: application/json');

BeaconCommon::StartSession();
if (!isset($_SESSION['STW_PRIVATE_KEY']) || !isset($_POST['email']) || !isset($_POST['product_id'])) {
	http_response_code(400);
	echo json_encode(array('error' => 'Invalid request.'));
	exit;
}
$private_key = $_SESSION['STW_PRIVATE_KEY'];
$encrypted_email = base64_decode($_POST['email']);
$product_id = $_POST['product_id'];

// Decrypt the address using the private key set by the calling script
try {
	$decrypted_email = BeaconEncryption::RSADecrypt($private_key, $encrypted_email, false);
	$encrypted_email = null;
} catch (Exception $e) {
	http_response_code(400);
	echo json_encode(array('error' => 'Unable to verify email address.'));
	exit;
}

// Make sure it looks like an email address
if (!filter_var($decrypted_email, FILTER_VALIDATE_EMAIL)) {
	http_response_code(400);
	echo json_encode(array('error' => 'Submitted address is not an email address.'));
	exit;
}

// Make sure the product looks valid
if (BeaconCommon::IsUUID($product_id) === false) {
	http_response_code(400);
	echo json_encode(array('error' => 'Invalid product code.'));
	exit;
}

// Do a quick verify of the address
$verified = BeaconEmail::QuickVerify($decrypted_email);
if ($verified === false) {
	http_response_code(400);
	echo json_encode(array('error' => 'Email address does not appear to be correct. Check the address and try again. If this is an error, create an account first to skip this check.'));
	exit;
}

// See if the user already owns Omni, no reason to put them on the list if they do.
$database = BeaconCommon::Database();
$results = $database->Query('SELECT product_id FROM purchased_products WHERE purchaser_email = uuid_for_email($1) AND product_id = $2 AND (expiration IS NULL OR expiration > CURRENT_TIMESTAMP);', $decrypted_email, $product_id);
if ($results->RecordCount() >= 1) {
	http_response_code(400);
	echo json_encode(array('error' => 'You already own the selected product.'));
	exit;
}

// Encrypt the address symmetrically
$key = BeaconCommon::GetGlobal('Email_Encryption_Key');
try {
	$encrypted_email = BeaconEncryption::SymmetricEncrypt($key, $decrypted_email);
} catch (Exception $e) {
	http_response_code(400);
	echo json_encode(array('error' => 'Failed to encrypt email address.'));
	exit;
}

// Confirm we can decrypt the email
try {
	$test = BeaconEncryption::SymmetricDecrypt($key, $encrypted_email);
} catch (Exception $e) {
	http_response_code(400);
	echo json_encode(array('error' => 'There was a problem verifying the email address encryption status.'));
	exit;
}

// Put the address onto the list
try {
	$database->BeginTransaction();
	$database->Query('INSERT INTO stw_applicants (encrypted_email, email_id, desired_product) VALUES ($1, uuid_for_email($2, TRUE), $3);', base64_encode($encrypted_email), $decrypted_email, $product_id);
	$database->Commit();
} catch (Exception $e) {
	http_response_code(400);
	$database->BeginTransaction();
	$database->Query('UPDATE stw_applicants SET date_applied = CURRENT_TIMESTAMP WHERE email_id = uuid_for_email($1);', $decrypted_email);
	$database->Commit();
	echo json_encode(array('error' => 'Your address is already on the list. Please be patient.'));
	exit;
}

http_response_code(200);
echo json_encode(array('email' => $decrypted_email));

?>