<?php
	
require(dirname(__FILE__, 3) . '/framework/loader.php');

$session = BeaconSession::GetFromCookie();
if (is_null($session)) {
	BeaconCommon::Redirect('/account/login/');
	exit;
}
$session->Renew();

header('Cache-Control: no-cache');

$user = BeaconUser::GetByUserID($session->UserID());
BeaconTemplate::SetTitle('Account: ' . $user->Username());

BeaconTemplate::StartStyles(); ?>
<style>

#account_toolbar_menu {
	list-style: none;
	padding: 0px;
	display: flex;
	flex-direction: row;
	margin-left: auto;
	margin-right: auto;
	margin-bottom: 20px;
	justify-content: center;
	border-color: inherit;
	flex-wrap: wrap;
	
	div {
		flex: 0 0 0px;
		text-align: center;
		border-color: inherit;
		white-space: nowrap;
		margin: 0px;
		border-radius: 4pt;
		padding: 6pt 8pt;
		font-size: 14pt;
		line-height: 1.0em;
		
		&.active {
			font-weight: 500;
		}
		
		a {
			text-decoration: none;
			padding: 0px;
			margin: 0px;
		}
	}
}

#account_views {
	max-width: 100%;
}

</style><?php
BeaconTemplate::FinishStyles();

BeaconTemplate::StartScript(); ?>
<script>
var switchViewFromFragment = function() {
	var fragment = window.location.hash.substr(1);
	if (fragment !== '') {
		switchView(fragment);
	} else {
		switchView('documents');
	}
}

var currentView = 'documents';
var switchView = function(newView) {
	if (newView == currentView) {
		return;
	}
	
	document.getElementById('account_toolbar_menu_' + currentView).className = '';
	document.getElementById('account_toolbar_menu_' + newView).className = 'active';
	document.getElementById('account_view_' + currentView).className = 'hidden';
	document.getElementById('account_view_' + newView).className = '';
	currentView = newView;
};

document.addEventListener('DOMContentLoaded', function(event) {
	switchViewFromFragment();
});

window.addEventListener('popstate', function(ev) {
	switchViewFromFragment();
});
</script><?php
BeaconTemplate::FinishScript();

?><h1><?php echo htmlentities($user->Username()); ?><span class="user-suffix">#<?php echo htmlentities($user->Suffix()); ?></span><br><span class="subtitle"><a href="/account/auth.php?return=<?php echo urlencode('/'); ?>" title="Sign Out">Sign Out</a></span></h1>
<div id="account_toolbar_menu" class="separator-color">
	<div id="account_toolbar_menu_documents" class="active"><a href="#documents" id="toolbar_documents_button">Documents</a></div>
	<div id="account_toolbar_menu_omni"><a href="#omni" id="toolbar_omni_button">Omni</a></div>
	<div id="account_toolbar_menu_settings"><a href="#settings" id="toolbar_settings_button">Settings</a></div>
	<div id="account_toolbar_menu_sessions"><a href="#sessions" id="toolbar_sessions_button">Sessions</a></div>
</div>
<div id="account_views">
	<div id="account_view_documents"><?php include('includes/documents.php'); ?></div>
	<div id="account_view_omni" class="hidden"><?php include('includes/omni.php'); ?></div>
	<div id="account_view_settings" class="hidden"><?php include('includes/settings.php'); ?></div>
	<div id="account_view_sessions" class="hidden"><?php include('includes/sessions.php'); ?></div>
</div>