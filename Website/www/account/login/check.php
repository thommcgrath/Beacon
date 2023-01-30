<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');
header('Cache-Control: no-cache');
header('Content-Type: application/json');

use BeaconAPI\v4\{Application, ApplicationAuthFlow, APIResponse, Core, Session, User};

$obj = Core::BodyAsJson();
$deviceId = $obj['deviceId'] ?? '';
$loginId = $obj['loginId'] ?? null;
$appChallenge = $obj['appChallenge'] ?? null;
$appChallengeExpiration = $obj['appChallengeExpiration'] ?? 0;

$app = Application::Fetch(BeaconCommon::BeaconAppId);
$challengeSecret = $app->Secret();
$challengeExpiration = $obj['challengeExpiration'] ?? 0;
$challengeRaw = $deviceId . $challengeExpiration . $challengeSecret;
if (is_null($loginId) === false) {
	$challengeRaw .= $loginId;
}

$challenge = base64_encode(hash('sha3-512', $challengeRaw, true));
$sentChallenge = $obj['challenge'] ?? '';
$challengeExpiration = $obj['challengeExpiration'] ?? 0;
if ($challengeExpiration < time() || $challenge !== $sentChallenge) {
	APIResponse::NewJsonError('Timed Out', ['code' => 'CHALLENGE_TIMEOUT'], 400)->Flush();
	exit;
}

$email = $obj['email'] ?? '';
$user = User::Fetch($email);
if (is_null($user)) {
	APIResponse::NewJsonError('Incorrect username or password', ['code' => 'BAD_LOGIN'], 401)->Flush();
	exit;
}

// The user has already completed login, this is just to finish the flow
if (is_null($loginId) === false && is_null($appChallenge) === false) {
	$flow = ApplicationAuthFlow::Fetch($loginId);
	if (is_null($flow) || $flow->IsCompleted()) {
		APIResponse::NewJsonError('This authentication flow has already been completed', ['code' => 'COMPLETED'], 400)->Flush();
		exit;
	}
	
	try {
		$callback = $flow->Authorize($deviceId, $appChallenge, $appChallengeExpiration, $user);
		http_response_code(200);
		echo json_encode(['callback' => $callback], JSON_PRETTY_PRINT);
	} catch (Exception $err) {
		APIResponse::NewJsonError('Authorization could not be completed. It may have expired. Please try again.', ['code' => 'EXPIRED', 'exception' => $err->getMessage()], 400)->Flush();
	}
	exit;
}

$password = $obj['password'] ?? '';
$verificationCode = $obj['verificationCode'] ?? '';
$trust = $obj['trust'] ?? null;

if ($user->TestPassword($password) === false) {
	APIResponse::NewJsonError('Incorrect username or password', ['code' => 'BAD_LOGIN'], 401)->Flush();
	exit;
}
if (empty($verificationCode)) {
	$verificationCode = $deviceId;
}
if ($user->Is2FAProtected()) {
	if ($user->Verify2FACode($verificationCode, false) === false) {
		APIResponse::NewJsonError('Incorrect username or password', ['code' => '2FA_ENABLED'], 403)->Flush();
		exit;
	}
	
	if (empty($deviceId) === false) {
		if ($trust === true) {
			$user->TrustDevice($deviceId);
		} else if ($trust === false) {
			$user->TrustDevice($deviceId);
		}	
	}
}

if (is_null($loginId)) {
	$session = Session::Create($user, $app);
	http_response_code(201);
	echo json_encode($session, JSON_PRETTY_PRINT);
} else {
	$flow = ApplicationAuthFlow::Fetch($loginId);
	if (is_null($flow) || $flow->IsCompleted()) {
		APIResponse::NewJsonError('This authentication flow has already been completed', ['code' => 'COMPLETED'], 400)->Flush();
		exit;
	}
	
	http_response_code(200);
	$expiration = time() + 300;
	echo json_encode([
		'appChallenge' => $flow->NewChallenge($deviceId, $user, $expiration),
		'appChallengeExpiration' => $expiration
	], JSON_PRETTY_PRINT);
}
exit;

if (empty($_POST['email']) || empty($_POST['password'])) {
	header('Location: ./');
	exit;
}

$email = $_POST['email'];
$password = $_POST['password'];

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
	echo '<p>' . htmlentities($email) . ' is not a valid email address.</p>';
	exit;
}

$user = BeaconUser::GetByEmail($email);
if (is_null($user)) {
	// user does not exist
	BeaconCommon::StartSession();
	if (isset($_SESSION['login_email']) && isset($_SESSION['login_email_verified']) && strtolower($_SESSION['login_email']) === strtolower($email) && $_SESSION['login_email_verified'] === true) {
		// skip this step, verification is already done, just update the password
		$_SESSION['login_desired_password'] = $password;
		header('Location: /account/login/password');
		exit;
	}
	
	if (isset($_SESSION['login_verify_code'])) {
		$verify_code = $_SESSION['login_verify_code'];
	} else {
		$verify_code = BeaconCommon::GenerateRandomKey(6, '0123456789');
	}
	
	$headers = "From: Beacon Support <help@' . BeaconCommon::Domain() . '>";
	$subject = "Email Verification Code";
	$body = "Your email verification is $verify_code";
	if (!mail($email, $subject, $body, $headers)) {
		echo 'email did not send';
		exit;
	}
	
	$_SESSION['login_desired_password'] = $password;
	$_SESSION['login_verify_code'] = $verify_code;
	$_SESSION['login_email'] = $email;
	header('Location: /account/login/verify');
	exit;
} else {
	// check password
	if ($user->TestPassword($password)) {
		BeaconCommon::StartSession();
		if (isset($_SESSION['login_user_id']) && strtolower($_SESSION['login_user_id']) !== strtolower($user->UserID())) {
			// need to merge login_user_id into user_id
			if (!BeaconUser::MergeUsers($user, $_SESSION['login_user_id'])) {
				// uh oh
				echo 'Unable to merge users';
				exit;
			}
		}
		
		unset($_SESSION['login_user_id'], $_SESSION['login_private_key'], $_SESSION['login_private_key_secret']);
		
		if (isset($_SESSION['login_return_url'])) {
			header('Location: ' . $_SESSION['login_return_url']);
			unset($_SESSION['login_return_url']);
		} else {
			header('Location: /account/');
		}
		http_response_code(302);
		exit;
	} else {
		echo 'bad password';
	}
}

?>
