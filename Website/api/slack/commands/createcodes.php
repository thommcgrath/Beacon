<?php

define('USAGE_HINT', '/createcodes 10 ark user@domain.com Because I said so');

if (strpos($text, ' ') === false) {
	PostReply("You need more parameters.");
	return;
}
list($num_codes, $gameid, $email, $reason) = explode(' ', $text, 4);

$num_codes = intval($num_codes);
if ($num_codes <= 0) {
	PostReply("It doesn't really make sense to ask for $num_codes codes. Try something like `" . USAGE_HINT . '`.');
	return;
}
if (filter_var($email, FILTER_VALIDATE_EMAIL) === false) {
	PostReply('Include an email address parameter, like `' . USAGE_HINT . '`.');
	return;
}
$reason = trim($reason);
if (empty($reason)) {
	PostReply('You need to give a reason for the codes, like `' . USAGE_HINT . '`.');
	return;
}
$gameid = strtolower($gameid);
switch ($gameid) {
case 'ark':
	$product_id = BeaconShop::ARK_GIFT_ID;
	break;
case 'ark2':
	$product_id = BeaconShop::ARK2_GIFT_ID;
	break;
default:
	PostReply('Invalid game id, try `' . USAGE_HINT . '`.');
	return;
}

BeaconShop::CreateGiftPurchase($email, $product_id, $num_codes, $reason, true);

PostReply('Codes have been issued to ' . $email . '.');

?>