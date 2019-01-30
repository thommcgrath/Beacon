<?php
	
require(dirname(__FILE__, 3) . '/framework/loader.php');

$session = BeaconSession::GetFromCookie();
if (is_null($session)) {
	BeaconCommon::Redirect('/account/login/');
	exit;
}

header('Cache-Control: no-cache');

$user = BeaconUser::GetByUserID($session->UserID());
BeaconTemplate::SetTitle('Account: ' . $user->LoginKey());

BeaconTemplate::StartStyles(); ?>
<style>

#account_toolbar_menu {
	list-style: none;
	padding: 0px;
	display: flex;
	flex-direction: row;
	max-width: 320px;
	margin-left: auto;
	margin-right: auto;
	justify-content: center;
	border-color: inherit;
	
	li {
		flex-grow: 1;
		text-align: center;
		font-size: larger;
		border-color: inherit;
		
		a {
			text-decoration: none;
		}
		
		&.active {
			font-weight: 600;
		}
	}
}

</style><?php
BeaconTemplate::FinishStyles();

BeaconTemplate::StartScript(); ?>
<script>
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
	document.getElementById('toolbar_documents_button').addEventListener('click', function(event) {
		switchView('documents');
	});
	document.getElementById('toolbar_omni_button').addEventListener('click', function(event) {
		switchView('omni');
	});
	document.getElementById('toolbar_settings_button').addEventListener('click', function(event) {
		switchView('settings');
	});
	
	var fragment = window.location.hash.substr(1);
	if (fragment !== '') {
		switchView(fragment);
	}
});
</script><?php
BeaconTemplate::FinishScript();

?><h1><?php echo htmlentities($user->LoginKey()); ?><span class="user-suffix">#<?php echo htmlentities($user->Suffix()); ?></span><br><span class="subtitle"><a href="/account/auth.php?return=<?php echo urlencode('/'); ?>" title="Sign Out">Sign Out</a></span></h1>
<ul id="account_toolbar_menu" class="separator-color">
	<li id="account_toolbar_menu_documents" class="active"><a href="#documents" id="toolbar_documents_button">Documents</a></li>
	<li id="account_toolbar_menu_omni"><a href="#omni" id="toolbar_omni_button">Omni</a></li>
	<li id="account_toolbar_menu_settings"><a href="#settings" id="toolbar_settings_button">Settings</a></li>
</ul>
<div id="account_views">
	<div id="account_view_documents"><?php include('includes/documents.php'); ?></div>
	<div id="account_view_omni" class="hidden"><?php include('includes/omni.php'); ?></div>
	<div id="account_view_settings" class="hidden"><?php include('includes/settings.php'); ?></div>
</div>