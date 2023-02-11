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

$email = strtolower(trim($_POST['email'] ?? ''));
if (empty($email) || BeaconEmail::IsEmailValid($email) === false) {
	http_response_code(400);
	echo json_encode(['error' => true, 'message' => 'Missing email parameter.'], JSON_PRETTY_PRINT);
	exit;
}
$currency = 'USD';

$ark_qty = (isset($_POST['ark']) && filter_var($_POST['ark'], FILTER_VALIDATE_BOOLEAN) === true) ? 1 : 0;
$ark_gift_qty = isset($_POST['ark_gift']) ? min(intval($_POST['ark_gift']), 10) : 0;
$ark2_qty = (isset($_POST['ark2']) && filter_var($_POST['ark2'], FILTER_VALIDATE_BOOLEAN) === true) ? 1 : 0;
$ark2_gift_qty = isset($_POST['ark2_gift']) ? min(intval($_POST['ark2_gift']), 10) : 0;
$stw_qty = isset($_POST['stw']) ? min(intval($_POST['stw']), 10) : 0;
if ($ark_qty + $ark_gift_qty + $ark2_qty + $ark2_gift_qty + $stw_qty === 0) {
	http_response_code(400);
	echo json_encode(['error' => true, 'message' => 'Did not choose anything to purchase.'], JSON_PRETTY_PRINT);
	exit;
}

if (isset($_COOKIE['beacon_affiliate'])) {
	$client_reference_id = $_COOKIE['beacon_affiliate'];
	
	$database = BeaconCommon::Database();
	$rows = $database->Query('SELECT purchase_id, code FROM affiliate_tracking WHERE client_reference_id = $1;', $client_reference_id);
	if ($rows->RecordCount() === 1 && is_null($rows->Field('purchase_id')) === false) {
		// need a new id
		$client_reference_id = BeaconShop::TrackAffiliateClick($rows->Field('code'));
	}
} else {
	$client_reference_id = BeaconCommon::GenerateUUID();
}

$payment = [
	'client_reference_id' => $client_reference_id,
	'payment_method_types' => [
		'card',
		'ideal',
		'giropay',
		'bancontact',
		'p24',
		'eps'
	],
	'mode' => 'payment',
	'success_url' => BeaconCommon::AbsoluteURL('/omni/welcome/'),
	'cancel_url' => BeaconCommon::AbsoluteURL('/omni/#checkout'),
	'billing_address_collection' => 'required',
	'automatic_tax' => ['enabled' => 'true'],
	'line_items' => [],
];

$user = null;
try {
	$user = BeaconUser::GetByEmail($email);
	if (is_null($user) === false) {
		$payment['metadata']['Beacon User UUID'] = $user->UserID();
		
		if ($ark_qty > 0) {
			$ark_license = $user->LicenseInfo(BeaconShop::ARK_PRODUCT_ID);
			if (is_null($ark_license) === false) {
				if ($ark_gift_qty === 0 && $ark2_qty === 0 && $ark2_gift_qty === 0 && $stw_qty === 0) {
					echo json_encode(['error' => true, 'message' => 'User already owns Omni.'], JSON_PRETTY_PRINT);
					exit;
				}
				$ark_qty = 0;
			}
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
	} else {
		$customerId = $api->CreateCustomer($email);
		$payment['customer'] = $customerId;
	}
	$payment['customer_update'] = ['address' => 'auto', 'name' => 'auto'];
} catch (Exception $err) {
	$payment['customer_email'] = $email;
}

$items = [
	BeaconShop::ARK_PRODUCT_ID => $ark_qty,
	BeaconShop::ARK_GIFT_ID => $ark_gift_qty,
	BeaconShop::ARK2_PRODUCT_ID => $ark2_qty,
	BeaconShop::ARK2_GIFT_ID => $ark2_gift_qty,
	BeaconShop::STW_ID => $stw_qty
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
