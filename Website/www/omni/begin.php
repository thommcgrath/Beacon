<?php

header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

require(dirname(__FILE__, 3) . '/framework/loader.php');

BeaconCommon::StartSession();

if (strtoupper($_SERVER['REQUEST_METHOD']) !== 'POST') {
	http_response_code(405);
	echo json_encode(['error' => true, 'message' => 'Method not allowed.'], JSON_PRETTY_PRINT);
	exit;
}

if (isset($_SESSION['store_currency']) === false) {
	http_response_code(400);
	echo json_encode(['error' => true, 'message' => 'Start from https://usebeacon.app/omni'], JSON_PRETTY_PRINT);
	exit;
}

if (empty($_POST['email'])) {
	http_response_code(400);
	echo json_encode(['error' => true, 'message' => 'Missing email parameter.'], JSON_PRETTY_PRINT);
	exit;
}
$email = strtolower(trim($_POST['email']));
$currency = strtoupper($_SESSION['store_currency']);

$omni_qty = (isset($_POST['omni']) && boolval($_POST['omni']) === true) ? 1 : 0;
$stw_qty = isset($_POST['stw']) ? min(intval($_POST['stw']), 10) : 0;
$gift_qty = isset($_POST['gift']) ? min(intval($_POST['gift']), 10) : 0;
if ($omni_qty + $stw_qty + $gift_qty === 0) {
	http_response_code(400);
	echo json_encode(['error' => true, 'message' => 'Did not choose anything to purchase.'], JSON_PRETTY_PRINT);
	exit;
}

$client_reference_id = BeaconCommon::GenerateUUID();
$payment = [
	'client_reference_id' => $client_reference_id,
	'customer_email' => $email,
	'payment_method_types' => ['card'],
	'mode' => 'payment',
	'success_url' => BeaconCommon::AbsoluteURL('/omni/welcome/'),
	'cancel_url' => BeaconCommon::AbsoluteURL('/omni/#checkout'),
	'billing_address_collection' => 'required',
	'line_items' => []
];
if ($currency === 'EUR') {
	$payment['payment_method_types'][] = 'ideal';
	$payment['payment_method_types'][] = 'giropay';
	$payment['payment_method_types'][] = 'bancontact';
	$payment['payment_method_types'][] = 'p24';
	$payment['payment_method_types'][] = 'eps';
}

$user = null;
try {
	$user = BeaconUser::GetByEmail($email);
	if (is_null($user) === false) {
		$payment['metadata']['Beacon User UUID'] = $user->UserID();
		
		if ($user->OmniVersion() >= 1) {
			if ($omni_qty > 0 && $stw_qty == 0 && $gift_qty == 0 && $user->OmniVersion() >= 1) {
				http_response_code(400);
				echo json_encode(['error' => true, 'message' => 'User already owns Omni.'], JSON_PRETTY_PRINT);
				exit;
			}
			
			$omni_qty = 0;
		}
	}
} catch (Exception $err) {
}

try {
	if (is_null($user)) {
		$url = 'https://api.cleantalk.org/?method_name=email_check&auth_key=' . urlencode(BeaconCommon::GetGlobal('CleanTalk Email Check Key')) . '&email=' . urlencode($email);
		$curl = curl_init($url);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		$body = curl_exec($curl);
		$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		if ($status === 200) {
			$parsed = json_decode($body, TRUE);
			$data = $parsed['data'];
			$result = $data[$email]['result'];
			switch ($result) {
			case 'NOT_EXISTS':
			case 'MX_FAIL':
			case 'MX_FAIL':
				// Confirmed failure
				http_response_code(400);
				echo json_encode(['error' => true, 'message' => 'We were unable to verify that your email address exists. This is probably due to a typo, but if we are wrong, create an account to skip this check.'], JSON_PRETTY_PRINT);
				exit;
			}
		}
	}
} catch (Exception $err) {
}

$api = new BeaconStripeAPI(BeaconCommon::GetGlobal('Stripe_Secret_Key'));
try {
	$customers = $api->GetCustomersByEmail($email);
	if (is_null($customers) === false && is_array($customers) && array_key_exists('data', $customers) && count($customers['data']) >= 1) {
		$customer = $customers['data'][0];
		$payment['customer'] = $customer['id'];
		unset($payment['customer_email']);
	}
} catch (Exception $err) {
}

$items = [
	'972f9fc5-ad64-4f9c-940d-47062e705cc5' => $omni_qty,
	'f2a99a9e-e27f-42cf-91a8-75a7ef9cf015' => $stw_qty,
	'2207d5c1-4411-4854-b26f-bc4b48aa33bf' => $gift_qty
];
foreach ($items as $uuid => $quantity) {
	$line_item = createLineItem($uuid, $currency, $quantity);
	if (is_null($line_item) === false) {
		$payment['line_items'][] = $line_item;
	}
}

$session = $api->CreateCheckoutSession($payment);
if (is_null($session)) {
	http_response_code(400);
	echo json_encode(['error' => true, 'message' => 'Was not able to create the checkout session.'], JSON_PRETTY_PRINT);
	exit;
}

http_response_code(200);
echo json_encode([
	'error' => false,
	'client_reference_id' => $client_reference_id,
	'url' => $session['url']
], JSON_PRETTY_PRINT);

function createLineItem(string $uuid, string $currency, int $quantity) {
	if ($quantity <= 0) {
		return null;
	}
	
	$database = BeaconCommon::Database();
	$rows = $database->Query('SELECT price_id FROM product_prices WHERE product_id = $1 AND currency = $2;', $uuid, $currency);
	if ($rows->RecordCount() === 0) {
		return null;
	}
	
	return [
		'price' => $rows->Field('price_id'),
		'quantity' => $quantity
	];
}

?>
