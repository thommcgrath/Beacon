"use strict";

let numberOfChecks = 0;

document.addEventListener('DOMContentLoaded', () => {
	let clientReferenceId = null;
	if (sessionStorage) {
		clientReferenceId = sessionStorage.getItem('clientReferenceId');
	}
	setTimeout(() => {
		checkPurchaseStatus(clientReferenceId);
	}, 1000);
	
	localStorage.removeItem('beaconCart');
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
		try {
			checkingContainer.style.display = 'none';
			purchaseConfirmed.style.display = 'block';
			
			const obj = JSON.parse(response.body);
			const userId = obj.user_id;
			const email = obj.email
			const returnUrl = `${window.location.origin}/account/#omni`;
			let accountUrl = `${window.location.origin}/account/login?return=${encodeURIComponent(returnUrl)}`;
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
			activateButton.setAttribute('href', accountUrl);
		} catch (e) {
			console.log(e);
			BeaconDialog.show('There was an error checking your purchase status.');
		}
	}).catch((error) => {
		setTimeout(() => {
			if (numberOfChecks === 1) {
				checkingSubtext.innerText = "\nWaiting for purchase details from Stripe…";
			} else {
				purchaseDelayed.style.display = 'block';
				signinInstructions.style.display = 'block';
			}
			checkPurchaseStatus(clientReferenceId);
		}, 5000);
	});
}
