"use strict";

document.addEventListener('DOMContentLoaded', () => {
	const stwForm = document.getElementById('stw_form');
	const emailField = document.getElementById('stw_email_field');
	const joinButton = document.getElementById('stw_join_button');
	const arkRadio = document.getElementById('ark_radio');
	const arkSARadio = document.getElementById('arksa_radio');
	const ark2Radio = document.getElementById('ark2_radio');
	const radios = [arkRadio, arkSARadio, ark2Radio];
	const stwContainer = document.getElementById('stw_container');
	if (!(stwForm && emailField && joinButton && arkRadio && stwContainer)) {
		console.log('Missing page elements');
		return;
	}
	
	stwForm.addEventListener('submit', (ev) => {
		const encrypt = new JSEncrypt();
		encrypt.setPublicKey(stwPublicKey);
		
		const encrypted = encrypt.encrypt(emailField.value);
		joinButton.disabled = true;
		
		const productId = radios.filter((radio) => radio && radio.checked)[0].value;
		const fields = new URLSearchParams();
		fields.append('email', encrypted);
		fields.append('product_id', productId);
		
		BeaconWebRequest.post('submit', fields).then((response) => {
			try {
				const obj = JSON.parse(response.body);
				stwContainer.innerText = `Ok, ${obj.email} is now on the list! If selected, you will receive an email with instructions.`;
			} catch (e) {
				console.log(e);
			}
		}).catch((error) => {
			switch (error.status) {
			case 404:
				BeaconDialog.show('Unable to submit the email address', 'The receiver script was not found.');
				break;
			case 400:
				try {
					const obj = JSON.parse(error.body);
					BeaconDialog.show('Sorry, that didn\'t work.', obj.error);
				} catch (e) {
					console.log(e);
					BeaconDialog.show('Sorry, that didn\'t work.', 'There was a javascript error.');
				}
				break;
			default:
				BeaconDialog.show('Unable to submit the email address', `Sorry, there was a ${error.status} error: ${error.body}`);
				break;
			}
			joinButton.disabled = false;
		});
		
		ev.preventDefault();
		return true;
	});
});
