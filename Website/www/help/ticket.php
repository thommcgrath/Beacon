<?php

/* Scenarios:

1. Form is submitted without a user uuid, such as from the website. In this case, the user info comes from the email address.
2. Form is submitted with a user uuid, but the account does not exist (offline) or has no email address (anonymous). In this case, the user info comes from the email address.
3. Form is submitted with a user uuid which has an email address matching the submitted email address. In this case, the user info comes from the user uuid.
4. Form is submitted with a user uuid wihch has an email address that does not match the submitted email address. In this case, information for both users should be included.

*/

require(dirname(__FILE__, 3) . '/framework/loader.php');

use BeaconAPI\v4\User;

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
	ReplyError('Method not allowed.', 405);
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

if (BeaconEmail::IsEmailValid($email) === false) {
	ReplyError('Could not validate email address.', 400);
}

$database = BeaconCommon::Database();
$results = $database->Query('SELECT uuid_for_email($1) AS email_id;', $email);
if ($results->RecordCount() === 0 || is_null($results->Field('email_id'))) {
	$database->BeginTransaction();
	$results = $database->Query('SELECT uuid_for_email($1, TRUE) AS email_id;', $email);
	$database->Commit();
}
$email_id = $results->Field('email_id');

$user_id = null;
$users = [];
$license_emails = [];
$license_users = [];
if ($has_expanded_parameters) {
	$user_id = trim($_POST['user']);
	$user_by_id = User::Fetch($user_id);
	if (is_null($user_by_id) === false && is_null($user_by_id->EmailId()) === false) {
		$users[] = $user_by_id;
		$license_emails[] = $user_by_id->EmailId();
		$license_users[$user_by_id->EmailId()] = $user_by_id;
	}
	$os = trim($_POST['os']);
	$version = trim($_POST['version']);
	$build = trim($_POST['build']);
	$time_submitting = 15; // Just make something up.
} else {
	// Scenario 1: No user uuid submitted
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
if (count($users) === 0 || $users[0]->EmailId() !== $email_id) {
	$user_by_email = User::Fetch($email_id);
	if (is_null($user_by_email) === false) {
		$users[] = $user_by_email;
		$license_emails[] = $email_id;
		$license_users[$email_id] = $user_by_email;
		if (is_null($user_id)) {
			$user_id = $user_by_email->UserID();
		}
	}
}
if (in_array($email_id, $license_emails) === false) {
	$license_emails[] = $email_id;
	$license_users[$email_id] = null;
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
if (is_null($user_id) === false) {
	$custom_fields[] = [
		'id' => 360033879552,
		'value' => $user_id
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

$diagnostics = [];

$licenses = [];
if (count($license_emails) > 1) {
	foreach ($license_emails as $license_email_id) {
		$username = null;
		$user = $license_users[$license_email_id];
		if (is_null($user) === false && is_null($user->Username()) === false) {
			$username = $user->Username() . '#' . $user->Suffix();
		}
		$licenses = array_merge($licenses, GetLicensesForEmailID($license_email_id, $username));
	}
} elseif (count($license_emails) === 1) {
	$licenses = GetLicensesForEmailID($license_emails[0]);
}
if (count($licenses) > 0) {
	asort($licenses);
	$diagnostics[] = "- Licenses:\n" . implode("\n", $licenses);
}
if (count($users) > 1) {
	$usernames = [];
	foreach ($users as $user) {
		$username = '  - ' . $user->Username() . '#' . $user->Suffix();
		if ($user->EmailID() === $email_id) {
			$username .= ' (This email)';
		} elseif (is_null($user_id) === false && $user_id === $user->UserID()) {
			$username .= ' (Signed in user)';
		}
		$usernames[] = $username;
	}
	$diagnostics[] = "- Multiple users detected:\n" . implode("\n", $usernames);
} elseif (count($users) === 1 && $user_id !== $users[0]->UserID()) {
	$diagnostics[] = "- User may be signed into the wrong account.";
} elseif (count($users) === 0 && is_null($user_id) === false) {
	$diagnostics[] = '- User may be anonymous.';
}

$paragraphs = [$body];
if (count($diagnostics) > 0) {
	$paragraphs[] = '-- Diagnostic Information Follows --';
	$paragraphs[] = implode("\n", $diagnostics);
}

if (BeaconCommon::InProduction() === false) {
	// Pretend success
	http_response_code(201);
	echo json_encode(['error' => false, 'message' => 'Ticked Created', 'detail' => implode("\n\n", $paragraphs)], JSON_PRETTY_PRINT);
	exit;
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

if (count($users) === 0) {
	// Pass to CleanTalk for spam detection
	$spam = [
		'method_name' => 'check_message',
		'auth_key' => BeaconCommon::GetGlobal('CleanTalk Auth Key'),
		'sender_email' => $email,
		'sender_nickname' => $name,
		'sender_ip' => \BeaconCommon::RemoteAddr(false),
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
			'body' => implode("\n\n", $paragraphs),
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

function GetLicensesForEmailID(?string $email_id, ?string $username = null) {
	$licenses = [];
	if (is_null($email_id)) {
		return $licenses;
	}
	
	$database = BeaconCommon::Database();
	$results = $database->Query('SELECT product_name, expiration AT TIME ZONE \'UTC\' AS expiration FROM purchased_products WHERE purchaser_email = $1 ORDER BY product_name;', $email_id);
	$now = new DateTime();
	while ($results->EOF() === false) {
		$license = $results->Field('product_name');
		if (is_null($results->Field('expiration')) === false) {
			$expiration = new DateTime($results->Field('expiration'));
			if ($expiration < $now) {
				$license .= ', expired ' . $expiration->format('Y-m-d');
			} else {
				$license .= ', expires ' . $expiration->format('Y-m-d');
			}
		}
		if (is_null($username) === false) {
			$license = "$username: $license";
		}
		$licenses[] = "  - $license";
		$results->MoveNext();
	}
	return $licenses;
}

?>