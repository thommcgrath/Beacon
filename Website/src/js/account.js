"use strict";

document.addEventListener('DOMContentLoaded', (event) => {
	let known_vulnerable_password = '';
	
	const userHeader = document.getElementById('account-user-header');
	const userId = userHeader.getAttribute('beacon-user-id');
	const userName = userHeader.getAttribute('beacon-user-name');
	const userSuffix = userHeader.getAttribute('beacon-user-suffix');
	const userFullName = `${userName}#${userSuffix}`;
	
	const getFragment = () => {
		let fragment = window.location.hash;
		if (fragment) {
			if (fragment.startsWith('#')) {
				fragment = fragment.substr(1);
			}
			return fragment;
		} else {
			return '';
		}
	};
	
	const pagePanel = PagePanel.pagePanels['panel-account'];
	if (pagePanel) {
		pagePanel.switchPage(getFragment());
		
		window.addEventListener('popstate', (ev) => {
			pagePanel.switchPage(getFragment());
		});
	}
	
	const settingsPagePanel = document.getElementById('panel-account');
	if (settingsPagePanel) {
		settingsPagePanel.addEventListener('panelSwitched', (ev) => {
			window.location.hash = ev.panel.currentPageName;
		});
	}
	
	/* ! Projects */
	
	const deleteProjectButtons = document.querySelectorAll('#panel-account div[page="projects"] [beacon-action="delete"]');
	for (const button of deleteProjectButtons) {
		button.addEventListener('click', (event) => {
			event.preventDefault();
			
			const resource_url = event.target.getAttribute('beacon-resource-url');
			const resource_name = event.target.getAttribute('beacon-resource-name');
			
			BeaconDialog.confirm('Are you sure you want to delete the project "' + resource_name + '?"', 'The project will be deleted immediately and cannot be recovered.', 'Delete').then((reason) => {
				BeaconWebRequest.delete(resource_url, { Authorization: `Session ${sessionId}` }).then((response) => {
					BeaconDialog.show('Project deleted', '"' + resource_name + '" has been deleted.').then(() => {
						window.location.reload(true);
					});
				}).catch((error) => {
					switch (error.status) {
					case 401:
						BeaconDialog.show('Project not deleted', 'There was an authentication error');
						break;
					default:
						BeaconDialog.show('Project not deleted', `Sorry, there was a ${error.status} error.`);
						break;
					}
				});
			}).catch((reason) => {
				// Do nothing
			});
			
			return false;
		});
	}
	
	/*! Omni */
	
	const showOmniInternetInstructionsButton = document.getElementById('omni_show_instructions_internet');
	if (showOmniInternetInstructionsButton) {
		showOmniInternetInstructionsButton.addEventListener('click', (ev) => {
			ev.preventDefault();
			
			const instructions = document.getElementById('omni_instructions_internet');
			if (instructions) {
				if (instructions.classList.contains('hidden')) {
					instructions.classList.remove('hidden');
				} else {
					instructions.classList.add('hidden');
				}
			}
		});
	}
	
	const showOmniOfflineInstructionsButton = document.getElementById('omni_show_instructions_no_internet');
	if (showOmniOfflineInstructionsButton) {
		showOmniOfflineInstructionsButton.addEventListener('click', (ev) => {
			ev.preventDefault();
			
			const instructions = document.getElementById('omni_instructions_no_internet');
			if (instructions) {
				if (instructions.classList.contains('hidden')) {
					instructions.classList.remove('hidden');
				} else {
					instructions.classList.add('hidden');
				}
			}
		});
	}
	
	const dragAndDropSupported = self.fetch && window.FileReader && ('classList' in document.createElement('a'));
	if (dragAndDropSupported) {
		const upload_file = (file) => {
			const formData = new FormData();
			formData.append('file', file);
			
			fetch(document.getElementById('upload_activation_form').getAttribute('action'), { method: 'POST', body: formData, credentials: 'same-origin', headers: {'Accept': 'application/json'} }).then(function(response) {
				if (!response.ok) {
					const obj = response.json().then((obj) => {
						const alert = {
							message: 'Unable to create authorization file',
							explanation: 'Sorry, there was an error creating the authorization file.'
						};
						if (obj.message) {
							alert.explanation += ' ' + obj.message.trim();
						}
						if (!alert.explanation.endsWith('.')) {
							alert.explanation += '.';
						}
						BeaconDialog.show(alert.message, alert.explanation);
					});
					return;
				}
				
				const disposition = response.headers.get('content-disposition');
				const matches = /"([^"]*)"/.exec(disposition);
				const filename = (matches != null && matches[1] ? matches[1] : 'Default.beaconidentity');
				
				response.blob().then((blob) => {
					const link = document.createElement('a');
					link.href = window.URL.createObjectURL(blob);
					link.download = filename;
					
					document.body.appendChild(link);
					link.click();
					document.body.removeChild(link);
				});
			}).catch((error) => {
				BeaconDialog.show('Unable to create authorization file', 'There was a network error: ' + error);
			});
		};
		
		const uploadContainer = document.getElementById('upload_container');
		if (uploadContainer) {
			uploadContainer.classList.add('live-supported');
		}
		
		const dropArea = document.getElementById('drop_area');
		if (dropArea) {
			['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
				dropArea.addEventListener(eventName, (ev) => {
					ev.preventDefault();
					ev.stopPropagation();
				}, false);
			});
			
			['dragenter', 'dragover'].forEach(eventName => {
				dropArea.addEventListener(eventName, (ev) => {
					ev.target.classList.add('highlight');
				}, false);
			});
			
			['dragleave', 'drop'].forEach(eventName => {
				dropArea.addEventListener(eventName, (ev) => {
					ev.target.classList.remove('highlight');
				}, false);
			});
			
			dropArea.addEventListener('drop', (ev) => {
				upload_file(ev.dataTransfer.files[0]);
			}, false);
		}
		
		const chooseFileButton = document.getElementById('choose_file_button');
		if (chooseFileButton) {
			chooseFileButton.addEventListener('click', (ev) => {
				ev.preventDefault();
				
				const chooser = document.getElementById('file_chooser');
				if (chooser) {
					chooser.addEventListener('change', (ev) => {
						upload_file(ev.target.files[0]);
					});
					
					chooser.click();
				}
			});
		}
	}
	
	/* ! Profile */
	
	document.getElementById('username_action_button').addEventListener('click', (ev) => {
		ev.preventDefault();
		
		const username = document.getElementById('username_field').value.trim();
		if (username === '') {
			BeaconDialog.show('Username can not be empty', 'How did you press the button anyway?');
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
	
	/* ! Security */
	
	document.getElementById('password_action_button').addEventListener('click', (event) => {
		event.preventDefault();
		
		const currentPassword = (currentPasswordField) ? currentPasswordField.value : '';
		const password = (newPasswordField) ? newPasswordField.value : '';
		const passwordConfirm = (confirmPasswordField) ? confirmPasswordField.value : '';
		const allowVulnerable = password === known_vulnerable_password;
		const regenerateKey = document.getElementById('password_regenerate_check').checked;
		const terminateSessions = regenerateKey;
		
		if (password.length < 8) {
			BeaconDialog.show('Password too short', 'Your password must be at least 8 characters long.');
			return false;
		}
		if (password !== passwordConfirm) {
			BeaconDialog.show('Passwords do not match', 'Please make sure the two passwords match.');
			return false;
		}
		
		const body = new URLSearchParams();
		body.append('current_password', currentPassword);
		body.append('password', password);
		body.append('allow_vulnerable', allowVulnerable);
		if (terminateSessions) {
			body.append('terminate_sessions', true);
		}
		if (regenerateKey) {
			body.append('regenerate_key', true);
		}
		
		BeaconWebRequest.post('/account/actions/password', body).then((response) => {
			document.getElementById('change_password_form').reset();
			
			try {
				const obj = JSON.parse(response.body);
				const msg = {};
				if (regenerateKey) {
					msg.message = 'Your password and private key have been changed.';
				} else {
					msg.message = 'Your password has been changed.';
				}
				if (terminateSessions) {
					msg.explanation = 'All sessions have been revoked and your devices will need to sign in again.';
				} else {
					msg.explanation = 'Changing your password does not sign you out of other devices.';
				}
				BeaconDialog.show(msg.message, msg.explanation);
			} catch (e) {
				console.log(e)
				BeaconDialog.show('There was an error. Your password may or may not have been changed.');
			}
		}).catch((error) => {
			switch (error.status) {
			case 403:
				BeaconDialog.show('Incorrect Two Step Verification Code', 'Please get a new code from your authenticator app.');
				break;
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
	
	const currentPasswordField = document.getElementById('password_current_field');
	const newPasswordField = document.getElementById('password_initial_field');
	const confirmPasswordField = document.getElementById('password_confirm_field');
	const passwordActionButton = document.getElementById('password_action_button');
	
	const passwordConfirmCheck = (ev) => {
		if (!passwordActionButton) {
			return;
		}
		
		if (!(currentPasswordField && newPasswordField && confirmPasswordField)) {
			console.log('Missing page fields');
			passwordActionButton.disabled = true;
			return;
		}
		
		passwordActionButton.disabled = currentPasswordField.value.trim() === '' || newPasswordField.value.trim() === '' || newPasswordField.value !== confirmPasswordField.value;
	};
	
	if (currentPasswordField) {
		currentPasswordField.addEventListener('input', passwordConfirmCheck);
	}
	if (newPasswordField) {
		newPasswordField.addEventListener('input', passwordConfirmCheck);
	}
	if (confirmPasswordField) {
		confirmPasswordField.addEventListener('input', passwordConfirmCheck);
	}
	
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
				authenticator.nickname = addAuthenticatorNicknameField.value.trim();
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
				if (timeElement.classList.contains('no-localize')) {
					continue;
				}
				
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
	
	const replaceBackupCodesButton = document.getElementById('replace-backup-codes-button');
	if (replaceBackupCodesButton) {
		replaceBackupCodesButton.addEventListener('click', (ev) => {
			BeaconDialog.confirm('Replace backup codes?', 'This will replace all of your backup codes with new ones.').then(() => {
				BeaconWebRequest.post('/account/actions/replace_backup_codes', {}, {Authorization: `Session ${sessionId}`}).then((response) => {
					try {
						const backupCodesTable = document.getElementById('backup-codes');
						const obj = JSON.parse(response.body);
						const codes = obj.codes;
						backupCodesTable.innerHTML = '';
						for (const code of codes) {
							const codeElement = document.createElement('div');
							codeElement.innerText = code;
							codeElement.className = 'flex-grid-item';
							backupCodesTable.appendChild(codeElement);	
						}
					} catch (e) {
						window.location.reload(true);
					}
				}).catch((error) => {
					console.log(JSON.stringify(error));
					const reason = {
						message: 'Backup codes not replaced',
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
				
			});
		});	
	}
	
	/* ! Sessions */
	
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
	
	const revokeLinks = document.querySelectorAll('#panel-account div[page="sessions"] a.revokeLink');
	for (const link of revokeLinks) {
		link.addEventListener('click', revokeAction);
	}
});
