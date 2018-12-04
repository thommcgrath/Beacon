<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');

BeaconCommon::StartSession();

BeaconTemplate::StartScript(); ?>
<script>
	
var number_of_checks = 0;

document.addEventListener('DOMContentLoaded', function() {
	setTimeout(function() {
		check_purchase_status(<?php echo (isset($_SESSION['client_reference_id']) ? json_encode($_SESSION['client_reference_id']) : 'null'); ?>);
	}, 1000);
});

function check_purchase_status(client_reference_id) {
	if (client_reference_id == null) {
		document.getElementById('checking_container').style.display = 'none';
		document.getElementById('purchase_unknown').style.display = 'block';
		return;
	}
	
	number_of_checks++;
	request.start('GET', 'status.php?client_reference_id=' + encodeURIComponent(client_reference_id), function(obj) {
		document.getElementById('checking_container').style.display = 'none';
		document.getElementById('purchase_confirmed').style.display = 'block';
		
		var email = obj.email;
		var user_id = obj.user_id;
		
		if (user_id == null) {
			document.getElementById('confirmed_text').innerText = 'You will need to create an account with the email address "' + email + '" to activate Omni in Beacon.';
			document.getElementById('activate_button').innerText = 'Create Account in Beacon';
			document.getElementById('activate_button').href = 'beacon://activate_account?email=' + encodeURIComponent(email) + '&new_account=true';
		} else {
			document.getElementById('confirmed_text').innerText = 'Your account "' + email + '" is ready to use Omni. Simply relaunch Beacon or click the "Activate Omni" button below to have Beacon refresh your account status.';
			document.getElementById('activate_button').href = 'beacon://activate_account?email=' + encodeURIComponent(email);
		}
	}, function(http_status, raw_body) {
		setTimeout(function() {
			if (number_of_checks == 2) {
				document.getElementById('checking_subtext').innerText = "\nWating for confirmation from Stripe…";
			}
			check_purchase_status(client_reference_id);
		}, 3000);
	});
}

</script>
<?php
BeaconTemplate::FinishScript();

BeaconTemplate::StartStyles(); ?>
<style type="text/css">

#checking_container {
	background-color: rgba(0, 0, 0, 0.02);
	border: 1px solid rgba(0, 0, 0, 0.1);
	padding: 12px;
	border-radius: 6px;
	text-align: center;
}

#checking_spinner {
	vertical-align: middle;
	margin-right: 12px;
}

#checking_text {
	line-height: 1.5em;
	font-weight: bold;
}

#checking_subtext {
	font-size: smaller;
	color: rgba(0, 0, 0, 0.8);
}

#purchase_confirmed {
	display: none;
}

#purchase_unknown {
	display: none;
}

.welcome_content {
	width: 100%;
	margin-left: auto;
	margin-right: auto;
	max-width: 500px;
	box-sizing: border-box;
}

</style>
<?php
BeaconTemplate::FinishStyles();

?><h1 class="text-center">Thanks for purchasing Beacon Omni!</h1>
<div id="checking_container" class="welcome_content">
	<p><img src="/assets/images/spinner.svg" width="64" height="64" id="checking_spinner"></p>
	<p><span id="checking_text">Checking purchase status&hellip;</span><span id="checking_subtext"></span></p>
</div>
<div id="purchase_confirmed" class="welcome_content">
	<p id="confirmed_text"></p>
	<p class="text-center"><a href="" id="activate_button" class="button">Activate Omni</a>
</div>
<div id="purchase_unknown" class="welcome_content"></div>