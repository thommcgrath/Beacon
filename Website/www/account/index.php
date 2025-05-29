<?php

require(dirname(__FILE__, 3) . '/framework/loader.php');
header('Cache-Control: no-cache');

use BeaconAPI\v4\{Affiliate, Session, User};

$session = BeaconCommon::GetSession();
if (is_null($session)) {
	BeaconTemplate::StartScript();
	?><script>
	window.location = `/account/login?return=${encodeURIComponent(window.location.href)}`;
	</script><?php
	BeaconTemplate::FinishScript();
	BeaconLogin::OutputNoscriptMessage();
	exit;
}

$user = $session->User();
BeaconTemplate::SetTitle('Account: ' . $user->Username());
BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('account.css'));

BeaconTemplate::AddScript(BeaconCommon::AssetUri('account.js'));
BeaconTemplate::StartScript(); ?>
<script>
document.addEventListener('DOMContentLoaded', () => {
	const event = new Event('beaconRunAccountPanel');
	event.accountProperties = <?php echo json_encode([
		'deviceId' => BeaconCommon::DeviceId(),
		'sessionId' => $session->AccessToken(),
		'apiDomain' => BeaconCommon::APIDomain()
	]); ?>;
	document.dispatchEvent(event);
});
</script><?php
BeaconTemplate::FinishScript();

$teams_enabled = BeaconCommon::TeamsEnabled();

if ($user->IsAnonymous() === false) {
	$affiliateCodes = Affiliate::Search(['userId' => $user->UserId()], true);
	$isAffiliate = count($affiliateCodes) > 0;
} else {
	$isAffiliate = false;
}

?><div id="account-user-header" class="header-with-subtitle" beacon-user-id="<?php echo htmlentities($user->UserID()); ?>" beacon-user-name="<?php echo htmlentities($user->Username()); ?>" beacon-user-suffix="<?php echo htmlentities($user->Suffix()); ?>">
	<h1><?php echo htmlentities($user->Username()); ?><span class="user-suffix">#<?php echo htmlentities($user->Suffix()); ?></span></h1>
	<span class="subtitle"><a href="/account/auth/redeem?return=<?php echo urlencode('/'); ?>" title="Sign Out">Sign Out</a></span>
</div>
<div class="page-panel" id="panel-account">
	<div class="page-panel-nav">
		<ul>
			<li class="page-panel-active"><a href="#projects" page="projects">Projects</a></li>
			<?php if ($user->IsAnonymous() === false) { ?>
			<li><a href="#omni" page="omni">Omni</a></li>
			<li><a href="#profile" page="profile">Profile</a></li>
			<li><a href="#security" page="security">Security</a></li>
			<li><a href="#billing" page="billing">Billing</a></li>
			<li><a href="#sessions" page="sessions">Sessions</a></li>
			<?php } ?>
			<li><a href="#services" page="services">Connections</a></li>
			<?php if ($isAffiliate) { ?>
			<li><a href="#affiliate" page="affiliate">Affiliate</a></li>
			<?php } ?>
			<li><a href="#apps" page="apps">API Keys</a></li>
		</ul>
	</div>
	<div class="page-panel-pages">
		<div class="page-panel-page page-panel-visible" page="projects">
			<h1>Projects</h1>
			<?php include('includes/projects.php'); ?>
		</div>
		<?php if ($user->IsAnonymous() === false) { ?>
		<div class="page-panel-page" page="omni">
			<h1>Beacon Omni</h1>
			<?php include('includes/omni.php'); ?>
		</div>
		<div class="page-panel-page" page="profile">
			<h1>Profile</h1>
			<?php include('includes/profile.php'); ?>
		</div>
		<div class="page-panel-page" page="security">
			<h1>Security</h1>
			<?php include('includes/security.php'); ?>
		</div>
		<div class="page-panel-page" page="billing">
			<h1>Billing</h1>
			<?php include('includes/billing.php'); ?>
		</div>
		<div class="page-panel-page" page="sessions">
			<h1>Sessions</h1>
			<?php include('includes/sessions.php'); ?>
		</div>
		<?php } ?>
		<div class="page-panel-page" page="services">
			<h1>Connected Services</h1>
			<?php include('includes/services.php'); ?>
		</div>
		<?php if ($isAffiliate) { ?>
		<div class="page-panel-page" page="affiliate">
			<h1>Affiliate Summary</h1>
			<?php include('includes/affiliate.php'); ?>
		</div>
		<?php } ?>
		<div class="page-panel-page" page="apps">
			<h1>API Keys</h1>
			<?php include('includes/apps.php'); ?>
		</div>
	</div>
	<div class="page-panel-footer">&nbsp;</div>
</div>
