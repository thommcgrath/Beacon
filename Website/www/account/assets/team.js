document.addEventListener('DOMContentLoaded', function(event) {
	let enableFunction = function(event) {
		event.preventDefault();
		let userID = this.getAttribute('beacon-user-id');
		let userName = this.getAttribute('beacon-user-name');
		
		request.start('POST', 'actions/team', 'application/json', JSON.stringify({
			'action': 'enable',
			'child_id': userID
		}), function(obj) {
			window.location.reload();
		}, function(http_status, body) {
			let message = 'There was an HTTP ' + http_status + ' error';
			try {
				let obj = JSON.parse(body);
				message = obj.message
			} catch (err) {
			}
			dialog.show('Failed to enable user', message);
		});
		
		return false;
	};
	
	let disableFunction = function(event) {
		event.preventDefault();
		let userID = this.getAttribute('beacon-user-id');
		let userName = this.getAttribute('beacon-user-name');
		
		dialog.confirm('Are you sure you want to disable the user "' + userName + '?"', 'While a user is disabled, they will not be able to sign into their account or access Beacon\'s services. The account can be enabled again at any time.', 'Disable', 'Cancel', function() {
			request.start('POST', 'actions/team', 'application/json', JSON.stringify({
				'action': 'disable',
				'child_id': userID
			}), function(obj) {
				window.location.reload();
			}, function(http_status, body) {
				let message = 'There was an HTTP ' + http_status + ' error';
				try {
					let obj = JSON.parse(body);
					if (obj.message) {
						message = obj.message;
					}
				} catch (err) {
				}
				dialog.show('Failed to disable user', message);
			});
		});
		
		return false;
	};
	
	let resetFunction = function(event) {
		event.preventDefault();
		let userID = this.getAttribute('beacon-user-id');
		return false;
	};
	
	let deleteFunction = function(event) {
		event.preventDefault();
		let userID = this.getAttribute('beacon-user-id');
		let userName = this.getAttribute('beacon-user-name');
		
		dialog.confirm('Are you sure you want to delete the user "' + userName + '?"', 'Deleted users accounts cannot be recovered.', 'Delete', 'Cancel', function() {
			request.start('POST', 'actions/team', 'application/json', JSON.stringify({
				'action': 'delete',
				'child_id': userID
			}), function(obj) {
				window.location.reload();
			}, function(http_status, body) {
				let message = 'There was an HTTP ' + http_status + ' error';
				try {
					let obj = JSON.parse(body);
					if (obj.message) {
						message = obj.message;
					}
				} catch (err) {
				}
				dialog.show('Failed to delete user', message);
			});
		});
		
		return false;
	};
	
	let enableLinks = document.querySelectorAll('a.enable-button');
	enableLinks.forEach(function(link) {
		link.addEventListener('click', enableFunction);
	});
	
	let disableLinks = document.querySelectorAll('a.disable-button');
	disableLinks.forEach(function(link) {
		link.addEventListener('click', disableFunction);
	});
	
	let resetLinks = document.querySelectorAll('a.reset-button');
	resetLinks.forEach(function(link) {
		link.addEventListener('click', resetFunction);
	});
	
	let deleteLinks = document.querySelectorAll('a.delete-button');
	deleteLinks.forEach(function(link) {
		link.addEventListener('click', deleteFunction);
	});
	
	document.getElementById('buy_slots_button').addEventListener('click', function(event) {
		event.preventDefault();
		window.location.href = '/omni/#checkout';
	});
	
	function setupAddMemberModal() {
		let addMemberButton = document.getElementById('add-account-button');
		let addEmailField = document.getElementById('add-email-field');
		let addUsernameField = document.getElementById('add-username-field');
		let addPasswordField = document.getElementById('add-password-field');
		let addCancelButton = document.getElementById('add-cancel-button');
		let addActionButton = document.getElementById('add-action-button');
		let addSpinner = document.getElementById('add-spinner');
		let addErrorSpace = document.getElementById('add-error-space');
		
		let addMemberInputFunction = function(event) {
			addActionButton.disabled = (addEmailField.value.trim() === '' || addUsernameField.value.trim() === '' || addPasswordField.value === '');
		};
		
		addMemberButton.addEventListener('click', function(event) {
			event.preventDefault();
			
			addEmailField.value = '';
			addUsernameField.value = '';
			addPasswordField.value = '';
			addErrorSpace.classList.add('hidden');
			
			dialog.showModal('add-team-modal');
		});
	
		addCancelButton.addEventListener('click', function(event) {
			event.preventDefault();
			
			dialog.hideModal('add-team-modal');
		});
		
		addActionButton.addEventListener('click', function(event) {
			event.preventDefault();
			addActionButton.disabled = true;
			addCancelButton.disabled = true;
			addSpinner.classList.remove('hidden');
			addEmailField.disabled = true;
			addUsernameField.disabled = true;
			addPasswordField.disabled = true;
			addErrorSpace.classList.add('hidden');
			
			request.start('POST', 'actions/team', 'application/json', JSON.stringify({
				'action': 'create',
				'email': addEmailField.value,
				'password': addPasswordField.value,
				'username': addUsernameField.value
			}), function(obj) {
				dialog.hideModal('add-team-modal');
				window.location.reload();
			}, function(http_status, body) {
				addEmailField.disabled = false;
				addUsernameField.disabled = false;
				addPasswordField.disabled = false;
				addCancelButton.disabled = false;
				addSpinner.classList.add('hidden');
				addMemberInputFunction(event);
				
				let message = 'There was an HTTP ' + http_status + ' error.';
				try {
					let obj = JSON.parse(body);
					if (obj.message) {
						message = obj.message;
					}
				} catch (err) {
				}
				
				addErrorSpace.innerText = message;
				addErrorSpace.classList.remove('hidden');
			});
		});
		
		addEmailField.addEventListener('input', addMemberInputFunction);
		addUsernameField.addEventListener('input', addMemberInputFunction);
		addPasswordField.addEventListener('input', addMemberInputFunction);
	}
	
	setupAddMemberModal();
});