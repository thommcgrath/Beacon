<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

use BeaconAPI\v4\Session;

$database = BeaconCommon::Database();
if (isset($_REQUEST['request_id'])) {
	$signingRequestId = $_REQUEST['request_id'];
	if (BeaconCommon::IsUUID($signingRequestId) === false) {
		BeaconTemplate::SetTitle('Policies: Invalid Signing Request');
		echo '<h1>Bad Policy Signing Request</h1><p>The link you followed is not valid and never was valid.</p>';
		exit;
	}

	$requestInfo = $database->Query('SELECT * FROM public.policy_signing_requests WHERE policy_signing_request_id = $1 AND expiration > CURRENT_TIMESTAMP;', $signingRequestId);
	if ($requestInfo->RecordCount() !== 1) {
		BeaconTemplate::SetTitle('Policies: Expired Signing Request');
		echo '<h1>Expired Policy Signing Request</h1><p>Sorry, the link you followed has expired. Please go back and start again.</p>';
		exit;
	}

	$policyId = $requestInfo->Field('policy_id');
	$userId = $requestInfo->Field('user_id');
	$returnUrl = $requestInfo->Field('return_url');
	$challenge = $requestInfo->Field('challenge');
	$needsSignature = true;
	$policyInfo = $database->Query('SELECT title, content, EXTRACT(EPOCH FROM last_updated) AS last_updated, current_revision FROM public.policies WHERE policy_id = $1;', $policyId);

	if (strtoupper($_SERVER['REQUEST_METHOD']) === 'POST') {
		if ($_REQUEST['challenge'] !== $challenge) {
			BeaconTemplate::SetTitle('Policies: Incorrect Challenge');
			echo '<h1>Incorrect Challenge</h1><p>You probably made a new login attempt since loading the page. Reload the policy, and accept again.</p>';
			exit;
		}

		$database->BeginTransaction();
		$database->Query('INSERT INTO public.policy_signatures (policy_id, user_id, revision_number, signature_date) VALUES ($1, $2, $3, CURRENT_TIMESTAMP);', $policyId, $userId, $policyInfo->Field('current_revision'));
		$database->Query('DELETE FROM public.policy_signing_requests WHERE policy_signing_request_id = $1;', $signingRequestId);
		$database->Commit();

		BeaconCommon::Redirect($returnUrl);

		exit;
	}
} else {
	$policyName = $_GET['policy'] ?? '';
	$policyInfo = $database->Query('SELECT title, content, EXTRACT(EPOCH FROM last_updated) AS last_updated, current_revision FROM public.policies WHERE lookup_key = $1;', $policyName);
	$needsSignature = false;
}

if ($policyInfo->RecordCount() !== 1) {
	BeaconTemplate::SetTitle('Policies: Policy Not Found');
	echo '<h1>Policy Not Found</h1><p>Sorry. We are not sure which link you followed, but it does not lead anywhere.</p>';
	exit;
}

BeaconTemplate::SetTitle('Policies: ' . $policyInfo->Field('title'));

$currentRevision = intval($policyInfo->Field('current_revision'));
$lastUpdated = new DateTimeImmutable('@' . $policyInfo->Field('last_updated'));

echo '<div class="header-with-subtitle"><h1>' . htmlentities($policyInfo->Field('title')) . '<span class="subtitle">Last Updated: <time datetime="' . htmlentities($lastUpdated->format('c')) . '">' . htmlentities($lastUpdated->format('F jS, Y \a\t g:i A \U\T\C')) . '</time>, Revision: ' . $currentRevision . '</span></h1></div>';
echo (new Parsedown())->text($policyInfo->Field('content'));
if ($needsSignature) { ?>
	<form action="/policies/<?php echo urlencode($signingRequestId); ?>" method="POST">
		<input type="hidden" name="request_id" value="<?php echo htmlentities($signingRequestId); ?>">
		<input type="hidden" name="challenge" value="<?php echo htmlentities($challenge); ?>">
		<p class="text-center"><a href="<?php echo htmlentities($returnUrl); ?>" class="button">Decline</a><input type="submit" value="Accept" /></p>
	</form>
<?php } ?>
