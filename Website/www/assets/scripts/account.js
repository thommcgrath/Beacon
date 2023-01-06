"use strict";

class ViewSwitcher {
	static currentPage = 'documents';
	
	static init() {
		ViewSwitcher.switchFromFragment();
	}
	
	static switchTo(newPage) {
		const currentPage = ViewSwitcher.currentPage;
		if (newPage == ViewSwitcher.currentPage) {
			return;
		}
		
		document.getElementById('account_toolbar_menu_' + currentPage).className = '';
		document.getElementById('account_toolbar_menu_' + newPage).className = 'active';
		document.getElementById('account_view_' + currentPage).className = 'hidden';
		document.getElementById('account_view_' + newPage).className = '';
		ViewSwitcher.currentPage = newPage;
	}
	
	static switchFromFragment() {
		const fragment = window.location.hash.substr(1);
		if (fragment !== '') {
			const index = fragment.indexOf('.');
			if (index > -1) {
				const majorPage = fragment.substr(0, index);
				const minorPage = fragment.substr(index + 1);
				
				switch (majorPage) {
				case 'settings':
					PagePanel.pagePanels['panel-settings'].switchPage(minorPage);
					break;
				}
				
				ViewSwitcher.switchTo(majorPage);
			} else {
				switch (fragment) {
				case 'settings':
					window.location.hash = `${fragment}.${PagePanel.pagePanels['panel-settings'].currentPageName}`;
					break;
				}
				
				ViewSwitcher.switchTo(fragment);
			}
		} else {
			ViewSwitcher.switchTo('documents');
		}
	}
}

