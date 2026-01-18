<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');
header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

use BeaconAPI\v4\EmailVerificationCode;

if (empty($_POST['email']) || BeaconEmail::IsEmailValid($_POST['email']) == false) {
	http_response_code(400);
	echo json_encode([], JSON_PRETTY_PRINT);
	exit;
}

$email = $_POST['email'];
$turnstileToken = $_POST['turnstileToken'] ?? null;
$params = [];
if (isset($_POST['flowId'])) {
	$params['flow_id'] = $_POST['flowId'];
}
if (isset($_POST['return'])) {
	$params['return'] = $_POST['return'];
}

if (is_null($turnstileToken) || empty($turnstileToken)) {
	echo json_encode(['message' => 'Please complete the CAPTCHA before continuing.'], JSON_PRETTY_PRINT);
	return;
}

$turnstileParams = [
	'secret' => BeaconCommon::GetGlobal('Turnstile Token'),
	'response' => $turnstileToken,
	'remoteip' => BeaconCommon::RemoteAddr(false),
];

$curl = curl_init('https://challenges.cloudflare.com/turnstile/v0/siteverify');
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
curl_setopt($curl, CURLOPT_POSTFIELDS, http_build_query($turnstileParams));
$turnstileBody = curl_exec($curl);
$turnstileStatus = curl_getinfo($curl, CURLINFO_HTTP_CODE);
curl_close($curl);

if ($turnstileStatus !== 200) {
	http_response_code(400);
	echo json_encode(['message' => 'CAPTCHA verification failed. Please try again.'], JSON_PRETTY_PRINT);
	return;
}

$turnstileResponse = json_decode($turnstileBody, true);
if (!$turnstileResponse['success']) {
	http_response_code(400);
	echo json_encode(['message' => 'CAPTCHA verification failed. Please try again.'], JSON_PRETTY_PRINT);
	return;
}

$verification = EmailVerificationCode::Create($email, $params); // Email sent here
if (is_null($verification)) {
	http_response_code(400);
	echo json_encode(['message' => 'Unable to deliver to ' . $email . '. The mail server may be rejecting messages. Contact support at help@usebeacon.app once the mailbox is working again.'], JSON_PRETTY_PRINT);
	return;
}

http_response_code(200);
echo json_encode(['email' => $email, 'verified' => false], JSON_PRETTY_PRINT);

?>
