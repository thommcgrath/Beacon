<?php
	
$gameid = 'ark';

if (strpos($text, ' ') !== false) {
	$params = explode(' ', $text);
	$email = $params[0];
	if (count($params) == 2) {
		$gameid = strtolower($params[1]);
	}
} else {
	$email = $text;
}

if (filter_var($email, FILTER_VALIDATE_EMAIL) === false) {
	PostReply("Include an email address parameter, like `/grant email@address.com game_id`.");
	return;
}
$productId = null;
switch ($gameid) {
case 'ark':
case 'Ark':
	$productId = BeaconShop::GetProductByTag('USD', 'Ark', 'Base');
	break;
case 'ark2':
case 'Ark2':
	$productId = BeaconShop::GetProductByTag('USD', 'Arks2', 'Base');
	break;
case 'arkSA':
case 'ArkSA':
	$productId = BeaconShop::GetProductByTag('USD', 'ArkSA', 'Base');
	break;
default:
	PostReply('Unknown game_id value.');
	return;
}

$database = BeaconCommon::Database();

// get a uuid for this address
$database->BeginTransaction();
$results = $database->Query('SELECT uuid_for_email($1, TRUE) AS email_id;', $email);
$database->Commit();
$emailId = $results->Field('email_id');

// see if the person already owns Omni
$results = $database->Query('SELECT expiration FROM purchased_products WHERE purchaser_email = $1 AND product_id = $2;', $emailId, $productId);
if ($results->RecordCount() === 1 && is_null($results->Field('expiration')) === true) {
	PostReply("`$email` already has a perpetual license.");
	return;
}

BeaconShop::CreateGiftPurchase($emailId, $productId, 1, 'Granted by Slack', true);

PostReply("`$email` has been granted a copy of Omni");

?>