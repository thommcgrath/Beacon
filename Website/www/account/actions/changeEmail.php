<?php

header('Content-Type: application/json');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');
http_response_code(500);

require(dirname(__FILE__, 4) . '/framework/loader.php');

use BeaconAPI\v4\{Application, EmailVerificationCode, Response, User};

switch (strtoupper($_SERVER['REQUEST_METHOD'])) {
case 'POST':
	$activeSession = BeaconCommon::GetSession();
	if (is_null($activeSession)) {
		Response::NewJsonError('Unauthorized', ['code' => 'UNAUTHORIZED'], 401)->Flush();
		exit;
	}
	if ($activeSession->HasScope(Application::kScopeUsersCredentials) === false) {
		Response::NewJsonError('Forbidden', ['code' => 'FORBIDDEN'], 403)->Flush();;
		exit;
	}

	$user = $activeSession->User();
	$newEmail = $_POST['email'] ?? '';
	$identityChallenge = $_POST['identityChallenge'] ?? '';

	if (BeaconEmail::IsEmailValid($newEmail) === false) {
		http_response_code(400);
		echo json_encode(['message' => 'New email address is not a valid email address.'], JSON_PRETTY_PRINT);
		exit;
	}

	$database = BeaconCommon::Database();
	$rows = $database->Query('SELECT public.uuid_for_email($1) AS email_id;', $newEmail);
	$newEmailId = $rows->Field('email_id');
	if (is_null($newEmailId) === false) {
		if ($newEmailId === $user->EmailId()) {
			http_response_code(400);
			echo json_encode(['message' => 'Your email address is already ' . $newEmail . '.'], JSON_PRETTY_PRINT);
			exit;
		}
		$existingUser = User::Fetch($newEmailId);
		if (is_null($existingUser) === false) {
			http_response_code(400);
			echo json_encode(['message' => 'There is already another account with this email address.'], JSON_PRETTY_PRINT);
			exit;
		}
	}

	if (BeaconCommon::VerifyIdentityChallenge($activeSession, $identityChallenge, 'changeEmail') === false) {
		Response::NewJsonError('Identity not confirmed.', ['code' => 'INCORRECT_CHALLENGE'], 400)->Flush();
		exit;
	}

	$verifier = EmailVerificationCode::Create($newEmail, ['emailId' => $user->EmailId()], EmailVerificationCode::kTemplateConfirmChange);

	http_response_code(200);
	echo json_encode(['message' => 'Email Sent.'], JSON_PRETTY_PRINT);
	return;
case 'GET':
	$newEmail = BeaconCommon::Base64UrlDecode($_GET['email'] ?? '');
	$oldEmailId = $_GET['emailId'] ?? '';
	$verificationCode = $_GET['code'] ?? '';
	$sentHash = $_GET['hash'] ?? '';

	$params = [
		'code' => $verificationCode,
		'email' => $newEmail,
		'emailId' => $oldEmailId,
	];
	$computedHash = BeaconCommon::Base64UrlEncode(hash('sha3-256', http_build_query($params), true));
	if ($sentHash !== $computedHash) {
		header('Location: /account?message=' . urlencode('Email Change Error') . '&explanation=' . urlencode('Incorrect verification hash.') . '#profile', true, 301);
		return;
	}

	$verifier = EmailVerificationCode::Fetch($newEmail, $verificationCode);
	if (is_null($verifier)) {
		header('Location: /account?message=' . urlencode('Email Change Error') . '&explanation=' . urlencode('Incorrect verification code.') . '#profile', true, 301);
		return;
	}

	$user = User::Fetch($oldEmailId);
	if (is_null($user)) {
		header('Location: /account?message=' . urlencode('Email Change Error') . '&explanation=' . urlencode('Unable to find target user.') . '#profile', true, 301);
		return;
	}

	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	$rows = $database->Query('SELECT public.uuid_for_email($1, TRUE) AS email_id;', $newEmail);
	$newEmailId = $rows->Field('email_id');

	$database->Query('UPDATE public.purchases SET purchaser_email = $1 WHERE purchaser_email = $2;', $newEmailId, $oldEmailId);
	$database->Query('UPDATE public.users SET email_id = $1 WHERE email_id = $2;', $newEmailId, $oldEmailId);

	$rows = $database->Query('SELECT merchant_reference FROM purchases WHERE purchaser_email = $1;', $newEmailId);
	$stripeApi = null;
	while (!$rows->EOF()) {
		$merchantReference = $rows->Field('merchant_reference');
		if (substr($merchantReference, 0, 3) == 'pi_') {
			if (is_null($stripeApi)) {
				$stripeApi = new BeaconStripeAPI(BeaconCommon::GetGlobal('Stripe_Secret_Key'));
			}
			if (!$stripeApi->ChangeEmailForPaymentIntent($merchantReference, $newEmail)) {
				$database->Rollback();
				header('Location: /account?message=' . urlencode('Email Change Error') . '&explanation=' . urlencode('Could not update email address of past purchases.') . '#profile', true, 301);
				return;
			}
		}
		$rows->MoveNext();
	}

	$database->Query('DELETE FROM public.email_addresses WHERE email_id = $1;', $oldEmailId);

	EmailVerificationCode::Clear($newEmail);
	$database->Commit();

	header('Location: /account?message=' . urlencode('Email Has Been Changed') . '&explanation=' . urlencode('You have not been signed out of any devices.') . '#profile', true, 301);
	return;
}

?>
