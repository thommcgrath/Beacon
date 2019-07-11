<?php

if (strpos($text, ' ') === false) {
	PostReply("You need more parameters.");
	return;
}
list($num_codes, $source) = explode(' ', $text, 2);

$num_codes = intval($num_codes);
if ($num_codes <= 0) {
	PostReply("It doesn't really make sense to ask for $num_codes codes.");
	return;
}
$source = trim($source);
if (empty($source)) {
	PostReply("You need to give a reason for the codes.");
	return;
}

$database = BeaconCommon::Database();
$database->BeginTransaction();
$codes = array();
for ($i = 0; $i < $num_codes; $i++) {
	$code = BeaconCommon::CreateGiftCode();
	$database->Query('INSERT INTO purchase_codes (code, source, purchaser_email_id) VALUES ($1, $2, $3);', $code, $source, '676d972a-9797-4006-b423-b5f34923a5dc');
	$codes[] = $code;
}
$database->Commit();

PostReply("Here are your $num_codes codes: ```" . implode("\n", $codes) . "```");

?>