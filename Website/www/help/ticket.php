<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
	ReplyError("Method not allowed.", 405);
}

$has_expanded_parameters = BeaconCommon::HasAnyKeys($_POST, 'user', 'os', 'version', 'build') || isset($_FILES['archive']);
if ($has_expanded_parameters) {
	if (BeaconCommon::HasAllKeys($_POST, 'name', 'email', 'platform', 'host', 'body', 'user', 'os', 'version', 'build') === false || isset($_FILES['archive']) === false) {
		ReplyError("Missing parameters.", 400);
	}
} else {
	if (BeaconCommon::HasAllKeys($_POST, 'name', 'email', 'platform', 'host', 'body', 'timestamp', 'hash') === false) {
		ReplyError("Missing parameters.", 400);
	}
}

$name = trim($_POST['name']);
$email = trim($_POST['email']);
$platform = trim($_POST['platform']);
$host = trim($_POST['host']);
$body = trim($_POST['body']);
if (strlen($body) < 60) {
	ReplyError('Please include a more detailed description of your issue.', 400);
}

if (BeaconUser::ValidateEmail($email) === false) {
	ReplyError('Could not validate email address.', 400);
}

$database = BeaconCommon::Database();
$results = $database->Query('SELECT uuid_for_email($1, TRUE) AS email_id;', $email);
$email_id = $results->Field('email_id');
	
$user = null;
if ($has_expanded_parameters) {
	$user_id = trim($_POST['user']);
	$user = BeaconUser::GetByUserID($user_id);
	$os = trim($_POST['os']);
	$version = trim($_POST['version']);
	$build = trim($_POST['build']);
	$time_submitting = 15; // Just make something up.
} else {
	$timestamp = intval($_POST['timestamp']);
	$min_timestamp = $timestamp + 60;
	$max_timestamp = $timestamp + 3600;
	$current_timestamp = time();
	$time_submitting = $current_timestamp - $timestamp;
	if ($current_timestamp < $min_timestamp || $current_timestamp > $max_timestamp) {
		ReplyError('Ticket was submitted too quickly.', 400);
	}
	
	$provided_hash = trim($_POST['hash']);
	$psk = BeaconCommon::GetGlobal('Support Ticket Key');
	$required_hash = hash('sha256', $timestamp . $psk);
	if ($provided_hash !== $required_hash) {
		ReplyError('Invalid parameters.', 400);
	}
}
if (is_null($user)) {
	$user = BeaconUser::GetByEmailID($email_id);
}

$platform_map = [
	'Steam' => 'pc_/_steam',
	'Epic' => 'epic',
	'Xbox' => 'xbox_/_windows_store',
	'PlayStation' => 'playstation',
	'Other' => 'switch_/_mobile_/_other'
];

if (array_key_exists($platform, $platform_map) === false) {
	ReplyError("Unknown platform $platform.", 400);
}

if ($has_expanded_parameters && is_uploaded_file($_FILES['archive']['tmp_name']) === false) {
	ReplyError('Unable to receive archive.', 400);
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
if (is_null($user) === false) {
	$custom_fields[] = [
		'id' => 360033879552,
		'value' => $user->UserID()
	];
}
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

$licenses = [];
if (is_null($user) === false) {
	$licenses = GetLicensesForEmailID($user->EmailID());
	if ($email_id !== $user->EmailID()) {
		$licenses = array_merge($licenses, GetLicensesForEmailID($email_id));
	}
} else {
	$licenses = GetLicensesForEmailID($email_id);
}
if (count($licenses) > 0) {
	$omni_description = "\n\nLicenses:\n" . implode("\n", $licenses);
} else {
	$omni_description = '';
}

if ($has_expanded_parameters) {
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
		ReplyError('Unable to upload to ZenDesk.', 500, $zendesk_body);
	}
}

if (is_null($user)) {
	// Pass to CleanTalk for spam detection
	$spam = [
		'method_name' => 'check_message',
		'auth_key' => BeaconCommon::GetGlobal('CleanTalk Auth Key'),
		'sender_email' => $email,
		'sender_nickname' => $name,
		'sender_ip' => \BeaconCommon::RemoteAddr(),
		'message' => $body,
		'js_on' => 1,
		'submit_time' => $time_submitting,
		'stoplist_check' => 1
	];
	
	$curl = curl_init('https://moderate.cleantalk.org/api2.0');
	curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($spam));
	curl_setopt($curl, CURLOPT_CUSTOMREQUEST, 'POST');
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($curl, CURLOPT_HTTPHEADER, array('Content-Type: application/json'));
	$spamcheck_body = curl_exec($curl);
	$spamcheck_status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
	if ($spamcheck_status === 200) {
		$spam_status = json_decode($spamcheck_body, TRUE);
		$allowed = $spam_status['allow'] === 1;
		if ($allowed === false) {
			ReplyError('Sorry, this message looks a lot like spam.', 400, $spam_status);
		}
	} else {
		ReplyError('Spam check was not able to complete.', 500, $zendesk_body);
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
	ReplyError('Unable to create ticket with ZenDesk.', 500, $zendesk_body);
}

function ReplyError(string $message, int $code, $detail = null) {
	http_response_code($code);
	echo json_encode(['error' => true, 'message' => $message, 'detail' => $detail], JSON_PRETTY_PRINT);
	exit;
}

function GetLicensesForEmailID(?string $email_id) {
	$licenses = [];
	if (is_null($email_id)) {
		return $licenses;
	}
	
	$database = BeaconCommon::Database();
	$results = $database->Query('SELECT product_name, expiration AT TIME ZONE \'UTC\' AS expiration FROM purchased_products WHERE purchaser_email = $1 ORDER BY product_name;', $email_id);
	while ($results->EOF() === false) {
		$license = $results->Field('product_name');
		if (is_null($results->Field('expiration')) === false) {
			$expiration = new DateTime($results->Field('expiration'));
			$license .= ', expires ' . $expiration->format('Y-m-d');
		}
		$licenses[] = $license;
		$results->MoveNext();
	}
	return $licenses;
}

?>