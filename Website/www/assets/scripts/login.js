document.addEventListener('DOMContentLoaded', function() {
	var current_page;
	var pages = ['intro', 'login', 'recover', 'verify', 'password', 'loading'];
	pages.forEach(function(page) {
		var element = document.getElementById('login_page_' + page);
		if (element) {
			if (current_page) {
				element.classList.add('hidden');
			} else {
				current_page = page;
			}
		}
	});
	
	var show_page = function(to_page) {
		var fromElement = document.getElementById('login_page_' + current_page);
		var toElement = document.getElementById('login_page_' + to_page);
		if (fromElement && toElement) {
			fromElement.classList.add('hidden');
			toElement.classList.remove('hidden');
		}
		current_page = to_page;
	};
	
	var known_vulnerable_password = '';
	var i;
	
	var focus_first = function(field_ids) {
		var focused = false;
		var field;
		for (i = 0; i < field_ids.length; i++) {
			field = document.getElementById(field_ids[i]);
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
	
	var storedRemember = false;
	var storedEmail = '';
	if (localStorage) {
		storedEmail = localStorage.getItem('email');
		storedRemember = storedEmail !== null;
	}
	
	var loginForm = document.getElementById('login_form_intro');
	var loginEmailField = document.getElementById('login_email_field');
	var loginPasswordField = document.getElementById('login_password_field');
	var loginRememberCheck = document.getElementById('login_remember_check');
	var loginReturnField = document.getElementById('login_return_field');
	var loginRecoverButton = document.getElementById('login_recover_button');
	
	var recoverForm = document.getElementById('login_recover_form');
	var recoverEmailField = document.getElementById('recover_email_field');
	var recoverCancelButton = document.getElementById('recover_cancel_button');
	
	var verifyForm = document.getElementById('login_verify_form');
	var verifyCodeField = document.getElementById('verify_code_field');
	var verifyEmailField = document.getElementById('verify_email_field');
	var verifyCancelButton = document.getElementById('verify_cancel_button');
	var verifyActionButton = document.getElementById('verify_action_button');
	
	var passwordPage = document.getElementById('login_page_password');
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
	
	if (loginForm) {
		if (loginEmailField && storedRemember) {
			loginEmailField.value = storedEmail;
		}
		if (loginRememberCheck) {
			loginRememberCheck.checked = storedRemember;
		}
		
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
			
			if (loginEmail === '' || loginPassword.length < 8) {
				dialog.show('Incomplete Login', 'Email must not be blank and password have at least 8 characters.');
				return false;
			}
			
			show_page('loading');
			
			request.post('https://api.' + window.location.hostname + '/v1/session.php', {}, function(obj) {
				if (localStorage && loginRemember) {
					localStorage.setItem('email', loginEmail);
				}
				
				var url = '/account/auth.php?session_id=' + encodeURIComponent(obj.session_id) + '&return=' + encodeURIComponent(loginReturnURI);
				if (loginRemember == false) {
					url += '&temporary=true';
				}
				window.location = url;
			}, function(http_status) {
				show_page('intro');
				
				switch (http_status) {
				case 401:
					dialog.show('Incorrect Login', 'Username or password is not correct.');
					break;
				default:
					dialog.show('Unable to complete login', 'Sorry, there was a ' + http_status + ' error.');
					break;
				}
			}, {'Authorization': 'Basic ' + btoa(loginEmail + ':' + loginPassword)});
			
			return false;
		});
		
		if (loginRecoverButton) {
			loginRecoverButton.addEventListener('click', function(event) {
				event.preventDefault();
				
				if (recoverEmailField && loginEmailField) {
					recoverEmailField.value = loginEmailField.value;
				}
				
				show_page('recover');
				focus_first([recoverEmailField.id]);
				
				return false;
			});
		}
	}
	
	if (recoverForm) {
		recoverForm.addEventListener('submit', function(event) {
			event.preventDefault();
			
			var recoverEmail = '';
			if (recoverEmailField) {
				recoverEmail = recoverEmailField.value.trim();
			}
			
			request.post('/account/login/email.php', {'email': recoverEmail}, function(obj) {
				if (obj.verified) {
					if (passwordEmailField) {
						passwordEmailField.value = obj.email;
					}
					show_page('password');
					focus_first([passwordInitialField.id, passwordConfirmField.id, passwordActionButton.id]);
				} else {
					if (verifyEmailField) {
						verifyEmailField.value = obj.email;
					}
					show_page('verify');
					focus_first([verifyCodeField.id, verifyActionButton.id]);
				}
			}, function(http_status) {
				show_page('recover');
				dialog.show('Unable to continue', 'There was a ' + http_status + ' error while trying to send the verification email.');
			});
			return false;
		});
		
		if (recoverCancelButton) {
			recoverCancelButton.addEventListener('click', function(event) {
				event.preventDefault();
				show_page('intro');
				focus_first([loginEmailField.id, loginPasswordField.id]);
				return false;
			});
		}
	}
	
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
			
			request.post('/account/login/verify.php', {'email': verifiedEmail, 'code': verificationCode}, function(obj) {
				if (obj.verified) {
					if (passwordEmailField && passwordCodeField) {
						passwordEmailField.value = obj.email;
						passwordCodeField.value = verificationCode;
					}
					if (obj.username && passwordUsernameField) {
						passwordUsernameField.value = obj.username;
						passwordPage.className = 'as-recover-user';
					}
					show_page('password');
					focus_first([passwordUsernameField.id, passwordInitialField.id, passwordConfirmField.id, passwordActionButton.id]);
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
		});
		
		if (verifyCancelButton) {
			verifyCancelButton.addEventListener('click', function(event) {
				event.preventDefault();
				show_page('intro');
				focus_first([loginEmailField.id, loginPasswordField.id]);
				return false;
			});
		}
	}
	
	if (passwordForm) {
		passwordForm.addEventListener('submit', function(event) {
			event.preventDefault();
			
			var passwordEmail = '';
			var passwordVerificationCode = '';
			var passwordUsername = '';
			var passwordInitial = '';
			var passwordConfirm = '';
			var passwordAllowVulnerable = false;
			
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
			
			show_page('loading');
			request.post('/account/login/password.php', {'email': passwordEmail, 'username': passwordUsername, 'password': passwordInitial, 'code': passwordVerificationCode, 'allow_vulnerable': passwordAllowVulnerable}, function(obj) {
				if (localStorage && loginRemember) {
					localStorage.setItem('email', passwordEmail);
				}
				
				var url = '/account/auth.php?session_id=' + encodeURIComponent(obj.session_id) + '&return=' + encodeURIComponent(loginReturnURI);
				if (loginRemember == false) {
					url += '&temporary=true';
				}
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
				default:
					dialog.show('Unable to create user', 'There was a ' + http_status + ' error while trying to create your account.');
					break;
				}
			});
		});
		
		if (passwordCancelButton) {
			passwordCancelButton.addEventListener('click', function(event) {
				event.preventDefault();
				show_page('intro');
				focus_first([loginEmailField.id, loginPasswordField.id]);
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
				request.get('/account/login/suggest.php', {}, function(obj) {
					if (passwordUseSuggestedLink) {
						passwordUseSuggestedLink.innerText = obj.username;
						passwordUseSuggestedLink.setAttribute('beacon-username', obj.username);
					}
				}, function() {});
				
				ev.preventDefault();
				return false;
			});
		}
	}
});