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
$email = $_GET['email'] ?? null;
$returnUrl = $_GET['return'] ?? BeaconCommon::AbsoluteURL('/account/');
$verificationCode = $_GET['code'] ?? null;
$verificationKey = $_GET['key'] ?? null;

if (empty($deviceId) === false) {
	BeaconCommon::SetDeviceId($deviceId);
}

if (is_null($email) === false && (is_null($verificationCode) === false || is_null($verificationKey) === false)) {
	// May not exit here
	RunEmailVerification($email, $verificationCode, $verificationKey);
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

function RunEmailVerification(string $email, ?string $verificationCode, ?string $verificationKey): void {
	$verification = null;
	if (is_null($verificationCode) === false) {
		$verification = EmailVerificationCode::Fetch($email, $verificationCode);
		if (is_null($verification) === false) {
			$verification->Verify();
		}
	} elseif (is_null($verificationKey) === false) {
		$codes = EmailVerificationCode::Search($email);
		foreach ($codes as $code) {
			if ($code->DecryptCode($verificationKey)) {
				$verification = $code;
				$verification->Verify();
				break;
			}
		}
	}
	
	if (is_null($verification)) {
		ExitWithMessage('Address Not Verified', 'No verification code was found for email ' . $email . '. Return to the login page and request a new code.', '/account/login?email=' . urlencode($email) . '#create');
	}
	if ($verification->IsVerified() === false) {
		ExitWithMessage('Address Not Verified', 'The verification code is not correct.', '/account/login?email=' . urlencode($email) . '#create');
	} else {
		ExitWithMessage('Address Confirmed', 'You can now close this window and continue following the instructions inside Beacon.');
	}
}

?>