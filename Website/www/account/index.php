<?php
	
require(dirname(__FILE__, 3) . '/framework/loader.php');
header('Cache-Control: no-cache');

$session = BeaconSession::GetFromCookie();
if (is_null($session)) {
	BeaconCommon::Redirect('/account/login/');
	exit;
}
$session->Renew();

$user = BeaconUser::GetByUserID($session->UserID());
BeaconTemplate::SetTitle('Account: ' . $user->Username());
BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('account.css'));

BeaconTemplate::StartScript(); ?>
<script>
const deviceId = <?php echo json_encode(BeaconCommon::DeviceID()); ?>;
const sessionId = <?php echo json_encode($session->SessionID()); ?>;
const apiDomain = <?php echo json_encode(BeaconCommon::APIDomain()); ?>;
</script><?php
BeaconTemplate::FinishScript();

$teams_enabled = BeaconCommon::TeamsEnabled();

?><h1 id="account-user-header" beacon-user-id="<?php echo htmlentities($user->UserID()); ?>" beacon-user-name="<?php echo htmlentities($user->Username()); ?>" beacon-user-suffix="<?php echo htmlentities($user->Suffix()); ?>"><?php echo htmlentities($user->Username()); ?><span class="user-suffix">#<?php echo htmlentities($user->Suffix()); ?></span><br><span class="subtitle"><a href="/account/auth?return=<?php echo urlencode('/'); ?>" title="Sign Out">Sign Out</a></span></h1>
<div id="account_toolbar_menu" class="separator-color">
	<div id="account_toolbar_menu_documents" class="active"><a href="#documents" id="toolbar_documents_button">Projects</a></div>
	<div id="account_toolbar_menu_omni"><a href="#omni" id="toolbar_omni_button">Omni</a></div>
	<div id="account_toolbar_menu_settings"><a href="#settings" id="toolbar_settings_button">Settings</a></div>
	<div id="account_toolbar_menu_sessions"><a href="#sessions" id="toolbar_sessions_button">Sessions</a></div>
	<?php if ($teams_enabled) { ?><div id="account_toolbar_menu_team"><a href="#team" id="toolbar_team_button">Team</a></div><?php } ?>
</div>
<div id="account_views">
	<div id="account_view_documents"><?php include('includes/documents.php'); ?></div>
	<div id="account_view_omni" class="hidden"><?php include('includes/omni.php'); ?></div>
	<div id="account_view_settings" class="hidden"><?php include('includes/settings.php'); ?></div>
	<div id="account_view_sessions" class="hidden"><?php include('includes/sessions.php'); ?></div>
	<?php if ($teams_enabled) { ?><div id="account_view_team" class="hidden"><?php include('includes/team.php'); ?></div><?php } ?>
</div>