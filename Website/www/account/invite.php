<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');

use BeaconAPI\v4\{Project, ProjectInvite, ProjectMember, Session};

if (isset($_REQUEST['code'])) {
	$code = substr($_REQUEST['code'], 0, 9);
} else {
	$code = '';
}

BeaconCommon::StartSession();
$session = BeaconCommon::GetSession();
$is_logged_in = is_null($session) === false;
$user = $is_logged_in ? $session->User() : null;

header('Cache-Control: no-cache');

$database = BeaconCommon::Database();

BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('account.css'));

$process_step = 'start';
if (isset($_REQUEST['process'])) {
	$process_step = strtolower($_REQUEST['process']);
}

?><div id="invite_form" class="reduced-width">
	<h1>Beacon Project Invite</h1>
	<?php

	switch ($process_step) {
	case 'invite-final':
	case 'invite-confirm':
		RedeemCode($code, $process_step === 'invite-final');
		break;
	default:
		ShowForm($code);
		break;
	}

	?>
</div><?php

function RedeemCode(string $code, bool $confirmed): void {
	global $user;

	if (is_null($user) || is_null($user->EmailId())) {
		$return = BeaconCommon::AbsoluteURL('/account/invite/' . urlencode($code) . '?process=invite-confirm');
		BeaconCommon::Redirect('/account/login/?return=' . urlencode($return));
		return;
	}

	$invite = ProjectInvite::Fetch($code);
	if (is_null($invite) || $invite->IsExpired()) {
		ShowForm($code, 'This project invite code is not valid. It may have been deleted or it has expired. Invite codes expire after 24 hours.');
		return;
	}

	$member = ProjectMember::Fetch($invite->ProjectId(), $user->UserId());
	if (is_null($member) === false) {
		ShowForm($code, 'You are already a member of this project. You cannot accept another invite for the same project.');
		return;
	}

	if ($confirmed) {
		$database = BeaconCommon::Database();
		$database->BeginTransaction();
		try {
			$encryptedPassword = base64_encode(BeaconEncryption::RSAEncrypt($user->PublicKey(), $invite->ProjectPassword()));
			$fingerprint = ProjectMember::GenerateFingerprint($user->UserId(), $user->Username(), $user->PublicKey(), $invite->ProjectPassword());
			$member = ProjectMember::Create($invite->ProjectId(), $user->UserId(), $invite->Role(), $encryptedPassword, $fingerprint);
		} catch (Exception $err) {
			$database->Rollback();
			ShowForm($code, 'Could not add user to project: ' . htmlentities($err->getMessage()));
			return;
		}
		try {
			$invite->Delete();
		} catch (Exception $err) {
			$database->Rollback();
			ShowForm($code, 'Could not delete invite after usage: ' . htmlentities($err->getMessage()));
			return;
		}
		$database->Commit();

		echo '<p class="text-center"><span class="text-blue">Project invite accepted!</span><br>You are now a member of the project.</p>';
	} else {
		// Show confirmation
		$project = Project::Fetch($invite->ProjectId());
		echo '<form action="/account/invite" method="post"><input type="hidden" name="process" value="invite-final"><input type="hidden" name="code" value="' . htmlentities($code) . '">';
		echo '<p>This invite code will add you to the project &quot;' . htmlentities($project->Title()) . '&quot;</p>';
		echo '<div class="double-group"><div>&nbsp;</div><div><div class="button-group"><div><a href="/account/invite" class="button">Cancel</a></div><div><input type="submit" value="Accept Invite"></div></div></div>';
		echo '</form>';
	}
}

function ShowForm(string $code, ?string $error = null): void {
	global $user;

	$invite = ProjectInvite::Fetch($code);
	if (is_null($invite) || $invite->IsExpired()) {
		echo '<p class="text-center text-red">This project invite code is not valid. It may have been deleted or it has expired. Invite codes expire after 24 hours.</p>';
		return;
	}

	$project = Project::Fetch($invite->ProjectId());

	echo '<form action="/account/invite" method="post"><input type="hidden" name="process" value="invite-confirm"><p>You have been invited to join the Beacon Project &quot;' . htmlentities($project->Title()) . '&quot;</p>';

	if (empty($error) === false) {
		echo '<p class="text-center text-red">' . htmlentities($error) . '</p>';
	}

	echo '<div class="floating-label"><input type="text" class="text-field" name="code" placeholder="Code" minlength="9" maxlength="9" value="' . htmlentities($code) . '"><label>Invite Code</label></div>';

	if (is_null($user)) {
		echo '<p class="text-right bold">You will be be asked to log in or create an account to accept this invite code.</p>';
		echo '<p class="text-right"><input type="submit" value="Sign In and Accept"></p>';
	} else {
		echo '<p class="text-right"><input type="submit" value="Accept"></p>';
	}
}

?>
