<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
	ReplyError("Method not allowed", 405);
}

$has_expanded_parameters = BeaconCommon::HasAnyKeys($_POST, 'user', 'os', 'version', 'build') || isset($_FILES['archive']);
if ($has_expanded_parameters) {
	if (BeaconCommon::HasAllKeys($_POST, 'name', 'email', 'platform', 'host', 'body', 'user', 'os', 'version', 'build') === false || isset($_FILES['archive']) === false) {
		ReplyError("Missing parameters", 400);
	}
} else {
	if (BeaconCommon::HasAllKeys($_POST, 'name', 'email', 'platform', 'host', 'body') === false) {
		ReplyError("Missing parameters", 400);
	}
}

$name = trim($_POST['name']);
$email = trim($_POST['email']);
$platform = trim($_POST['platform']);
$host = trim($_POST['host']);
$body = trim($_POST['body']);

if ($has_expanded_parameters) {
	$user_id = trim($_POST['user']);
	$os = trim($_POST['os']);
	$version = trim($_POST['version']);
	$build = trim($_POST['build']);
	
	if (BeaconUser::ValidateEmail($email) === false) {
		ReplyError('Could not validate email address', 400);
	}
}

$platform_map = [
	'Steam' => 'pc_/_steam',
	'Epic' => 'epic',
	'Xbox' => 'xbox_/_windows_store',
	'PlayStation' => 'playstation',
	'Other' => 'switch_/_mobile_/_other'
];

if (array_key_exists($platform, $platform_map) === false) {
	ReplyError("Unknown platform $platform", 400);
}

if ($has_expanded_parameters && is_uploaded_file($_FILES['archive']['tmp_name']) === false) {
	ReplyError('Unable to receive archive', 400);
}

$custom_fields = [
	[
		'id' => 360019496992,
		'value' => $platform_map[$platform]
	],
	[
		'id' => 360019555031,
		'value' => $host
	],
];
if ($has_expanded_parameters) {
	$custom_fields[] = [
		'id' => 360033875991,
		'value' => $build
	];
	$custom_fields[] = [
		'id' => 360033879592,
		'value' => $version
	];
	$custom_fields[] = [
		'id' => 360033879552,
		'value' => $user_id
	];
	$custom_fields[] = [
		'id' => 360033879572,
		'value' => $os
	];
}
if (isset($_POST['archive_key'])) {
	$custom_fields[] = [
		'id' => 360041678091,
		'value' => $_POST['archive_key']
	];
}

$user = null;
$email_id = null;
$user_has_omni = false;
$email_has_omni = false;
$user_matches_purchase = false;

$omni_description = '';
if ($has_expanded_parameters) {
	$database = BeaconCommon::Database();
	$results = $database->Query('SELECT purchaser_email FROM purchases INNER JOIN purchase_items ON (purchases.purchase_id = purchase_items.purchase_id) WHERE purchases.refunded = FALSE AND purchase_items.product_id = $2 AND purchases.purchaser_email = uuid_for_email($1);', $email, '972f9fc5-ad64-4f9c-940d-47062e705cc5');
	if ($results->RecordCount() >= 1) {
		$email_has_omni = true;
		$email_id = $results->Field('purchaser_email');
	}
	
	try {
		$user = BeaconUser::GetByUserID($user_id);
		if (is_null($user) === false) {
			$user_has_omni = $user->OmniVersion() >= 1;
			$user_matches_purchase = $user->EmailID() === $email_id;
		}
	} catch (Exception $e) {
	}
	
	if ($user_has_omni) {
		$omni_description = "\n\nHas Omni: Yes.";
	} elseif ($email_has_omni) {
		$omni_description = "\n\nHas Omni: Maybe. The email address has a valid purchase, but the user account has a different email address.";
	}
	
	$attachment_token = null;
	$curl = curl_init('https://thezaz.zendesk.com/api/v2/uploads.json?filename=' . urlencode($_FILES['archive']['name']));
	curl_setopt($curl, CURLOPT_USERPWD, BeaconCommon::GetGlobal('ZenDesk_Username') . ":" . BeaconCommon::GetGlobal('ZenDesk_Password'));
	curl_setopt($curl, CURLOPT_POSTFIELDS, file_get_contents($_FILES['archive']['tmp_name']));
	curl_setopt($curl, CURLOPT_CUSTOMREQUEST, 'POST');
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($curl, CURLOPT_HTTPHEADER, array('Content-Type: application/binary'));
	$zendesk_body = curl_exec($curl);
	unlink($_FILES['archive']['tmp_name']);
	
	$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
	if ($status == 201) {
		$response = json_decode($zendesk_body, true);
		$attachment_token = $response['upload']['token'];
	} else {
		ReplyError('Unable to upload to ZenDesk', 500, $zendesk_body);
	}
} else {
	$user = BeaconUser::GetByEmail($email);
	if (is_null($user) === false && $user->OmniVersion() >= 1) {
		$omni_description = "\n\nHas Omni: Yes.";
	}
}

$ticket = [
	'ticket' => [
		'custom_fields' => $custom_fields,
		'requester' => [
			'locale_id' => 1,
			'name' => $name,
			'email' => $email
		],
		'comment' => [
			'body' => $body . $omni_description,
		]
	]
];
if ($has_expanded_parameters) {
	$ticket['ticket']['comment']['uploads'] = [$attachment_token];	
}
$curl = curl_init('https://thezaz.zendesk.com/api/v2/tickets.json');
curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($ticket));
curl_setopt($curl, CURLOPT_CUSTOMREQUEST, 'POST');
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
curl_setopt($curl, CURLOPT_HTTPHEADER, array('Content-Type: application/json'));
curl_setopt($curl, CURLOPT_USERPWD, BeaconCommon::GetGlobal('ZenDesk_Username') . ":" . BeaconCommon::GetGlobal('ZenDesk_Password'));
$zendesk_body = curl_exec($curl);

$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
if ($status == 201) {
	http_response_code(201);
	echo json_encode(['error' => false, 'message' => 'Ticked Created', 'detail' => null], JSON_PRETTY_PRINT);
	exit;
} else {
	ReplyError('Unable to create ticket with ZenDesk', 500, $zendesk_body);
}

function ReplyError(string $message, int $code, $detail = null) {
	http_response_code($code);
	echo json_encode(['error' => true, 'message' => $message, 'detail' => $detail], JSON_PRETTY_PRINT);
	exit;
}

?>