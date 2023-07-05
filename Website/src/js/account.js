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
				BeaconWebRequest.delete(resource_url, { Authorization: `Bearer ${sessionId}` }).then((response) => {
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
	
	const usernameActionButton = document.getElementById('username_action_button');
	const usernameField = document.getElementById('username_field');
	const suggestedUsernameLink = document.getElementById('suggested-username-link');
	const newSuggestionLink = document.getElementById('new-suggestion-link');
	
	if (usernameActionButton && usernameField) {
		usernameField.addEventListener('input', (ev) => {
			usernameActionButton.disabled = ev.target.value.trim() == '';
		});
		
		usernameActionButton.addEventListener('click', (ev) => {
			ev.preventDefault();
			
			const username = usernameField.value.trim();
			if (username === '') {
				BeaconDialog.show('Username can not be empty', 'How did you press the button anyway?');
				return false;
			}
			
			const params = new URLSearchParams();
			params.append('username', username);
			
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
		
		if (suggestedUsernameLink) {
			suggestedUsernameLink.addEventListener('click', (ev) => {
				ev.preventDefault();
				
				usernameField.value = ev.currentTarget.getAttribute('beacon-username');
				usernameActionButton.disabled = usernameField.value.trim() == '';
				
				return false;
			});
			
			if (newSuggestionLink) {
				newSuggestionLink.addEventListener('click', (ev) => {
					BeaconWebRequest.get('/account/login/suggest').then((response) => {
						try {
							const obj = JSON.parse(response.body);
							if (suggestedUsernameLink) {
								suggestedUsernameLink.innerText = obj.username;
								suggestedUsernameLink.setAttribute('beacon-username', obj.username);
							}
						} catch (e) {
						}
					}).catch(() => {});
					
					ev.preventDefault();
					return false;
				});
			}
		}
	}
	
	/* ! Security */
	
	const passwordActionButton = document.getElementById('password_action_button');
	const passwordRegenerateCheck = document.getElementById('password_regenerate_check');
	const changePasswordForm = document.getElementById('change_password_form');
	const currentPasswordField = document.getElementById('password_current_field');
	const newPasswordField = document.getElementById('password_initial_field');
	const confirmPasswordField = document.getElementById('password_confirm_field');
	const addAuthenticatorButton = document.getElementById('add-authenticator-button');
	const addAuthenticatorCodeField = document.getElementById('add-authenticator-code-field');
	const addAuthenticatorNicknameField = document.getElementById('add-authenticator-nickname-field');
	const addAuthenticatorActionButton = document.getElementById('add-authenticator-action-button');
	const addAuthenticatorCancelButton = document.getElementById('add-authenticator-cancel-button');
	const addAuthenticatorQRCode = document.getElementById('add-authenticator-qrcode');
	const timeZoneName = document.getElementById('authenticators_time_zone_name');
	const replaceBackupCodesButton = document.getElementById('replace-backup-codes-button');
	
	if (passwordActionButton && passwordRegenerateCheck && changePasswordForm) {
		passwordActionButton.addEventListener('click', (event) => {
			event.preventDefault();
			
			const currentPassword = (currentPasswordField) ? currentPasswordField.value : '';
			const password = (newPasswordField) ? newPasswordField.value : '';
			const passwordConfirm = (confirmPasswordField) ? confirmPasswordField.value : '';
			const allowVulnerable = password === known_vulnerable_password;
			const regenerateKey = passwordRegenerateCheck.checked;
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
				changePasswordForm.reset();
				
				try {
					const obj = JSON.parse(response.body);
					const msg = {};
					if (regenerateKey) {
						msg.message = 'Your password and private key have been changed.';
					} else {
						msg.message = 'Your password has been changed.';
					}
					msg.explanation = 'All sessions have been revoked and your devices will need to sign in again.';
					BeaconDialog.show(msg.message, msg.explanation);
				} catch (e) {
					console.log(e)
					BeaconDialog.show('There was an error. Your password may or may not have been changed.');
				}
			}).catch((error) => {
				let errorMessage = 'Unable to change password';
				let errorExplanation = `There was a ${error.status} error while trying to change your password.`;
				try {
					const obj = JSON.parse(error.body);
					if (obj.message) {
						errorExplanation = obj.message;
					}
				} catch (e) {
				}
				
				switch (error.status) {
				case 403:
					errorMessage = 'Incorrect Two Step Verification Code';
					errorExplanation = 'Please get a new code from your authenticator app.';
					break;
				case 438:
					known_vulnerable_password = password;
					errorMessage = 'Your password is vulnerable.';
					errorExplanation = 'Your password has been leaked in a previous breach and should not be used. To ignore this warning, you may submit the password again, but that is not recommended.';
					break;
				}
				
				BeaconDialog.show(errorMessage, errorExplanation);
			});
			
			return false;
		});
	}
	
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
				
				BeaconWebRequest.post(`https://${apiDomain}/v4/authenticators`, authenticator, { Authorization: `Bearer ${sessionId}` }).then((response) => {
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
					BeaconWebRequest.delete(`https://${apiDomain}/v4/authenticators/${authenticatorId}`, {Authorization: `Bearer ${sessionId}`}).then((response) => {
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
	
	if (replaceBackupCodesButton) {
		replaceBackupCodesButton.addEventListener('click', (ev) => {
			BeaconDialog.confirm('Replace backup codes?', 'This will replace all of your backup codes with new ones.').then(() => {
				BeaconWebRequest.post('/account/actions/replace_backup_codes', {}, {Authorization: `Bearer ${sessionId}`}).then((response) => {
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
		
		BeaconWebRequest.delete(`https://${apiDomain}/v4/sessions/${encodeURIComponent(event.target.getAttribute('sessionHash'))}`, { Authorization: `Bearer ${sessionId}` }).then((response) => {
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
	
	/* ! Apps */
	
	const editAppAction = (event) => {
		event.preventDefault();
		
		const applicationId = event.currentTarget.getAttribute('beacon-app-id');
		BeaconWebRequest.get(`https://${apiDomain}/v4/applications/${encodeURIComponent(applicationId)}`, { Authorization: `Bearer ${sessionId}` }).then((response) => {
			const parsed = JSON.parse(response.body);
			
		}).catch((error) => {
			BeaconDialog.show('Could not retrieve application info');
		});
	};
	
	const editAppButtons = document.querySelectorAll('#panel-account div[page="apps"] button.apps-edit-button');
	for (const button of editAppButtons) {
		button.addEventListener('click', editAppAction);	
	}
	
	/* ! Services */
	const staticTokenModal = document.getElementById('static-token-modal');
	const staticTokenNameField = document.getElementById('static-token-name-field');
	const staticTokenTokenField = document.getElementById('static-token-token-field');
	const staticTokenCancelButton = document.getElementById('static-token-cancel-button');
	const staticTokenActionButton = document.getElementById('static-token-action-button');
	const staticTokenProviderField = document.getElementById('static-token-provider-field');
	const staticTokenGenerateLink = document.getElementById('static-token-generate-link');
	const staticTokenHelpField = document.getElementById('static-token-help-field');
	const staticTokenErrorField = document.getElementById('static-token-error-field');
	
	const connectedServiceButtonAction = (event) => {
		event.preventDefault();
		
		const provider = event.currentTarget.getAttribute('beacon-provider');
		const type = event.currentTarget.getAttribute('beacon-provider-type');
		const tokenId = event.currentTarget.getAttribute('beacon-token-id');
		const tokenName = event.currentTarget.getAttribute('beacon-token-name');
		
		if (tokenId === '') {
			switch (type) {
			case 'oauth':
				window.location = `/account/oauth/v4/begin/${provider}`;
				break;
			case 'static':
				if (staticTokenModal && staticTokenNameField && staticTokenTokenField && staticTokenProviderField && staticTokenGenerateLink && staticTokenHelpField) {
					staticTokenNameField.value = '';
					staticTokenTokenField.value = '';
					staticTokenProviderField.value = provider;
					switch (provider) {
					case 'nitrado':
						staticTokenGenerateLink.href = 'https://server.nitrado.net/usa/developer/tokens';
						staticTokenHelpField.innerText = 'Beacon requires long life tokens from Nitrado to have the "service" scope enabled.';
						staticTokenHelpField.classList.remove('hidden');
						break;
					case 'gameserverapp':
						staticTokenGenerateLink.href = 'https://dash.gameserverapp.com/configure/api';
						staticTokenHelpField.innerText = 'On your GameServerApp.com dashboard, you will find an "API / Integrate" option where you can issue a token for Beacon. Copy the token into the field below to continue. Remember to keep your token in a safe place in case you need it again.';
						staticTokenHelpField.classList.remove('hidden');
						break;
					}
					BeaconDialog.showModal('static-token-modal');
				}
				break;
			}
		} else {
			BeaconDialog.confirm(`Are you sure you want to remove the service ${tokenName}?`, 'You will be able to connect the service again if you choose to.', 'Delete', 'Cancel').then(() => {
				BeaconWebRequest.delete(`https://${apiDomain}/v4/tokens/${tokenId}`, { Authorization: `Bearer ${sessionId}` }).then((response) => {
					window.location.reload(true);
				}).catch((error) => {
					BeaconDialog.show('The service was not deleted.');
				});
			});
		}
	};
	
	const connectedServiceActionButtons = document.querySelectorAll('#panel-account div[page="services"] .service-action button');
	for (const button of connectedServiceActionButtons) {
		button.addEventListener('click', connectedServiceButtonAction);
	}
	
	if (staticTokenModal && staticTokenNameField && staticTokenTokenField && staticTokenCancelButton && staticTokenActionButton && staticTokenProviderField && staticTokenErrorField) {
		const checkStaticTokenActionButton = () => {
			staticTokenActionButton.disabled = staticTokenNameField.value.trim() === '' || staticTokenTokenField.value.trim() === '';
		};
		
		staticTokenNameField.addEventListener('input', (ev) => {
			checkStaticTokenActionButton();
		});
		
		staticTokenTokenField.addEventListener('input', (ev) => {
			checkStaticTokenActionButton();
		});
		
		staticTokenCancelButton.addEventListener('click', (ev) => {
			ev.preventDefault();
			BeaconDialog.hideModal();
		});
		
		staticTokenActionButton.addEventListener('click', (ev) => {
			ev.preventDefault();
			staticTokenActionButton.disabled = true;
			staticTokenErrorField.classList.add('hidden');
			
			const tokenInfo = {
				provider: staticTokenProviderField.value,
				type: 'Static',
				accessToken: staticTokenTokenField.value.trim(),
				providerSpecific: {
					tokenName: staticTokenNameField.value.trim()
				}
			};
			
			const submitFunction = () => {
				BeaconWebRequest.post(`https://${apiDomain}/v4/user/tokens`, tokenInfo, { Authorization: `Bearer ${sessionId}` }).then((response) => {
					window.location.reload(true);
				}).catch((error) => {
					staticTokenErrorField.innerText = 'Could not save token.';
					staticTokenErrorField.classList.remove('hidden');
					staticTokenActionButton.disabled = false;
				});
			};
			
			if (tokenInfo.provider === 'nitrado') {
				const response = BeaconWebRequest.get('https://api.nitrado.net/token', { Authorization: `Bearer ${tokenInfo.accessToken}` }).then((response) => {
					const parsed = JSON.parse(response.body);
					if (parsed.data.token.scopes.includes('service') === false) {
						staticTokenErrorField.innerText = 'The long life token is valid, but is missing the "service" scope that Beacon requires.';
						staticTokenErrorField.classList.remove('hidden');
						staticTokenActionButton.disabled = false;
						return;
					}
					tokenInfo.providerSpecific.user = parsed.data.token.user;
					submitFunction();
				}).catch((error) => {
					staticTokenErrorField.innerText = 'The long life token is not valid. Double check the Nitrado website, as the beginning of the token can wrap to another line.';
					staticTokenErrorField.classList.remove('hidden');
					staticTokenActionButton.disabled = false;
				});
			} else {
				submitFunction();
			}
		});
	}
});
