"use strict";

document.addEventListener('DOMContentLoaded', () => {
	const contactForm = document.getElementById('contactForm');
	const contactErrorNotice = document.getElementById('contactErrorNotice');
	const contactNameField = document.getElementById('contactNameField');
	const contactEmailField = document.getElementById('contactEmailField');
	const contactPlatformField = document.getElementById('contactPlatformField');
	const contactHostField = document.getElementById('contactHostField');
	const contactBodyField = document.getElementById('contactBodyField');
	const contactActionButton = document.getElementById('contactActionButton');
	const contactTimestampField = document.getElementById('contactTimestampField');
	const contactHashField = document.getElementById('contactHashField');
	
	const contactPageInitial = document.getElementById('pageInitial');
	const contactPageForm = document.getElementById('pageContactForm');
	const contactShowFormLink = document.getElementById('showWebFormLink');
	
	const showError = (message) => {
		if (contactErrorNotice) {
			contactErrorNotice.innerHTML = message;
			contactErrorNotice.classList.remove('hidden');
		}
		if (contactActionButton) {
			contactActionButton.disabled = false;
		}
	}
	
	contactForm.addEventListener('submit', (ev) => {
		ev.preventDefault();
		
		if (!(contactActionButton && contactErrorNotice && contactNameField && contactEmailField && contactHashField && contactBodyField && contactPlatformField && contactTimestampField && contactHashField)) {
			console.log('Page is missing important elements');
			return false;
		}
		
		contactActionButton.disabled = true;
		contactErrorNotice.classList.add('hidden');
		
		const contactName = contactNameField.value.trim();
		if (contactName === '') {
			showError('Please enter a name');
			return;
		}
		
		const contactEmail = contactEmailField.value.trim();
		if (contactEmail === '') {
			showError('Please enter a valid email address');
			return;
		}
		
		const contactHost = contactHostField.value.trim();
		if (contactHost === '') {
			showError('Please fill in the host field');
			return;
		}
		
		const contactBody = contactBodyField.value.trim();
		if (contactBody === '') {
			showError('Please let us know how we can help');
			return;
		}
		
		const contactPlatform = contactPlatformField.value.trim();
		if (contactPlatform === '') {
			showError('Please select one of the platforms from the menu');
			return;
		}
		
		const contactTimestamp = contactTimestampField.value.trim();
		const contactHash = contactHashField.value.trim();
		
		const params = new URLSearchParams();
		params.append('name', contactName);
		params.append('email', contactEmail);
		params.append('platform', contactPlatform);
		params.append('host', contactHost);
		params.append('body', contactBody);
		params.append('timestamp', contactTimestamp);
		params.append('hash', contactHash);
		
		BeaconWebRequest.post('/help/ticket', params).then((response) => {
			contactBodyField.value = '';
			contactActionButton.disabled = false;
			
			BeaconDialog.show('Your support request has been submitted.', 'You will receive an email confirmation shortly.');
		}).catch((error) => {
			let message = `Sorry, there was an HTTP ${error.status} error.`;
			try {
				const obj = JSON.parse(error.body);
				if (obj.message) {
					message = obj.message;
				}
			} catch (e) {
				console.log(e);
			}
			showError(message);
		});
	});
	
	if (contactEmailField) {
		const storedEmail = sessionStorage?.getItem('email') ?? localStorage?.getItem('email');
		if (storedEmail) {
			contactEmailField.value = storedEmail;
		}
	}
	
	if (contactShowFormLink) {
		contactShowFormLink.addEventListener('click', (ev) => {
			ev.preventDefault();
			
			if (contactPageInitial) {
				contactPageInitial.classList.add('hidden');
			}
			
			if (contactPageForm) {
				contactPageForm.classList.remove('hidden');
			}
		});
	}
});