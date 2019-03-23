<?php
	
define('OMNI_PRODUCT_ID', '972f9fc5-ad64-4f9c-940d-47062e705cc5');

$email = $text;
if (filter_var($email, FILTER_VALIDATE_EMAIL) === false) {
	PostReply("Include an email address parameter, like `/grant email@address.com`.");
	return;
}

$database = BeaconCommon::Database();

// get a uuid for this address
$results = $database->Query('SELECT uuid_for_email($1, TRUE) AS email_id;', $email);
$email_id = $results->Field('email_id');

// see if the person already owns Omni
$results = $database->Query('SELECT * FROM purchased_products WHERE purchaser_email = $1 AND product_id = $2;', $email_id, OMNI_PRODUCT_ID);
if ($results->RecordCount() > 0) {
	PostReply("`$email` already owns Omni");
	return;
}

// find the current price of Omni
$results = $database->Query('SELECT retail_price FROM products WHERE product_id = $1;', OMNI_PRODUCT_ID);
$retail_price = $results->Field('retail_price');

// generate the purchase record
$purchase_id = BeaconCommon::GenerateUUID();
$database->BeginTransaction();
$database->Query('INSERT INTO purchases (purchase_id, purchaser_email, subtotal, discount, tax, total_paid, merchant_reference) VALUES ($1, $2, $3, $4, $5, $6, $7);', $purchase_id, $email_id, $retail_price, $retail_price, 0, 0, 'Gift issued from Slack for ' . $email_id);
$database->Query('INSERT INTO purchase_items (purchase_id, product_id, retail_price, discount, quantity, line_total) VALUES ($1, $2, $3, $4, $5, $6);', $purchase_id, OMNI_PRODUCT_ID, $retail_price, $retail_price, 1, 0);
$database->Query('DELETE FROM stw_applicants WHERE email_id = $1;', $email_id);
$database->Commit();

PostReply("`$email` has been granted a copy of Omni");

?>