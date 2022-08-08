<?php

header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

require(dirname(__FILE__, 3) . '/framework/loader.php');

BeaconCommon::StartSession();
	
if (isset($_GET['currency']) === false) {
	http_response_code(400);
	echo json_encode(['error' => true, 'message' => 'Did not specify a new currency.'], JSON_PRETTY_PRINT);
	exit;
}

if (isset($_SESSION['store_currency_options']) === false) {
	http_response_code(400);
	echo json_encode(['error' => true, 'message' => 'Start from https://usebeacon.app/omni'], JSON_PRETTY_PRINT);
	exit;
}

$currency = strtoupper($_GET['currency']);
if (in_array($currency, $_SESSION['store_currency_options']) === false) {
	$currency = $_SESSION['store_default_currency'];
}

http_response_code(200);
$_SESSION['store_currency'] = $currency;
echo json_encode(['error' => false, 'message' => 'Currency changed to ' . $currency], JSON_PRETTY_PRINT);

?>
