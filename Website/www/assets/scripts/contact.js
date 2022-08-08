document.addEventListener('DOMContentLoaded', function() {
	let contactForm = document.getElementById('contactForm');
	let contactErrorNotice = document.getElementById('contactErrorNotice');
	let contactNameField = document.getElementById('contactNameField');
	let contactEmailField = document.getElementById('contactEmailField');
	let contactPlatformField = document.getElementById('contactPlatformField');
	let contactHostField = document.getElementById('contactHostField');
	let contactBodyField = document.getElementById('contactBodyField');
	let contactActionButton = document.getElementById('contactActionButton');
	let contactTimestampField = document.getElementById('contactTimestampField');
	let contactHashField = document.getElementById('contactHashField');
	
	let showError = function(message) {
		contactErrorNotice.innerHTML = message;
		contactErrorNotice.classList.remove('hidden');
		contactActionButton.disabled = false;
	}
	
	contactForm.addEventListener('submit', function(event) {
		event.preventDefault();
		contactActionButton.disabled = true;
		
		contactErrorNotice.classList.add('hidden');
		
		let contactName = contactNameField.value.trim();
		if (contactName === '') {
			showError('Please enter a name');
			return;
		}
		
		let contactEmail = contactEmailField.value.trim();
		if (contactEmail === '') {
			showError('Please enter a valid email address');
			return;
		}
		
		let contactHost = contactHostField.value.trim();
		if (contactHost === '') {
			showError('Please fill in the host field');
			return;
		}
		
		let contactBody = contactBodyField.value.trim();
		if (contactBody === '') {
			showError('Please let us know how we can help');
			return;
		}
		
		let contactPlatform = contactPlatformField.value.trim();
		if (contactPlatform === '') {
			showError('Please select one of the platforms from the menu');
			return;
		}
		
		let contactTimestamp = contactTimestampField.value.trim();
		let contactHash = contactHashField.value.trim();
		
		request.post('/help/ticket', {
			'name': contactName,
			'email': contactEmail,
			'platform': contactPlatform,
			'host': contactHost,
			'body': contactBody,
			'timestamp': contactTimestamp,
			'hash': contactHash
		}, function(obj) {
			dialog.show('Your support request has been submitted.', 'You will receive an email confirmation shortly.');
			contactBodyField.value = '';
			contactActionButton.disabled = false;
		}, function(status, body) {
			let message = 'Sorry, there was an HTTP ' + status + ' error.';
			try {
				let obj = JSON.parse(body);
				if (obj.message) {
					message = obj.message;
				}
			} catch (err) {
			}
			showError(message);
		});
	});
	
	let storedEmail = '';
	if (sessionStorage) {
		storedEmail = sessionStorage.getItem('email');
	}
	if (storedEmail === null && localStorage) {
		storedEmail = localStorage.getItem('email');
	}
	if (storedEmail !== null) {
		contactEmailField.value = storedEmail;
	}
});