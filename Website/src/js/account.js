"use strict";

import { BeaconPagePanel } from "./classes/BeaconPagePanel.js";
import { BeaconDialog } from "./classes/BeaconDialog.js";
import { BeaconWebRequest } from "./classes/BeaconWebRequest.js";
import { formatDates, randomUUID } from "./common.js";

document.addEventListener('beaconRunAccountPanel', ({accountProperties}) => {
	let knownVulnerablePassword = '';

	const sessionId = accountProperties.sessionId;
	const apiDomain = accountProperties.apiDomain;

	const userHeader = document.getElementById('account-user-header');
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

	BeaconPagePanel.init();
	const pagePanel = BeaconPagePanel.pagePanels['panel-account'];
	if (pagePanel) {
		pagePanel.switchPage(getFragment());

		window.addEventListener('popstate', () => {
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

			const resourceUrl = event.target.getAttribute('beacon-resource-url');
			const resourceName = event.target.getAttribute('beacon-resource-name');

			BeaconDialog.confirm('Are you sure you want to delete the project "' + resourceName + '?"', 'The project will be deleted immediately and cannot be recovered.', 'Delete').then(() => {
				BeaconWebRequest.delete(resourceUrl, { 'X-Beacon-Token': sessionId }).then(() => {
					BeaconDialog.show('Project deleted', '"' + resourceName + '" has been deleted.').then(() => {
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
			}).catch(() => {
				// Do nothing
			});

			return false;
		});
	}

	/* ! Profile */

	const usernameActionButton = document.getElementById('username_action_button');
	const usernameField = document.getElementById('username_field');
	const suggestedUsernameLink = document.getElementById('suggested-username-link');
	const newSuggestionLink = document.getElementById('new-suggestion-link');

	if (usernameActionButton && usernameField) {
		usernameField.addEventListener('input', (ev) => {
			usernameActionButton.disabled = ev.target.value.trim() === '';
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
					explanation: 'Your username has been changed.',
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
				case 403:
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
				usernameActionButton.disabled = usernameField.value.trim() === '';

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

	const changeEmailField = document.getElementById('email_field');
	const changeEmailButton = document.getElementById('email_action_button');
	const changeEmailNeeds2fa = document.getElementById('email_need_2fa');
	const changeEmail2faVerifyButton = document.getElementById('email_2fa_action_button');
	const changeEmail2faCancelButton = document.getElementById('email_2fa_cancel_button');
	const changeEmail2faCodeField = document.getElementById('email_2fa_code_field');
	if (changeEmailField && changeEmailButton && changeEmailNeeds2fa) {
		changeEmailField.addEventListener('input', (ev) => {
			changeEmailButton.disabled = ev.target.value.trim() === '';
		});

		const submitEmailChange = () => {
			const params = new URLSearchParams();
			params.append('email', changeEmailField.value.trim());
			params.append('verify', changeEmail2faCodeField ? changeEmail2faCodeField.value.trim() : '');

			BeaconWebRequest.post('/account/actions/email', params).then(() => {
				BeaconDialog.show('Email Change Started', 'The new address has been emailed a link. Please click the link to complete the change.').then(() => {
					window.location.reload(true);
				});
			}).catch((error) => {
				try {
					const body = JSON.parse(error.body);
					if (!body.message) {
						throw new Error();
					}
					const errorReason = body.message;
					BeaconDialog.show('Email Change Error', errorReason);
				} catch {
					switch (error.status) {
					case 401:
					case 403:
						BeaconDialog.show('Email Change Error', 'There was an authentication error.');
						break;
					default:
						BeaconDialog.show('Email Change Error', `Sorry, there was a ${error.status} error.`);
						break;
					}
				}
			});
		};

		changeEmailButton.addEventListener('click', (ev) => {
			ev.preventDefault();

			if (changeEmailNeeds2fa.value === 'true') {
				changeEmail2faCodeField.value = '';
				BeaconDialog.showModal('change_email_2fa_form');
				changeEmail2faCodeField.focus();
			} else {
				submitEmailChange();
			}
		});

		if (changeEmail2faVerifyButton) {
			changeEmail2faVerifyButton.addEventListener('click', (ev) => {
				ev.preventDefault();
				BeaconDialog.hideModal().then(() => {
					submitEmailChange();
				});
			});
		}

		if (changeEmail2faCancelButton) {
			changeEmail2faCancelButton.addEventListener('click', (ev) => {
				ev.preventDefault();
				BeaconDialog.hideModal();
			});
		}

		if (changeEmail2faCodeField) {
			changeEmail2faCodeField.addEventListener('input', (ev) => {
				changeEmail2faVerifyButton.disabled = ev.target.value.trim() === '';
			});
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
			const allowVulnerable = password === knownVulnerablePassword;
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

			BeaconWebRequest.post('/account/actions/password', body).then(() => {
				changePasswordForm.reset();

				try {
					const msg = {};
					if (regenerateKey) {
						msg.message = 'Your password and private key have been changed.';
					} else {
						msg.message = 'Your password has been changed.';
					}
					msg.explanation = 'All sessions have been revoked and your devices will need to sign in again.';
					BeaconDialog.show(msg.message, msg.explanation);
				} catch (e) {
					console.log(e);
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
					knownVulnerablePassword = password;
					errorMessage = 'Your password is vulnerable.';
					errorExplanation = 'Your password has been leaked in a previous breach and should not be used. To ignore this warning, you may submit the password again, but that is not recommended.';
					break;
				}

				BeaconDialog.show(errorMessage, errorExplanation);
			});

			return false;
		});
	}

	const passwordConfirmCheck = () => {
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
				authenticatorId: randomUUID(),
				type: 'TOTP',
				nickname: 'Google Authenticator',
				metadata: {
					secret: null,
					setup: null,
				},
			};

			addAuthenticatorCodeField.addEventListener('input', (ev) => {
				addAuthenticatorActionButton.disabled = ev.target.value.trim() === '';
			});

			addAuthenticatorButton.addEventListener('click', () => {
				authenticator.metadata.secret = generateSecret();
				authenticator.metadata.setup = `otpauth://totp/${encodeURIComponent('Beacon:' + userFullName + ' (' + authenticator.authenticatorId + ')')}?secret=${authenticator.metadata.secret}&issuer=Beacon`;

				if (addAuthenticatorQRCode) {
					addAuthenticatorQRCode.src = `/account/assets/qr.php?content=${btoa(authenticator.metadata.setup)}`;
					addAuthenticatorQRCode.setAttribute('alt', authenticator.metadata.setup);
					addAuthenticatorQRCode.setAttribute('title', authenticator.metadata.setup);
				}
				addAuthenticatorCodeField.value = '';

				BeaconDialog.showModal('add-authenticator-modal');
			});

			addAuthenticatorCancelButton.addEventListener('click', () => {
				BeaconDialog.hideModal();
			});

			addAuthenticatorActionButton.addEventListener('click', () => {
				authenticator.nickname = addAuthenticatorNicknameField.value.trim();
				authenticator.verificationCode = addAuthenticatorCodeField.value.trim();

				BeaconWebRequest.post(`https://${apiDomain}/v4/authenticators`, authenticator, { 'X-Beacon-Token': sessionId }).then(() => {
					window.location.reload(true);
				}).catch((error) => {
					const errorMessage = (() => {
						try {
							return JSON.parse(error.body).message;
						} catch (e) {
							return 'Incorrect verification code';
						}
					})();

					addAuthenticatorCodeField.classList.add('invalid');

					const label = document.querySelector(`label[for="${addAuthenticatorCodeField.id}"]`);
					if (label) {
						label.classList.add('invalid');
						label.innerText = errorMessage;
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
				});
			});
		} catch (e) {
			addAuthenticatorButton.addEventListener('click', () => {
				BeaconDialog.show('Sorry, this browser is not supported', 'There was an error generating the authenticator, which means your browser does not support modern cryptography features. Try again with an updated browser.');
			});
		}
	}

	const authenticatorRows = document.querySelectorAll('#authenticators-table tbody tr');
	let numAuthenticators = authenticatorRows.length;
	if (numAuthenticators > 0) {
		formatDates(true, false);

		if (timeZoneName) {
			timeZoneName.innerText = Intl.DateTimeFormat().resolvedOptions().timeZone;
		}

		const deleteButtons = document.querySelectorAll('button.delete_authenticator_button');
		for (const deleteButton of deleteButtons) {
			deleteButton.addEventListener('click', (event) => {
				const authenticatorId = event.target.getAttribute('beacon-authenticator-id');
				const nickname = event.target.getAttribute('beacon-authenticator-name');

				const confirm = {
					message: `Are you sure you want to delete the authenticator ${nickname}?`,
				};
				if (numAuthenticators > 1) {
					const remainingAuthenticators = numAuthenticators - 1;
					const authentictorWord = (remainingAuthenticators === 1) ? 'authenticator' : 'authenticators';
					confirm.explanation = `You will have ${remainingAuthenticators} ${authentictorWord} remaining. Your account will still be protected by two factor authentication.`;
				} else {
					confirm.explanation = 'This is your only authenticator. Deleting it will disable two factor authentication for your account. You will be able to add a new authenticator to enable two factor authentication again.';
				}

				BeaconDialog.confirm(confirm.message, confirm.explanation).then(() => {
					BeaconWebRequest.delete(`https://${apiDomain}/v4/authenticators/${authenticatorId}`, {'X-Beacon-Token': sessionId}).then(() => {
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
							explanation: `There was a ${error.status} error.`,
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
		replaceBackupCodesButton.addEventListener('click', () => {
			BeaconDialog.confirm('Replace backup codes?', 'This will replace all of your backup codes with new ones.').then(() => {
				BeaconWebRequest.post('/account/actions/replace_backup_codes', {}, {'X-Beacon-Token': sessionId}).then((response) => {
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
						explanation: `There was a ${error.status} error.`,
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

		BeaconWebRequest.delete(`https://${apiDomain}/v4/sessions/${encodeURIComponent(event.target.getAttribute('sessionHash'))}`, { 'X-Beacon-Token': sessionId }).then(() => {
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
		BeaconWebRequest.get(`https://${apiDomain}/v4/applications/${encodeURIComponent(applicationId)}`, { 'X-Beacon-Token': sessionId }).then((response) => {
			const parsed = JSON.parse(response.body);

		}).catch(() => {
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
					staticTokenErrorField.classList.add('hidden');
					switch (provider) {
					case 'nitrado':
						staticTokenGenerateLink.href = 'https://server.nitrado.net/usa/developer/tokens';
						staticTokenHelpField.innerText = 'Beacon requires long life tokens from Nitrado to have the "service" scope enabled.';
						staticTokenHelpField.classList.remove('hidden');
						break;
					case 'gameserverapp.com':
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
				BeaconWebRequest.delete(`https://${apiDomain}/v4/tokens/${tokenId}`, { 'X-Beacon-Token': sessionId }).then(() => {
					window.location.reload(true);
				}).catch(() => {
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

		staticTokenNameField.addEventListener('input', () => {
			checkStaticTokenActionButton();
		});

		staticTokenTokenField.addEventListener('input', () => {
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
					tokenName: staticTokenNameField.value.trim(),
				},
			};

			BeaconWebRequest.post(`https://${apiDomain}/v4/user/tokens`, tokenInfo, { 'X-Beacon-Token': sessionId }).then(() => {
				window.location.reload(true);
			}).catch((response) => {
				try {
					const parsed = JSON.parse(response.body);
					staticTokenErrorField.innerText = parsed.message;
				} catch {
					staticTokenErrorField.innerText = 'Could not save token.';
				}
				staticTokenErrorField.classList.remove('hidden');
				staticTokenActionButton.disabled = false;
			});
		});
	}

	const urlParams = new URLSearchParams(window.location.search);
	if (urlParams.get('message') && urlParams.get('explanation')) {
		BeaconDialog.show(urlParams.get('message'), urlParams.get('explanation'));

		const urlConstructor = window.URL || window.webkitURL || window.mozURL || window.msURL || window.oURL;
		const url = new urlConstructor(window.location);
		url.search = '';
		window.history.replaceState(null, document.title, url.toString());
	}

	/* Billing */
	const portalButton = document.getElementById('openBillingPortalButton');
	if (portalButton) {
		portalButton.addEventListener('click', (ev) => {
			ev.preventDefault();
			portalButton.disabled = true;

			const params = new URLSearchParams();
			params.append('returnUrl', portalButton.getAttribute('return-url'));

			BeaconWebRequest.get(`https://${apiDomain}/v4/user/billingPortal?${params.toString()}`, {'X-Beacon-Token': sessionId}).then((response) => {
				portalButton.disabled = false;
				try {
					const parsed = JSON.parse(response.body);
					window.location.href = parsed.portalUrl;
				} catch {
					BeaconDialog.show('Could not open your billing portal.', 'There was an unexpected error.');
				}
			}).catch(() => {
				portalButton.disabled = false;
				BeaconDialog.show('Could not open your billing portal.', 'Sorry about that. This can happen with older logins. Try signing out and signing back in.');
			});
		});
	}
});
