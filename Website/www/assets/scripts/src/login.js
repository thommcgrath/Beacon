"use strict";

document.addEventListener('DOMContentLoaded', () => {
	let currentPage = '';
	const pages = ['login', 'totp', 'recover', 'verify', 'password', 'loading', 'authorize'];
	pages.forEach((pageName) => {
		const element = document.getElementById(`page_${pageName}`);
		if (!element) {
			return;
		}
		if (!currentPage) {
			currentPage = pageName;
			return;
		}
		
		element.classList.add('hidden');
	});
	
	const showPage = (newPage) => {
		const fromElement = document.getElementById(`page_${currentPage}`);
		const toElement = document.getElementById(`page_${newPage}`);
		if (!(fromElement && toElement)) {
			return;
		}
		fromElement.classList.add('hidden');
		toElement.classList.remove('hidden');
		currentPage = newPage;
	};
	
	const focusFirst = (fieldIds, requireEmpty = true) => {
		let focused = false;
		for (const fieldId of fieldIds) {
			const field = (fieldId instanceof HTMLElement) ? fieldId : document.getElementById(fieldId);
			if (field && (requireEmpty === false || field.value === '')) {
				field.focus();
				focused = true;
				break;
			}
		}
		
		// if we didn't focus on the first empty something, go back and focus on the first something
		if (focused === false && requireEmpty === true) {
			focusFirst(fieldIds, false);
		}	
	};
	
	let knownVulnerablePassword = '';
	
	const loginPage = document.getElementById('page_login');
	const loginForm = document.getElementById('login_form_intro');
	const loginEmailField = document.getElementById('login_email_field');
	const loginPasswordField = document.getElementById('login_password_field');
	const loginRememberCheck = document.getElementById('login_remember_check');
	const loginRecoverButton = document.getElementById('login_recover_button');
	const loginCancelButton = document.getElementById('login_cancel_button');
	const loginActionButton = document.getElementById('login_action_button');
	
	const totpPage = document.getElementById('page_totp');
	const totpForm = document.getElementById('login_form_totp');
	const totpCodeField = document.getElementById('totp_code_field');
	const totpRememberCheck = document.getElementById('totp_remember_check');
	const totpActionButton = document.getElementById('totp_action_button');
	const totpCancelButton = document.getElementById('totp_cancel_button');
	
	const recoverForm = document.getElementById('login_recover_form');
	const recoverEmailField = document.getElementById('recover_email_field');
	const recoverActionButton = document.getElementById('recover_action_button');
	const recoverCancelButton = document.getElementById('recover_cancel_button');
	
	const verifyForm = document.getElementById('login_verify_form');
	const verifyCodeField = document.getElementById('verify_code_field');
	const verifyEmailField = document.getElementById('verify_email_field');
	const verifyCancelButton = document.getElementById('verify_cancel_button');
	const verifyActionButton = document.getElementById('verify_action_button');
	
	const passwordPage = document.getElementById('page_password');
	const passwordForm = document.getElementById('login_password_form');
	const passwordEmailField = document.getElementById('password_email_field');
	const passwordCodeField = document.getElementById('password_code_field');
	const passwordUsernameField = document.getElementById('username_field');
	const passwordCancelButton = document.getElementById('password_cancel_button');
	const passwordUseSuggestedLink = document.getElementById('suggested-username-link');
	const passwordNewSuggestionLink = document.getElementById('new-suggestion-link');
	const passwordInitialField = document.getElementById('password_initial_field');
	const passwordConfirmField = document.getElementById('password_confirm_field');
	const passwordActionButton = document.getElementById('password_action_button');
	const passwordAuthenticatorCodeParagraph = document.getElementById('password_totp_paragraph');
	const passwordAuthenticatorCodeLabel = document.getElementById('password_totp_label');
	const passwordAuthenticatorCodeField = document.getElementById('password_totp_field');
	
	const authorizePage = document.getElementById('page_authorize');
	const authorizeActionButton = document.getElementById('authorize_action_button');
	const authorizeCancelButton = document.getElementById('authorize_cancel_button');
	
	const loginReturnURI = loginParams.return;
	let loginRemember = false;
	
	let storedRemember = false;
	let storedEmail = null;
	const explicitEmail = loginParams.email;
	
	if (!explicitEmail && localStorage) {
		storedEmail = localStorage.getItem('email');
		storedRemember = (storedEmail !== null);
	}
	
	// !Login Page
	if (loginEmailField) {
		if (explicitEmail) {
			loginEmailField.value = explicitEmail;
		} else if (storedRemember) {
			loginEmailField.value = storedEmail;
		}
	}
	if (loginRememberCheck) {
		loginRememberCheck.checked = storedRemember;
	}
	if (loginForm || totpForm || authorizeActionButton) {
		const loginFunction = (ev) => {
			ev.preventDefault();
			
			if (!(loginEmailField && loginPasswordField)) {
				return false;
			}
			
			const loginEmail = loginEmailField.value.trim();
			const loginPassword = loginPasswordField.value;
			
			if (loginRememberCheck) {
				loginRemember = loginRememberCheck.checked;
			}
			
			if (loginRemember == false && localStorage) {
				localStorage.removeItem('email');
			}
			if (sessionStorage) {
				sessionStorage.removeItem('email');
			}
			
			if (loginEmail === '' || loginPassword.length < 8) {
				BeaconDialog.show('Incomplete Login', 'Email must not be blank and password have at least 8 characters.');
				return false;
			}
			
			showPage('loading');
			
			const sessionBody = {
				email: loginEmail,
				challenge: loginParams.challenge,
				challengeExpiration: loginParams.challengeExpiration,
				deviceId: loginParams.deviceId,
				loginId: loginParams.loginId
			};
			if (loginParams.appChallenge && loginParams.appChallengeExpiration) {
				sessionBody.appChallenge = loginParams.appChallenge;
				sessionBody.appChallengeExpiration = loginParams.appChallengeExpiration;
			} else {
				sessionBody.password = loginPassword;
				const totpCode = totpCodeField.value.trim();
				if (Boolean(totpCode) === true) {
					sessionBody.verificationCode = totpCode;
					sessionBody.trust = totpRememberCheck.checked;
				}
			}
			
			// We just stored these on sessionBody, clear them so the user gets a new auth
			// prompt if there is an error.
			loginParams.appChallenge = null;
			loginParams.appChallengeExpiration = null;
			
			BeaconWebRequest.post(`/account/login/check`, sessionBody).then((response) => {
				if (localStorage && loginRemember) {
					localStorage.setItem('email', loginEmail);
				}
				if (sessionStorage) {
					sessionStorage.setItem('email', loginEmail);
				}
				
				try {
					const obj = JSON.parse(response.body);
					if (obj.sessionId) {
						let url = loginParams.redeemUrl;
						url = url.replace('{{session_id}}', encodeURIComponent(obj.sessionId));
						url = url.replace('{{return_uri}}', encodeURIComponent(loginReturnURI));
						url = url.replace('{{user_password}}', encodeURIComponent(loginPassword));
						url = url.replace('{{temporary}}', (loginRemember == false ? 'true' : 'false'));
						
						window.location = url;
					} else if (obj.appChallenge) {
						loginParams.appChallenge = obj.appChallenge;
						loginParams.appChallengeExpiration = obj.appChallengeExpiration;
						showPage('authorize');
					} else if (obj.callback) {
						window.location = obj.callback;
					}
				} catch (e) {
					console.log(e);
				}
			}).catch((error) => {
				console.log(JSON.stringify(error));
				
				switch (error.status) {
				case 400:
					let loginErrorExplanation = 'There was an expected error.';
					try {
						const obj = JSON.parse(error.body);
						const code = obj.details.code;
						switch(code) {
						case 'CHALLENGE_TIMEOUT':
							loginErrorExplanation = 'The login process timed out. Please try again.';
							break;
						case 'COMPLETED':
							loginErrorExplanation = 'This authorization has already been completed. Please start again.';
							break;
						}
					} catch (e) {
					}
					
					BeaconDialog.show('Unable to complete login', loginErrorExplanation).then(() => {
						showPage('login');
					});
					
					break;
				case 401:
				case 403:
					try {
						const obj = JSON.parse(error.body);
						const code = obj.details.code;
						if (code === '2FA_ENABLED') {
							showPage('totp');
							focusFirst([totpCodeField]);
							break;
						}
					} catch (e) {
					}
					
					BeaconDialog.show('Incorrect Login', 'Email or password is not correct.').then(() => {
						showPage('login');
					});
					break;
				default:
					BeaconDialog.show('Unable to complete login', `Sorry, there was a ${error.status} error.`).then(() => {
						showPage('login');
					});
					break;
				}
			});
			
			return false;
		};
		
		if (loginForm) {
			loginForm.addEventListener('submit', loginFunction);
		}
		
		if (totpForm) {
			totpForm.addEventListener('submit', loginFunction);
		}
		
		if (authorizeActionButton) {
			authorizeActionButton.addEventListener('click', loginFunction);
		}
	}
	
	if (loginRecoverButton) {
		loginRecoverButton.addEventListener('click', (ev) => {
			ev.preventDefault();
			
			if (recoverEmailField && loginEmailField) {
				recoverEmailField.value = loginEmailField.value;
			}
			
			showPage('recover');
			focusFirst([recoverEmailField]);
			
			return false;
		});
	}
	if (loginCancelButton) {
		loginCancelButton.addEventListener('click', (ev) => {
			ev.preventDefault();
			window.location = 'beacon://dismiss_me';
			return false;
		});
	}
	if (totpCancelButton) {
		totpCancelButton.addEventListener('click', (ev) => {
			ev.preventDefault();
			showPage('login');
			focusFirst([loginPasswordField]);
		});
	}
	
	
	// !Recovery Page
	if (recoverForm) {
		recoverForm.addEventListener('submit', (ev) => {
			ev.preventDefault();
			if (recoverActionButton) {
				recoverActionButton.disabled = true;
			}
			
			if (!recoverEmailField) {
				console.log('Missing email field');
				return;
			}
			
			const params = new URLSearchParams();
			params.append('email', recoverEmailField.value.trim());
			if (loginParams.loginId) {
				params.append('flowId', loginParams.loginId);
			}
			
			BeaconWebRequest.post('/account/login/email', params).then((response) => {
				try {
					const obj = JSON.parse(response.body);
					if (recoverActionButton) {
						recoverActionButton.disabled = false;
					}
					
					if (obj.verified) {
						if (passwordEmailField) {
							passwordEmailField.value = obj.email;
						}
						showPage('password');
						focusFirst([passwordInitialField, passwordConfirmField, passwordActionButton]);
					} else {
						if (verifyEmailField) {
							verifyEmailField.value = obj.email;
						}
						showPage('verify');
						focusFirst([verifyCodeField, verifyActionButton]);
					}
				} catch (e) {
					console.log(e);
				}
			}).catch((error) => {
				console.log(JSON.stringify(error));
				
				if (recoverActionButton) {
					recoverActionButton.disabled = false;
				}
				
				const alert = {
					message: 'Unable to continue',
					explanation: `There was a ${error.status} error while trying to send the verification email.`
				};
				
				try {
					const obj = JSON.parse(error.body);
					if (obj.message) {
						alert.explanation = obj.message;
					}
				} catch (err) {
					console.log(err);
				}
				
				BeaconDialog.show(alert.message, alert.explanation).then(() => {
					showPage('recover');
				});
			});
			
			return false;
		});
	}
	if (recoverCancelButton) {
		recoverCancelButton.addEventListener('click', (ev) => {
			ev.preventDefault();
			showPage('login');
			focusFirst([loginEmailField, loginPasswordField, loginActionButton]);
			return false;
		});
	}
	
	// !Address verification
	if (verifyForm) {
		verifyForm.addEventListener('submit', (ev) => {
			ev.preventDefault();
			
			if (!(verifyCodeField && verifyEmailField)) {
				console.log('Missing fields');
				return;
			}
			
			showPage('loading');
			
			const params = new URLSearchParams();
			params.append('email', verifyEmailField.value.trim());
			params.append('code', verifyCodeField.value.trim());
			
			BeaconWebRequest.post('/account/login/verify', params).then((response) => {
				try {
					const obj = JSON.parse(response.body);
					if (obj.verified) {
						if (passwordEmailField && passwordCodeField) {
							passwordEmailField.value = obj.email;
							passwordCodeField.value = obj.code;
						}
						if (obj.username && passwordUsernameField) {
							passwordUsernameField.value = obj.username;
							passwordPage.className = 'as-recover-user';
						}
						showPage('password');
						focusFirst([passwordUsernameField, passwordInitialField, passwordConfirmField, passwordActionButton]);
					} else {
						BeaconDialog.show('Incorrect code', 'The code entered is not correct.').then(() => {
							showPage('verify');
							if (verifyCodeField) {
								verifyCodeField.value = '';
								verifyCodeField.focus();
							}
						});
					}
				} catch (e) {
					console.log(e);
				}
			}).catch((error) => {
				console.log(JSON.stringify(error));
				BeaconDialog.show('Unable to confirm', `There was a ${error.status} error while trying to verify the code.`).then(() => {
					showPage('verify');
				});
			});
			
			return false;
		});
	}
	if (verifyCancelButton) {
		verifyCancelButton.addEventListener('click', (ev) => {
			ev.preventDefault();
			showPage('login');
			focusFirst([loginEmailField, loginPasswordField, loginActionButton]);
			return false;
		});
	}
	
	// !Password form
	if (passwordForm) {
		let passwordConfirmChildrenReset = false;
		
		passwordForm.addEventListener('submit', (ev) => {
			ev.preventDefault();
			
			const passwordEmail = (passwordEmailField) ? passwordEmailField.value.trim() : '';
			const passwordVerificationCode = (passwordCodeField) ? passwordCodeField.value.trim() : '';
			const passwordUsername = (passwordUsernameField) ? passwordUsernameField.value : '';
			const passwordInitial = (passwordInitialField) ? passwordInitialField.value : '';
			const passwordConfirm = (passwordConfirmField) ? passwordConfirmField.value : '';
			const passwordAllowVulnerable = (passwordInitial === knownVulnerablePassword);
			const passwordAuthenticatorCode = (passwordAuthenticatorCodeField) ? passwordAuthenticatorCodeField.value : '';
			
			if (passwordInitial.length < 8) {
				BeaconDialog.show('Password too short', 'Your password must be at least 8 characters long.');
				return false;
			}
			if (passwordInitial !== passwordConfirm) {
				BeaconDialog.show('Passwords do not match', 'Please make sure the two passwords match.');
				return false;
			}
			
			const form = new URLSearchParams();
			form.append('email', passwordEmail);
			form.append('username', passwordUsername);
			form.append('password', passwordInitial);
			form.append('code', passwordVerificationCode);
			form.append('allow_vulnerable', passwordAllowVulnerable);
			form.append('confirm_reset_children', passwordConfirmChildrenReset);
			form.append('verification_code', passwordAuthenticatorCode);
			form.append('no_session', 'true');
			
			showPage('loading');
			BeaconWebRequest.post('/account/login/password', form).then((response) => {
				try {
					const obj = JSON.parse(response.body);
					if (localStorage && loginRemember) {
						localStorage.setItem('email', passwordEmail);
					}
					
					// Password has been changed, so now we run through normal login
					loginEmailField.value = passwordEmail;
					loginPasswordField.value = passwordInitial;
					totpCodeField.value = passwordAuthenticatorCode;
					loginForm.dispatchEvent(new Event('submit', {'bubbles': true, 'cancelable': true}));
				} catch (e) {
					console.log(e);
				}
			}).catch((error) => {
				console.log(JSON.stringify(error));
				
				let dialog;
				try {
					const obj = JSON.parse(error.body);
					
					switch (error.status) {
					case 403:
						if (passwordAuthenticatorCodeParagraph) {
							if (passwordAuthenticatorCodeParagraph.classList.contains('hidden')) {
								passwordAuthenticatorCodeParagraph.classList.remove('hidden');
							} else {
								if (passwordAuthenticatorCodeLabel) {
									passwordAuthenticatorCodeLabel.classList.add('invalid');
									passwordAuthenticatorCodeLabel.innerText = 'Incorrect Code';
								}
								if (passwordAuthenticatorCodeField) {
									passwordAuthenticatorCodeField.classList.add('invalid');
								}
								
								setTimeout(() => {
									if (passwordAuthenticatorCodeLabel) {
										passwordAuthenticatorCodeLabel.classList.remove('invalid');
										passwordAuthenticatorCodeLabel.innerText = 'Two Step Verification Code';
									}
									if (passwordAuthenticatorCodeField) {
										passwordAuthenticatorCodeField.classList.remove('invalid');
									}
								}, 3000);
							}
						}
						showPage('password');
						break;
					case 436:
					case 437:
						dialog = BeaconDialog.show('Unable to create Beacon account.', obj.message);
						break;
					case 438:
						knownVulnerablePassword = passwordInitial;
						dialog = BeaconDialog.show('Your password is vulnerable.', 'Your password has been leaked in a previous breach and should not be used. To ignore this warning, you may submit the password again, but that is not recommended.');
						break;
					case 439:
						BeaconDialog.confirm('WARNING!', 'Your team members will be unable to sign into their accounts until you reset each of their passwords once you sign in. See the "Team" section of your Beacon account control panel.', 'Reset Password').then(() => {
							passwordConfirmChildrenReset = true;
							passwordForm.dispatchEvent(new Event('submit', {'bubbles': true, 'cancelable': true}));
						}).catch(() => {
							showPage('password');
						});
						break;
					default:
						dialog = BeaconDialog.show('Unable to create user', `There was a ${error.status} error while trying to create your account.`);
						break;
					}
					
					if (dialog) {
						dialog.then(() => {
							showPage('password');
						});
					}
				} catch (e) {
					console.log(e);
				}
			});
		});
	}
	if (passwordCancelButton) {
		passwordCancelButton.addEventListener('click', (ev) => {
			ev.preventDefault();
			showPage('login');
			focusFirst([loginEmailField, loginPasswordField, loginActionButton]);
			return false;
		});
	}
	if (passwordUseSuggestedLink) {
		passwordUseSuggestedLink.addEventListener('click', (ev) => {
			ev.preventDefault();
			
			if (passwordUsernameField) {
				passwordUsernameField.value = ev.target.getAttribute('beacon-username');
			}
			
			return false;
		});
	}
	if (passwordNewSuggestionLink) {
		passwordNewSuggestionLink.addEventListener('click', (ev) => {
			BeaconWebRequest.get('/account/login/suggest').then((response) => {
				try {
					const obj = JSON.parse(response.body);
					if (passwordUseSuggestedLink) {
						passwordUseSuggestedLink.innerText = obj.username;
						passwordUseSuggestedLink.setAttribute('beacon-username', obj.username);
					}
				} catch (e) {
					console.log(e);
				}
			}).catch((error) => {
				console.log(JSON.stringify(error));
			});
			
			ev.preventDefault();
			return false;
		});
	}
	
	// !Authorization form
	if (passwordCancelButton) {
		passwordCancelButton.addEventListener('click', (ev) => {
			loginParams.appChallenge = null;
			loginParams.appChallengeExpiration = null;
			loginPasswordField.value = '';
			showPage('login');
		});
	}
	
	if (window.location.hash == '#create') {
		if (recoverEmailField && explicitEmail) {
			recoverEmailField.value = explicitEmail;
		}
		showPage('recover');
	} else if (loginParams.email && loginParams.code) {
		verifyEmailField.value = loginParams.email;
		verifyCodeField.value = loginParams.code;
		verifyForm.dispatchEvent(new Event('submit', {'bubbles': true, 'cancelable': true}));
	}
	
	//if (window.location.search !== '') {
	//	window.history.pushState({}, '', '/account/login');	
	//}
});
