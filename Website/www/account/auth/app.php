<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');
header('Cache-Control: no-cache');

$path = $_GET['path'] ?? '/account/';
$userId = $_GET['userId'] ?? '';

$session = BeaconCommon::GetSession();
if (is_null($session) === false && $session->UserId() === $userId) {
	BeaconCommon::Redirect($path);
}

$expiration = $_GET['expiration'] ?? '';
$signature = BeaconCommon::Base64UrlDecode($_GET['signature'] ?? '');

if (empty($userId)) {
	BeaconCommon::Redirect($path);
}

if (empty($expiration) || empty($signature)) {
	// Prompt for user password
	$loginParams = [
		'return' => $path,
		'userId' => $userId,
		'withRemember' => true,
		'withCancel' => false,
		'redeemUrl' => BeaconCommon::AbsoluteUrl('/account/auth/redeem?session_id={{session_id}}&return={{return_uri}}&temporary={{temporary}}')
	];

	BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('account.css'));

	?><div id="login_container">
		<h1>Beacon Login</h1>
		<?php BeaconLogin::Show($loginParams); ?>
	</div><?php
} else {
	$user = BeaconAPI\v4\User::Fetch($userId);
	if (is_null($user) || $user->IsAnonymous() === false) {
		BeaconCommon::Redirect($path);
	}

	$stringToSign = $userId . ';' . $expiration;
	$expiration = filter_var($expiration, FILTER_VALIDATE_INT);
	if ($expiration < time() || $expiration > time() + 120 || BeaconEncryption::RSAVerify($user->PublicKey(), $stringToSign, $signature) === false) {
		BeaconCommon::Redirect($path);
	}

	$session = BeaconAPI\v4\Session::Create($user, '12877547-7ad0-466f-a001-77815043c96b', ['common']);
	if (is_null($session) === false) {
		BeaconCommon::SetSession($session, false);
	}
	BeaconCommon::Redirect($path);
}

?>
