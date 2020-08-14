document.addEventListener('DOMContentLoaded', function() {
	var current_page;
	var pages = ['login', 'recover', 'verify', 'password', 'loading'];
	pages.forEach(function(page) {
		var element = document.getElementById('page_' + page);
		if (!element) {
			return;
		}
		
		if (!current_page) {
			current_page = page;
			return;
		}
		
		element.classList.add('hidden');
	});
	
	var show_page = function(to_page) {
		var fromElement = document.getElementById('page_' + current_page);
		var toElement = document.getElementById('page_' + to_page);
		if (fromElement && toElement) {
			fromElement.classList.add('hidden');
			toElement.classList.remove('hidden');
			current_page = to_page;
		}
	};
	
	var known_vulnerable_password = '';
	var i;
	var consumeURI;
	
	var focus_first = function(field_ids) {
		var focused = false;
		var field;
		for (i = 0; i < field_ids.length; i++) {
			if (field_ids[i] instanceof HTMLElement) {
				field = field_ids[i];
			} else {
				field = document.getElementById(field_ids[i]);
			}
			if (field && field.value == '') {
				field.focus();
				focused = true;
				break;
			}
		}
		if (focused == false) {
			for (i = 0; i < field_ids.length; i++) {
				field = document.getElementById(field_ids[i]);
				if (field) {
					field.focus();
					return;
				}
			}
		}
	};
	
	var loginPage = document.getElementById('page_login');
	var loginForm = document.getElementById('login_form_intro');
	var loginEmailField = document.getElementById('login_email_field');
	var loginPasswordField = document.getElementById('login_password_field');
	var loginRememberCheck = document.getElementById('login_remember_check');
	var loginReturnField = document.getElementById('login_return_field');
	var loginRecoverButton = document.getElementById('login_recover_button');
	var loginCancelButton = document.getElementById('login_cancel_button');
	var loginActionButton = document.getElementById('login_action_button');
	var loginExplicitEmailField = document.getElementById('login_explicit_email');
	var loginExplicitCodeField = document.getElementById('login_explicit_code');
	var loginExplicitPasswordField = document.getElementById('login_explicit_password');
	
	var recoverForm = document.getElementById('login_recover_form');
	var recoverEmailField = document.getElementById('recover_email_field');
	var recoverActionButton = document.getElementById('recover_action_button');
	var recoverCancelButton = document.getElementById('recover_cancel_button');
	
	var verifyForm = document.getElementById('login_verify_form');
	var verifyCodeField = document.getElementById('verify_code_field');
	var verifyEmailField = document.getElementById('verify_email_field');
	var verifyCancelButton = document.getElementById('verify_cancel_button');
	var verifyActionButton = document.getElementById('verify_action_button');
	
	var passwordPage = document.getElementById('page_password');
	var passwordForm = document.getElementById('login_password_form');
	var passwordEmailField = document.getElementById('password_email_field');
	var passwordCodeField = document.getElementById('password_code_field');
	var passwordUsernameField = document.getElementById('username_field');
	var passwordCancelButton = document.getElementById('password_cancel_button');
	var passwordUseSuggestedLink = document.getElementById('suggested-username-link');
	var passwordNewSuggestionLink = document.getElementById('new-suggestion-link');
	var passwordInitialField = document.getElementById('password_initial_field');
	var passwordConfirmField = document.getElementById('password_confirm_field');
	var passwordActionButton = document.getElementById('password_action_button');
	
	var loginReturnURI = '';
	var loginRemember = false;
	if (loginReturnField) {
		loginReturnURI = loginReturnField.value;
	}
	
	var storedRemember = false;
	var storedEmail = null;
	var explicitEmail = null;
	if (loginExplicitEmailField) {
		explicitEmail = loginExplicitEmailField.value;
	}
	if (explicitEmail === null && localStorage) {
		storedEmail = localStorage.getItem('email');
		storedRemember = storedEmail !== null;
	}
	
	var consumeURI;
	if (passwordPage) {
		consumeURI = passwordPage.getAttribute('beacon-consumer-uri');
	}
	
	// !Login Page
	if (loginEmailField) {
		if (explicitEmail !== null) {
			loginEmailField.value = explicitEmail;
		} else if (storedRemember) {
			loginEmailField.value = storedEmail;
		}
	}
	if (loginRememberCheck) {
		loginRememberCheck.checked = storedRemember;
	}
	if (loginForm) {
		loginForm.addEventListener('submit', function(event) {
			event.preventDefault();
			
			var loginEmail = '';
			var loginPassword = '';
			
			if (loginEmailField && loginPasswordField) {
				loginEmail = loginEmailField.value.trim();
				loginPassword = loginPasswordField.value;
			}
			
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
				dialog.show('Incomplete Login', 'Email must not be blank and password have at least 8 characters.');
				return false;
			}
			
			show_page('loading');
			
			let hostnamePattern = /(([^\.]+)\.)?([^\.]+\.[^\.]+)/i;
			let hostnameResults = hostnamePattern.exec(window.location.hostname);
			let apiHost;
			if (hostnameResults === null) {
				apiHost = 'api.usebeacon.app';
			} else if (hostnameResults[2] === undefined || hostnameResults[2] === 'www') {
				apiHost = 'api.' + hostnameResults[3];
			} else {
				apiHost = hostnameResults[2] + '-api.' + hostnameResults[3];
			}
			
			request.post('https://' + apiHost + '/v2/session', {}, function(obj) {
				if (localStorage && loginRemember) {
					localStorage.setItem('email', loginEmail);
				}
				if (sessionStorage) {
					sessionStorage.setItem('email', loginEmail);
				}
				
				var url = consumeURI;
				url = url.replace('{{session_id}}', encodeURIComponent(obj.session_id));
				url = url.replace('{{return_uri}}', encodeURIComponent(loginReturnURI));
				url = url.replace('{{user_password}}', encodeURIComponent(loginPassword));
				url = url.replace('{{temporary}}', (loginRemember == false ? 'false' : 'true'));
				
				window.location = url;
			}, function(http_status, error_body) {
				show_page('login');
				
				switch (http_status) {
				case 401:
				case 403:
					dialog.show('Incorrect Login', 'Email or password is not correct.');
					break;
				default:
					dialog.show('Unable to complete login', 'Sorry, there was a ' + http_status + ' error.');
					break;
				}
			}, {'Authorization': 'Basic ' + btoa(loginEmail + ':' + loginPassword)});
			
			return false;
		});
	}
	if (loginRecoverButton) {
		loginRecoverButton.addEventListener('click', function(event) {
			event.preventDefault();
			
			if (recoverEmailField && loginEmailField) {
				recoverEmailField.value = loginEmailField.value;
			}
			
			show_page('recover');
			focus_first([recoverEmailField]);
			
			return false;
		});
	}
	if (loginCancelButton) {
		loginCancelButton.addEventListener('click', function(ev) {
			ev.preventDefault();
			window.location = 'beacon://dismiss_me';
			return false;
		});
	}
	
	// !Recovery Page
	if (recoverForm) {
		recoverForm.addEventListener('submit', function(event) {
			event.preventDefault();
			if (recoverActionButton) {
				recoverActionButton.disabled = true;
			}
			
			var recoverEmail = '';
			if (recoverEmailField) {
				recoverEmail = recoverEmailField.value.trim();
			}
			
			request.post('/account/login/email', {'email': recoverEmail}, function(obj) {
				if (recoverActionButton) {
					recoverActionButton.disabled = false;
				}
				
				if (obj.verified) {
					if (passwordEmailField) {
						passwordEmailField.value = obj.email;
					}
					show_page('password');
					focus_first([passwordInitialField, passwordConfirmField, passwordActionButton]);
				} else {
					if (verifyEmailField) {
						verifyEmailField.value = obj.email;
					}
					show_page('verify');
					focus_first([verifyCodeField, verifyActionButton]);
				}
			}, function(http_status, response) {
				if (recoverActionButton) {
					recoverActionButton.disabled = false;
				}
				
				var message = 'There was a ' + http_status + ' error while trying to send the verification email.';
				try {
					var obj = JSON.parse(response);
					if (obj.message) {
						message = obj.message;
					}
				} catch (err) {
				}
				
				show_page('recover');
				dialog.show('Unable to continue', message);
			});
			return false;
		});
	}
	if (recoverCancelButton) {
		recoverCancelButton.addEventListener('click', function(event) {
			event.preventDefault();
			show_page('login');
			focus_first([loginEmailField, loginPasswordField, loginActionButton]);
			return false;
		});
	}
	
	// !Address verification
	if (verifyForm) {
		verifyForm.addEventListener('submit', function(event) {
			event.preventDefault();
			show_page('loading');
			
			var verificationCode = '';
			var verifiedEmail = '';
			if (verifyCodeField) {
				verificationCode = verifyCodeField.value.trim();
			}
			if (verifyEmailField) {
				verifiedEmail = verifyEmailField.value.trim();
			}
			
			request.post('/account/login/verify', {'email': verifiedEmail, 'code': verificationCode}, function(obj) {
				if (obj.verified) {
					if (passwordEmailField && passwordCodeField) {
						passwordEmailField.value = obj.email;
						passwordCodeField.value = obj.code;
					}
					if (obj.username && passwordUsernameField) {
						passwordUsernameField.value = obj.username;
						passwordPage.className = 'as-recover-user';
					}
					show_page('password');
					focus_first([passwordUsernameField, passwordInitialField, passwordConfirmField, passwordActionButton]);
				} else {
					if (verifyCodeField) {
						verifyCodeField.value = '';
					}
					show_page('verify');
					dialog.show('Incorrect code', 'The code entered is not correct.');
					if (verifyCodeField) {
						verifyCodeField.focus();
					}
				}	
			}, function(http_status) {
				show_page('verify');
				dialog.show('Unable to confirm', 'There was a ' + http_status + ' error while trying to verify the code.');
			});
			
			return false;
		});
	}
	if (verifyCancelButton) {
		verifyCancelButton.addEventListener('click', function(event) {
			event.preventDefault();
			show_page('login');
			focus_first([loginEmailField, loginPasswordField, loginActionButton]);
			return false;
		});
	}
	
	// !Password form
	if (passwordForm) {
		var passwordConfirmChildrenReset = false;
		
		passwordForm.addEventListener('submit', function(event) {
			event.preventDefault();
			
			var passwordEmail = '';
			var passwordVerificationCode = '';
			var passwordUsername = '';
			var passwordInitial = '';
			var passwordConfirm = '';
			var passwordAllowVulnerable = false;
			var passwordPrevious = null;
			
			if (passwordEmailField) {
				passwordEmail = passwordEmailField.value.trim();
			}
			if (passwordCodeField) {
				passwordVerificationCode = passwordCodeField.value.trim();
			}
			if (passwordUsernameField) {
				passwordUsername = passwordUsernameField.value;
			}
			if (passwordInitialField) {
				passwordInitial = passwordInitialField.value;
			}
			if (passwordConfirmField) {
				passwordConfirm = passwordConfirmField.value;
			}
			passwordAllowVulnerable = (passwordInitial === known_vulnerable_password);
			
			if (passwordInitial.length < 8) {
				dialog.show('Password too short', 'Your password must be at least 8 characters long.');
				return;
			}
			if (passwordInitial !== passwordConfirm) {
				dialog.show('Passwords do not match', 'Please make sure the two passwords match.');
				return;
			}
			if (loginExplicitPasswordField) {
				passwordPrevious = loginExplicitPasswordField.value;
			}
			
			let form = {
				'email': passwordEmail,
				'username': passwordUsername,
				'password': passwordInitial,
				'code': passwordVerificationCode,
				'allow_vulnerable': passwordAllowVulnerable,
				'confirm_reset_children': passwordConfirmChildrenReset
			};
			if (passwordPrevious) {
				form.previous_password = passwordPrevious;
			}
			
			show_page('loading');
			request.post('/account/login/password', form, function(obj) {
				if (localStorage && loginRemember) {
					localStorage.setItem('email', passwordEmail);
				}
				
				var url = consumeURI;
				url = url.replace('{{session_id}}', encodeURIComponent(obj.session_id));
				url = url.replace('{{return_uri}}', encodeURIComponent(loginReturnURI));
				url = url.replace('{{user_password}}', encodeURIComponent(passwordInitial));
				url = url.replace('{{temporary}}', (loginRemember == false ? 'false' : 'true'));
				
				window.location = url;
			}, function(http_status, content) {
				show_page('password');
				
				var obj = JSON.parse(content);
				
				switch (http_status) {
				case 436:
				case 437:
					dialog.show('Unable to create Beacon account.', obj.message);
					break;
				case 438:
					known_vulnerable_password = passwordInitial;
					dialog.show('Your password is vulnerable.', 'Your password has been leaked in a previous breach and should not be used. To ignore this warning, you may submit the password again, but that is not recommended.');
					break;
				case 439:
					dialog.confirm('WARNING!', 'Your team members will be unable to sign into their accounts until you reset each of their passwords once you sign in. See the "Team" section of your Beacon account control panel.', 'Reset Password', 'Cancel', function() {
						passwordConfirmChildrenReset = true;
						var event = new Event('submit', {'bubbles': true, 'cancelable': true});
						passwordForm.dispatchEvent(event);
					});
					break;
				default:
					dialog.show('Unable to create user', 'There was a ' + http_status + ' error while trying to create your account.');
					break;
				}
			});
		});
	}
	if (passwordCancelButton) {
		passwordCancelButton.addEventListener('click', function(event) {
			event.preventDefault();
			show_page('login');
			focus_first([loginEmailField, loginPasswordField, loginActionButton]);
			return false;
		});
	}
	if (passwordUseSuggestedLink) {
		passwordUseSuggestedLink.addEventListener('click', function(ev) {
			ev.preventDefault();
			
			if (passwordUsernameField) {
				passwordUsernameField.value = this.getAttribute('beacon-username');
			}
			
			return false;
		});
	}
	if (passwordNewSuggestionLink) {
		passwordNewSuggestionLink.addEventListener('click', function(ev) {
			request.get('/account/login/suggest', {}, function(obj) {
				if (passwordUseSuggestedLink) {
					passwordUseSuggestedLink.innerText = obj.username;
					passwordUseSuggestedLink.setAttribute('beacon-username', obj.username);
				}
			}, function() {});
			
			ev.preventDefault();
			return false;
		});
	}
	
	if (window.location.hash == '#create') {
		if (recoverEmailField && explicitEmail) {
			recoverEmailField.value = explicitEmail;
		}
		show_page('recover');
	} else if (loginExplicitEmailField && loginExplicitCodeField && verifyCodeField && verifyEmailField) {
		verifyEmailField.value = loginExplicitEmailField.value;
		verifyCodeField.value = loginExplicitCodeField.value;
		
		var event = new Event('submit', {'bubbles': true, 'cancelable': true});
		verifyForm.dispatchEvent(event);
	}
	
	if (window.location.search !== '') {
		window.history.pushState({}, '', '/account/login/');	
	}
});
