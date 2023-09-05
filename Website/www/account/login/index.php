<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');

use BeaconAPI\v4\{EmailVerificationCode, Session, User};

header('Cache-Control: no-cache');
BeaconCommon::StartSession();
BeaconTemplate::SetTitle('Beacon Login');
BeaconTemplate::SetBodyClass('purple');
BeaconTemplate::AddHeaderLine('<link rel="canonical" href="' . BeaconCommon::AbsoluteUrl('/account/login') . '">');

$flowId = $_GET['flow_id'] ?? null;
$deviceId = $_GET['device_id'] ?? null;
$email = isset($_GET['email']) ? BeaconCommon::Base64UrlDecode($_GET['email']) : null;
$returnUrl = $_GET['return'] ?? '';
$verificationCode = $_GET['code'] ?? null;
$isApp = filter_var($_GET['app'] ?? 'false', FILTER_VALIDATE_BOOL);

if (empty($returnUrl) === false && str_starts_with($returnUrl, 'https://') === false) {
	$returnUrl = BeaconCommon::Base64UrlDecode($returnUrl);
}

if (empty($deviceId) === false) {
	BeaconCommon::SetDeviceId($deviceId);
}

if (is_null($email) === false && is_null($verificationCode) === false) {
	// Exits if this is an app
	$verification = RunEmailVerification($email, $verificationCode, $isApp);
	if (empty($returnUrl)) {
		$returnUrl = $verification->ReturnUri();
	}
}
if (empty($returnUrl)) {
	$returnUrl = BeaconCommon::AbsoluteUrl('/account/');
}

$loginParams = [
	'flowId' => $flowId,
	'email' => $email,
	'return' => $returnUrl,
	'code' => $verificationCode,
	'withRemember' => true,
	'withCancel' => false,
	'redeemUrl' => BeaconCommon::AbsoluteUrl('/account/auth/redeem?session_id={{session_id}}&return={{return_uri}}&temporary={{temporary}}')
];

BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('account.css'));

?>
<div id="login_container">
	<h1>Beacon Login</h1>
	<?php BeaconLogin::Show($loginParams); ?>
</div><?php

function ExitWithMessage(string $message, string $explanation, string $backUrl = ''): void {
	echo '<div id="login_container">';
	echo '<h1>' . htmlentities($message) . '</h1>';
	echo '<p>' . htmlentities($explanation) . '</p>';
	if (empty($backUrl) === false) {
		echo '<p class="text-center"><a class="button" href="' . htmlentities($backUrl) . '">Back</a></p>';
	}
	echo '</div>';
	exit;
}

function RunEmailVerification(string $email, string $verificationCode, bool $shouldExit): ?EmailVerificationCode {
	$verification = EmailVerificationCode::Fetch($email, $verificationCode);
	if (is_null($verification)) {
		ExitWithMessage('Address Not Verified', 'No verification code was found for email ' . $email . '. Return to the login page and request a new code.', '/account/login?email=' . urlencode($email) . '#create');
	}
	
	$verification->Verify();
	
	if ($shouldExit) {
		ExitWithMessage('Address Confirmed', 'You can now close this window and continue following the instructions inside Beacon.');
	} else {
		return $verification;
	}
}

?>