document.addEventListener('DOMContentLoaded', (event) => {
	let known_vulnerable_password = '';
	
	const userHeader = document.getElementById('account-user-header');
	const userId = userHeader.getAttribute('beacon-user-id');
	const userName = userHeader.getAttribute('beacon-user-name');
	const userSuffix = userHeader.getAttribute('beacon-user-suffix');
	const userFullName = `${userName}#${userSuffix}`;
	
	ViewSwitcher.init();
	
	document.getElementById('password_action_button').addEventListener('click', (event) => {
		event.preventDefault();
		
		const current_password = document.getElementById('password_current_field').value;
		const password = document.getElementById('password_initial_field').value;
		const password_confirm = document.getElementById('password_confirm_field').value;
		const allow_vulnerable = password === known_vulnerable_password;
		const regenerate_key = document.getElementById('password_regenerate_check').checked;
		const terminate_sessions = regenerate_key;
		
		if (password.length < 8) {
			BeaconDialog.show('Password too short', 'Your password must be at least 8 characters long.');
			return false;
		}
		if (password !== password_confirm) {
			BeaconDialog.show('Passwords do not match', 'Please make sure the two passwords match.');
			return false;
		}
		
		const body = new URLSearchParams();
		body.append('current_password', current_password);
		body.append('password', password);
		body.append('allow_vulnerable', allow_vulnerable);
		if (terminate_sessions) {
			body.append('terminate_sessions', true);
		}
		if (regenerate_key) {
			body.append('regenerate_key', true);
		}
		
		BeaconWebRequest.post('/account/actions/password', body).then((response) => {
			document.getElementById('change_password_form').reset();
			
			const msg = {};
			if (regenerate_key) {
				msg.message = 'Your password and private key have been changed.';
			} else {
				msg.message = 'Your password has been changed.';
			}
			if (terminate_sessions) {
				msg.explanation = 'All sessions have been revoked and your devices will need to sign in again.';
			} else {
				msg.explanation = 'Changing your password does not sign you out of other devices.';
			}
			
			BeaconDialog.show(msg.message, msg.explanation);
		}).catch((error) => {
			switch (error.status) {
			case 436:
			case 437:
			case 439:
				try {
					const obj = JSON.parse(error.body);
					BeaconDialog.show('Unable to change password', obj.message);
				} catch (e) {
					BeaconDialog.show('Unable to change password', e.message);
				}
				break;
			case 438:
				known_vulnerable_password = password;
				BeaconDialog.show('Your password is vulnerable.', 'Your password has been leaked in a previous breach and should not be used. To ignore this warning, you may submit the password again, but that is not recommended.');
				break;
			case 500:
				BeaconDialog.show('Password not changed.', 'Your password has not been changed because your current password is not correct.');
				break;
			default:
				BeaconDialog.show('Unable to change password', `There was a ${error.status} error while trying to create your account.`);
				break;
			}
		});
		
		return false;
	});
	
	document.getElementById('username_action_button').addEventListener('click', (ev) => {
		ev.preventDefault();
		
		const username = document.getElementById('username_field').value.trim();
		if (username === '') {
			dialog.show('Username can not be empty', 'How did you press the button anyway?');
			return false;
		}
		
		const params = new URLSearchParams();
		params.add('username', username);
		
		BeaconWebRequest.post('/account/actions/username', params).then((response) => {
			const message = {
				message: 'Username changed',
				explanation: 'Your username has been changed.'
			};
			
			try {
				const obj = JSON.parse(response.body);
				message.explanation = `Your username has been changed to "${obj.username}."`;
			} catch (e) {
			}
			BeaconDialog.show(message.message, message.explanation).then(() => {
				window.location.reload(true);
			});
		}).catch((error) => {
			switch (error.status) {
			case 401:
				BeaconDialog.show('Username not changed', 'There was an authentication error.');
				break;
			default:
				BeaconDialog.show('Username not changed', `Sorry, there was a ${error.status} error.`);
				break;
			}
		});
	});
	
	document.getElementById('suggested-username-link').addEventListener('click', (ev) => {
		ev.preventDefault();
		
		const field = document.getElementById('username_field');
		field.value = ev.target.getAttribute('beacon-username');
		document.getElementById('username_action_button').disabled = field.value.trim() == '';
		
		return false;
	});
	
	document.getElementById('new-suggestion-link').addEventListener('click', (ev) => {
		BeaconWebRequest.get('/account/login/suggest').then((response) => {
			try {
				const obj = JSON.parse(response.body);
				const usernameLink = document.getElementById('suggested-username-link');
				usernameLink.innerText = obj.username;
				usernameLink.setAttribute('beacon-username', obj.username);
			} catch (e) {
			}
		}).catch(() => {});
		
		ev.preventDefault();
		return false;
	});
	
	document.getElementById('username_field').addEventListener('input', (ev) => {
		document.getElementById('username_action_button').disabled = ev.target.value.trim() == '';
	});
	
	const passwordConfirmCheck = (ev) => {
		const currentPasswordField = document.getElementById('password_current_field');
		const newPasswordField = document.getElementById('password_initial_field');
		const confirmPasswordField = document.getElementById('password_confirm_field');
		const passwordActionButton = document.getElementById('password_action_button');
		passwordActionButton.disabled = currentPasswordField.value.trim() == '' || newPasswordField.value.trim() == '' || newPasswordField.value != confirmPasswordField.value;
	};
	
	document.getElementById('password_current_field').addEventListener('input', passwordConfirmCheck);
	document.getElementById('password_initial_field').addEventListener('input', passwordConfirmCheck);
	document.getElementById('password_confirm_field').addEventListener('input', passwordConfirmCheck);
	
	const addAuthenticatorButton = document.getElementById('add-authenticator-button');
	const addAuthenticatorCodeField = document.getElementById('add-authenticator-code-field');
	const addAuthenticatorNicknameField = document.getElementById('add-authenticator-nickname-field');
	const addAuthenticatorActionButton = document.getElementById('add-authenticator-action-button');
	const addAuthenticatorCancelButton = document.getElementById('add-authenticator-cancel-button');
	if (addAuthenticatorButton && addAuthenticatorCodeField && addAuthenticatorNicknameField && addAuthenticatorActionButton && addAuthenticatorCancelButton) {
		try {
			const generateSecret = () => {
				const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';
				const values = new Uint32Array(4);
				self.crypto.getRandomValues(values);
				
				let token = '';
				for (const value of values) {
					token += alphabet[value >>> 27 & 0x1f] + alphabet[value >>> 22 & 0x1f] + alphabet[value >>> 17 & 0x1f] + alphabet[value >>> 12 & 0x1f] + alphabet[value >>> 7 & 0x1f] + alphabet[value >>> 2 & 0x1f];
				}
				return token;
			};
			
			const authenticator = {
				authenticator_id: self.crypto.randomUUID(),
				type: 'TOTP',
				nickname: 'Google Authenticator',
				metadata: {
					secret: null,
					setup: null
				}
			};
			
			addAuthenticatorCodeField.addEventListener('input', (ev) => {
				addAuthenticatorActionButton.disabled = ev.target.value.trim() === '';
			});
			
			addAuthenticatorButton.addEventListener('click', (ev) => {
				authenticator.metadata.secret = generateSecret();
				authenticator.metadata.setup = `otpauth://totp/${encodeURIComponent('Beacon:' + userFullName + ' (' + authenticator.authenticator_id + ')')}?secret=${authenticator.metadata.secret}&issuer=Beacon`;
				
				const addAuthenticatorQRCode = document.getElementById('add-authenticator-qrcode');
				if (addAuthenticatorQRCode) {
					addAuthenticatorQRCode.src = `/account/assets/qr.php?content=${btoa(authenticator.metadata.setup)}`;
					addAuthenticatorQRCode.setAttribute('alt', authenticator.metadata.setup);
					addAuthenticatorQRCode.setAttribute('title', authenticator.metadata.setup);
				}
				addAuthenticatorCodeField.value = '';
				
				BeaconDialog.showModal('add-authenticator-modal');
			});
			
			addAuthenticatorCancelButton.addEventListener('click', (ev) => {
				BeaconDialog.hideModal();
			});
			
			addAuthenticatorActionButton.addEventListener('click', (ev) => {
				const otp = new jsOTP.totp();
				const userCode = addAuthenticatorCodeField.value.trim();
				const nickname = addAuthenticatorNicknameField.value.trim();
				if (userCode !== otp.getOtp(authenticator.metadata.secret)) {
					addAuthenticatorCodeField.classList.add('invalid');
					
					const label = document.querySelector(`label[for="${addAuthenticatorCodeField.id}"]`);
					if (label) {
						label.classList.add('invalid');
						label.innerText = 'Incorrect Code';
					}
					
					setTimeout(() => {
						if (label) {
							label.classList.remove('invalid');
							label.innerText = 'Verification Code';
						}
						
						if (addAuthenticatorCodeField) {
							addAuthenticatorCodeField.classList.remove('invalid');
						}
					}, 3000);
					
					return;
				}
				
				BeaconWebRequest.post(`https://${apiDomain}/v3/authenticator`, authenticator, { Authorization: `Session ${sessionId}` }).then((response) => {
					window.location.reload(true);
				}).catch((error) => {
					console.log(JSON.stringify(error));
				});
			});
		} catch (e) {
			addAuthenticatorButton.addEventListener('click', (ev) => {
				BeaconDialog.show('Sorry, this browser is not supported', 'There was an error generating the authenticator, which means your browser does not support modern cryptography features. Try again with an updated browser.');
			});
		}
	}
	
	const authenticatorRows = document.querySelectorAll('#authenticators-table tbody tr');
	let numAuthenticators = authenticatorRows.length;
	if (numAuthenticators > 0) {
		if (moment) {
			const timeElements = document.querySelectorAll('time');
			for (const timeElement of timeElements) {
				const dateTime = timeElement.getAttribute('datetime');
				if (dateTime) {
					const time = moment(dateTime);
					timeElement.innerText = time.format('MMM Do, YYYY') + ' at ' + time.format('h:mm A');
				}
			}
		}
		
		const timeZoneName = document.getElementById('authenticators_time_zone_name');
		if (timeZoneName) {
			timeZoneName.innerText = Intl.DateTimeFormat().resolvedOptions().timeZone;
		}
		
		const deleteButtons = document.querySelectorAll('button.delete_authenticator_button');
		for (const deleteButton of deleteButtons) {
			deleteButton.addEventListener('click', (event) => {
				const authenticatorId = event.target.getAttribute('beacon-authenticator-id');
				const nickname = event.target.getAttribute('beacon-authenticator-name');
				
				const confirm = {
					message: `Are you sure you want to delete the authenticator ${nickname}?`
				};
				if (numAuthenticators > 1) {
					const remainingAuthenticators = numAuthenticators - 1;
					const authentictorWord = (remainingAuthenticators === 1) ? 'authenticator' : 'authenticators';
					confirm.explanation = `You will have ${remainingAuthenticators} ${authentictorWord} remaining. Your account will still be protected by two factor authentication.`;
				} else {
					confirm.explanation = 'This is your only authenticator. Deleting it will disable two factor authentication for your account. You will be able to add a new authenticator to enable two factor authentication again.';
				}
				
				BeaconDialog.confirm(confirm.message, confirm.explanation).then(() => {
					BeaconWebRequest.delete(`https://${apiDomain}/v3/authenticator/${authenticatorId}`, {Authorization: `Session ${sessionId}`}).then((response) => {
						const row = document.getElementById(`authenticator-${authenticatorId}`);
						if (row && numAuthenticators > 1) {
							row.remove();
							numAuthenticators--;
						} else {
							window.location.reload(true);
						}
					}).catch((error) => {
						const reason = {
							message: 'The authenticator was not deleted',
							explanation: `There was a ${error.status} error.`
						};
						try {
							const obj = JSON.parse(error.body);
							if (obj.message) {
								reason.explanation = obj.message;
							}
						} catch (e) {
						}
						BeaconDialog.show(reason.message, reason.explanation);
					});
				}).catch(() => {
					// Do nothing
				});
			});
		}
	}
	
	const settingsPagePanel = document.getElementById('panel-settings');
	if (settingsPagePanel) {
		settingsPagePanel.addEventListener('panelSwitched', (ev) => {
			const pageName = ev.panel.currentPageName;
			window.location.hash = `${ViewSwitcher.currentPage}.${pageName}`;
		});
	}
	
	const revokeAction = (event) => {
		event.preventDefault();
		
		BeaconWebRequest.delete(`http://${apiDomain}/v3/session/${event.target.getAttribute('sessionHash')}`, { Authorization: `Session ${sessionId}` }).then((response) => {
			BeaconDialog.show('Session revoked', 'Be aware that any enabled user with a copy of your account\'s private key can start a new session.').then(() => {
				window.location.reload(true);
			});
		}).catch((error) => {
			switch (error.status) {
			case 401:
				BeaconDialog.show('Session not revoked', 'There was an authentication error');
				break;
			default:
				BeaconDialog.show('Session not revoked', 'Sorry, there was a ' + error.status + ' error.');
				break;
			}
		});
		
		return false;
	};
	
	const revokeLinks = document.querySelectorAll('#account_view_sessions a.revokeLink');
	for (const link of revokeLinks) {
		link.addEventListener('click', revokeAction);
	}
	
	const deleteProjectButtons = document.querySelectorAll('#account_view_documents [beacon-action="delete"]');
	for (const button of deleteProjectButtons) {
		button.addEventListener('click', (event) => {
			event.preventDefault();
			
			const resource_url = event.target.getAttribute('beacon-resource-url');
			const resource_name = event.target.getAttribute('beacon-resource-name');
			
			BeaconDialog.confirm('Are you sure you want to delete the project "' + resource_name + '?"', 'The project will be deleted immediately and cannot be recovered.', 'Delete').then(() => {
				BeaconDialog.delete(resource_url, { Authorization: `Session ${sessionId}` }).then((response) => {
					BeaconDialog.show('Project deleted', '"' + resource_name + '" has been deleted.').then(() => {
						window.location.reload(true);
					});
				}).catch((error) => {
					switch (error.status) {
					case 401:
						BeaconDialog.show('Project not deleted', 'There was an authentication error');
						break;
					default:
						BeaconDialog.show('Project not deleted', 'Sorry, there was a ' + error.status + ' error.');
						break;
					}
				});
			}).catch(() => {
				// Do nothing
			});
			
			return false;
		});
	}
});

window.addEventListener('popstate', function(ev) {
	ViewSwitcher.switchFromFragment();
});
