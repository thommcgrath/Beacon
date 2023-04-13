<?php

require(dirname(__FILE__, 4) . '/framework/loader.php');

BeaconTemplate::SetTitle('Thanks for purchasing!');
BeaconTemplate::AddStylesheet(BeaconCommon::AssetURI('omni.css'));
BeaconTemplate::StartScript(); ?>
<script>
"use strict";

let numberOfChecks = 0;

document.addEventListener('DOMContentLoaded', () => {
	let clientReferenceId = null;
	if (sessionStorage) {
		clientReferenceId = sessionStorage.getItem('client_reference_id');
	}
	setTimeout(() => {
		checkPurchaseStatus(clientReferenceId);
	}, 1000);
});

const checkPurchaseStatus = (clientReferenceId) => {
	const checkingContainer = document.getElementById('checking_container');
	const purchaseUnknown = document.getElementById('purchase_unknown');
	const purchaseDelayed = document.getElementById('purchase_delayed');
	const purchaseConfirmed = document.getElementById('purchase_confirmed');
	const signinInstructions = document.getElementById('signin_instructions');
	const confirmedText = document.getElementById('confirmed_text');
	const checkingSubtext = document.getElementById('checking_subtext');
	const activateButton = document.getElementById('activate_button');
	
	if (clientReferenceId === null) {
		checkingContainer.style.display = 'none';
		purchaseUnknown.style.display = 'block';
		signinInstructions.style.display = 'block';
		return;
	}
	
	numberOfChecks++;
	BeaconWebRequest.get(`status?client_reference_id=${encodeURIComponent(clientReferenceId)}`).then((response) => {
		console.log('Found');
		
		try {
			checkingContainer.style.display = 'none';
			purchaseConfirmed.style.display = 'block';
			
			const obj = JSON.parse(response.body);
			const userId = obj.user_id;
			const email = obj.email
			let accountUrl = <?php echo json_encode(BeaconCommon::AbsoluteURL('/account/login/?return=' . urlencode(BeaconCommon::AbsoluteURL('/account/#omni')))); ?>;
			if (email !== null) {
				accountUrl += `&email=${encodeURIComponent(email)}`;
			}
			if (userId === null) {
				accountUrl += '#create';
				if (email === null) {
					confirmedText.innerText = 'You will need to create an account with the email address used to purchase to activate Omni in Beacon.';
					activateButton.innerText = 'Create Account';
				} else {
					confirmedText.innertText = `An email was sent to ${email} to confirm your email address. Follow the included link to finish setting up your account. Be sure to check junk folders. Despite our best efforts, one of the major email providers likes to tag Beacon emails as spam.`;
					activateButton.className = 'hidden';
				}
			}
			activateButton.addEventListener('click', (ev) => {
				ev.preventDefault();
				window.location = accountUrl;
			});
		} catch (e) {
			console.log(e);
			BeaconDialog.show('There was an error checking your purchase status.');
		}
	}).catch((error) => {
		console.log('Not Yet');
		setTimeout(() => {
			if (numberOfChecks === 1) {
				checkingSubtext.innerText = "\nWaiting for purchase details from Stripe…";
			} else {
				purchaseDelayed.style.display = 'block';
				signinInstructions.style.display = 'block';
			}
			checkPurchaseStatus(clientReferenceId);
		}, 3000);
	});
}

</script>
<?php
BeaconTemplate::FinishScript();

?><h1 class="text-center">Thanks for purchasing Beacon Omni!</h1>
<div id="checking_container" class="welcome_content">
	<p><img src="<?php echo BeaconCommon::AssetURI('spinner.svg'); ?>" width="64" height="64" id="checking_spinner"></p>
	<p><span id="checking_text">Checking purchase status&hellip;</span><span id="checking_subtext"></span></p>
</div>
<div id="purchase_confirmed" class="welcome_content">
	<p id="confirmed_text"></p>
	<p class="text-center"><a href="" id="activate_button" class="button">Activate Omni</a>
	<p class="text-lighter smaller text-center">If there is a mistake with your purchase, please do not purchase again. <a href="/help/contact">Open a support ticket</a> so the mistake can be corrected.</p>
</div>
<div id="purchase_unknown" class="welcome_content">
	<p>Your purchase status cannot be retrieved. Maybe your browser is blocking cookies. Maybe you're visiting this page from a different browser than the one you purchased with. Or maybe something has simply gone wrong.</p>
	<p>Don't worry though, your purchase will still be completed normally. After you receive your receipt via email, sign into Beacon using the same email address that was used for the purchase, and Beacon Omni should be activated. If not, it means Stripe hasn't yet sent over purchase details, so wait a few minutes then relaunch Beacon.</p>
</div>
<div id="purchase_delayed" class="welcome_content">
	<p>This is unusual, but Stripe has not sent over purchase details yet. Unfortunately, the only option is to wait.</p>
	<p>In the meantime, follow the instructions below to sign into Beacon. Once Omni has been activated for your account, you'll only need to restart Beacon to use it.</p>
	<p>You can safely leave this page at any time, your purchase will still be completed.</p>
</div>
<div id="signin_instructions" class="welcome_content">
	<h3>How to sign into Beacon</h3>
	<?php include('instructions.php'); ?>
</div>