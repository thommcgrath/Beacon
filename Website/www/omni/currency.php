<?php

header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

require(dirname(__FILE__, 3) . '/framework/loader.php');

BeaconCommon::StartSession();
	
$currency_options = BeaconShop::GetCurrencyOptions();
	
if (isset($_GET['currency']) === false) {
	http_response_code(400);
	echo json_encode(['error' => true, 'message' => 'Did not specify a new currency.'], JSON_PRETTY_PRINT);
	exit;
}

$currency = BeaconShop::SetCurrency(strtoupper($_GET['currency']));

http_response_code(200);
echo json_encode(['error' => false, 'message' => 'Currency changed to ' . $currency], JSON_PRETTY_PRINT);

?>
