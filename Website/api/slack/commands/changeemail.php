<?php

// /changeemail from@address.com to@address.com

use BeaconAPI\v4\{EmailVerificationCode, User};

if (strpos($text, ' ') === false) {
	PostReply("Incorrect number of parameters. Use `/changeemail from@address.com to@address.com`.");
	return;
}

list($from_address, $toAddress) = explode(' ', $text);
if (filter_var($from_address, FILTER_VALIDATE_EMAIL) === false || filter_var($toAddress, FILTER_VALIDATE_EMAIL) === false) {
	PostReply("One or both parameters are not email addresses.");
	return;
}

$database = BeaconCommon::Database();
$results = $database->Query('SELECT uuid_for_email($1) AS email_id;', $from_address);
$oldEmailId = $results->Field('email_id');
if (is_null($oldEmailId)) {
	PostReply("Nothing is registered to `$from_address`.");
	return;
}

try {
	$results = $database->Query('SELECT merchant_reference FROM purchases WHERE purchaser_email = $1;', $oldEmailId);
	$stripeApi = null;
	while (!$results->EOF()) {
		$merchantReference = $results->Field('merchant_reference');
		if (substr($merchantReference, 0, 3) == 'pi_') {
			if (is_null($stripeApi)) {
				$stripeApi = new BeaconStripeAPI(BeaconCommon::GetGlobal('Stripe_Secret_Key'));
			}
			if (!$stripeApi->ChangeEmailForPaymentIntent($merchantReference, $toAddress)) {
				PostReply("I could not change the email address of PaymentIntent `$merchantReference`.");
				exit;
			}
		}
		$results->MoveNext();
	}

	$database->BeginTransaction();
	$results = $database->Query('SELECT uuid_for_email($1, TRUE) AS email_id;', $toAddress);
	$newEmailId = $results->Field('email_id');
	if ($newEmailId == $oldEmailId) {
		$database->Rollback();
		PostReply("Uh.... both addresses are the same.");
		exit;
	}
	$database->Query('UPDATE purchases SET purchaser_email = $1 WHERE purchaser_email = $2;', $newEmailId, $oldEmailId);
	$database->Query('DELETE FROM public.email_verification_codes WHERE email_id = $1;', $oldEmailId);

	// We could be simply changing an email address of an existing account, or
	// merging one user into another.
	$results = $database->Query('SELECT user_id FROM users WHERE email_id = $1;', $newEmailId);
	if ($results->RecordCount() == 0) {
		// New email does not exist, so just change change the address on the
		// account.
		$database->Query('UPDATE users SET email_id = $1 WHERE email_id = $2;', $newEmailId, $oldEmailId);
	} else {
		// The new email does exist, so we need to merge the old account into
		// the new account if it exists.
		$newUserId = $results->Field('user_id');
		$results = $database->Query('SELECT user_id FROM public.users WHERE email_id = $1;', $oldEmailId);
		if ($results->RecordCount() === 1) {
			$oldUserId = $results->Field('user_id');

			// Project members are tricky. If both users already exist on the
			// project, we need to do some conflict resolution.
			$projects = $database->Query('SELECT project_id, role, public.project_role_permissions(role) AS permissions, encrypted_password, fingerprint FROM public.project_members WHERE user_id = $1;', $oldUserId);
			while (!$projects->EOF()) {
				$projectId = $projects->Field('project_id');
				$oldRole = $projects->Field('role');
				$oldPermissions = intval($projects->Field('permissions'));
				$oldPassword = $projects->Field('encrypted_password');
				$oldFingerprint = $projects->Field('fingerprint');

				$results = $database->Query('SELECT role, public.project_role_permissions(role) AS permissions, encrypted_password, fingerprint FROM public.project_members WHERE project_id = $1 AND user_id = $2;', $projectId, $newUserId);
				if ($results->RecordCount() === 1) {
					$newRole = $results->Field('role');
					$newPermissions = intval($results->Field('permissions'));
					$newPassword = $results->Field('encrypted_password');
					$newFingerprint = $results->Field('fingerprint');

					if ($newPermissions >= $oldPermissions) {
						$bestRole = $newRole;
					} elseif ($oldPermissions > $newPermissions) {
						$bestRole = $oldRole;
					}
					if (is_null($newPassword) === false) {
						$password = $newPassword;
						$fingerprint = $newFingerprint;
					} else {
						$password = $oldPassword;
						$fingerprint = $oldFingerprint;
					}

					$database->Query('DELETE FROM public.project_members WHERE project_id = $1 AND user_id IN ($2, $3);', $projectId, $oldUserId, $newUserId);
					$database->Query('INSERT INTO public.project_members (project_id, user_id, role, encrypted_password, fingerprint) VALUES ($1, $2, $3, $4, $5);', $projectId, $newUserId, $bestRole, $password, $fingerprint);
				} else {
					$database->Query('UPDATE public.project_members SET user_id = $1 WHERE project_id = $2 AND user_id = $3;', $newUserId, $projectId, $oldUserId);
				}
				$projects->MoveNext();
			}

			$tablesToDelete = [
				'public.access_tokens' => 'user_id',
				'public.application_auth_flows' => 'user_id',
				'public.device_auth_flows' => 'user_id',
				'public.oauth_tokens' => 'user_id',
				'public.policy_signatures' => 'user_id',
				'public.policy_signing_requests' => 'user_id',
				'public.trusted_devices' => 'user_id',
				'public.user_authenticators' => 'user_id',
				'public.user_backup_codes' => 'user_id',
				'public.user_challenges' => 'user_id',
			];
			foreach ($tablesToDelete as $table => $column) {
				$database->Query("DELETE FROM {$table} WHERE {$column} = $1;", $oldUserId);
			}

			$tablesToUpdate = [
				'ark.mods_legacy' => 'user_id',
				'public.affiliate_links' => 'user_id',
				'public.applications' => 'user_id',
				'public.content_packs' => 'user_id',
				'public.exception_comments' => 'user_id',
				'public.exception_users' => 'user_id',
				'public.gift_code_log' => 'user_id',
				'public.legacy_sessions' => 'user_id',
				'public.project_invites' => 'creator_id',
				'public.service_tokens' => 'user_id',
				'sentinel.buckets' => 'user_id',
				'sentinel.group_bans' => 'issuer_id',
				'sentinel.group_users' => 'user_id',
				'sentinel.groups' => 'user_id',
				'sentinel.player_notes' => 'user_id',
				'sentinel.script_likes' => 'user_id',
				'sentinel.script_tests' => 'user_id',
				'sentinel.script_webhooks' => 'user_id',
				'sentinel.scripts' => 'user_id',
				'sentinel.scripts_legacy' => 'user_id',
				'sentinel.services' => 'user_id',
			];
			foreach ($tablesToUpdate as $table => $column) {
				$database->Query("UPDATE {$table} SET {$column} = $1 WHERE {$column} = $2;", $newUserId, $oldUserId);
			}
			$database->Query('DELETE FROM users WHERE email_id = $1;', $oldEmailId);
		} else {
			// There is no user for either email address.
		}
	}
	$database->Query('DELETE FROM email_addresses WHERE email_id = $1;', $oldEmailId);
	$database->Commit();

	$user = User::Fetch($toAddress);
	if (is_null($user)) {
		EmailVerificationCode::Create($toAddress);
	}
} catch (Exception $e) {
	PostReply("I can't do that: {$e->getMessage()}");
	exit;
}

PostReply("All references to `$from_address` have been changed to `$toAddress`.");
return;

?>
