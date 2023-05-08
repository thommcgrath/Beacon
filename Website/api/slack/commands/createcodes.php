<?php

define('USAGE_HINT', '/createcodes 10 ark user@domain.com Because I said so');

if (strpos($text, ' ') === false) {
	PostReply("You need more parameters.");
	return;
}
list($numCodes, $gameid, $email, $reason) = explode(' ', $text, 4);

$numCodes = intval($numCodes);
if ($numCodes <= 0) {
	PostReply("It doesn't really make sense to ask for $numCodes codes. Try something like `" . USAGE_HINT . '`.');
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

BeaconShop::CreateGiftPurchase($email, $productId, $numCodes, $reason, true);

PostReply('Codes have been issued to ' . $email . '.');

?>