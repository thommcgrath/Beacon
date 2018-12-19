document.addEventListener('DOMContentLoaded', function(event) {
	var known_vulnerable_password = '';
	var current_page = 'intro';
	var show_page = function(to_page) {
		document.getElementById('login_page_' + current_page).style.display = 'none';
		document.getElementById('login_page_' + to_page).style.display = 'block';
		current_page = to_page;
	};
	
	var focus_first = function(field_ids) {
		for (var i = 0; i < field_ids.length; i++) {
			var field = document.getElementById(field_ids[i]);
			if (field.value == '') {
				field.focus();
				break;
			}
		}
	};
	
	document.getElementById('login_form_intro').addEventListener('submit', function(event) {
		event.preventDefault();
		
		var email = document.getElementById('login_email_field').value.trim();
		var password = document.getElementById('login_password_field').value;
		
		if (email === '' || password.length < 8) {
			dialog.show('Incomplete Login', 'Email must not be blank and password have at least 8 characters.');
			return false;
		}
		
		show_page('loading');
		
		request.post('https://api.' + window.location.hostname + '/v1/session.php', {}, function(obj) {
			window.location = '/account/auth.php?session_id=' + encodeURIComponent(obj.session_id) + '&return=' + encodeURIComponent(document.getElementById('login_return_field').value);
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
		}, {'Authorization': 'Basic ' + btoa(email + ':' + password)});
		
		return false;
	});
	
	document.getElementById('login_recover_button').addEventListener('click', function(event) {
		event.preventDefault();
		show_page('recover');
		focus_first(['recover_email_field']);
		return false;
	});
	
	document.getElementById('recover_cancel_button').addEventListener('click', function(event) {
		event.preventDefault();
		show_page('intro');
		return false;
	});
	
	document.getElementById('login_recover_form').addEventListener('submit', function(event) {
		event.preventDefault();
		var email = document.getElementById('recover_email_field').value.trim();
		request.post('/account/login/email.php', {'email': email}, function(obj) {
			if (obj.verified) {
				document.getElementById('password_email_field').value = obj.email;
				show_page('password');
				focus_first(['password_initial_field', 'password_confirm_field', 'password_action_button']);
			} else {
				document.getElementById('verify_email_field').value = obj.email;
				show_page('verify');
				focus_first(['verify_code_field', 'verify_action_button']);
			}
		}, function(http_status) {
			show_page('recover');
			dialog.show('Unable to continue', 'There was a ' + http_status + ' error while trying to send the verification email.');
		});
		return false;
	});
	
	document.getElementById('verify_cancel_button').addEventListener('click', function(event) {
		event.preventDefault();
		show_page('intro');
		return false;
	});
	
	document.getElementById('login_verify_form').addEventListener('submit', function(event) {
		event.preventDefault();
		show_page('loading');
		
		var code = document.getElementById('verify_code_field').value.trim();
		var email = document.getElementById('verify_email_field').value.trim();
		request.post('/account/login/verify.php', {'email': email, 'code': code}, function(obj) {
			if (obj.verified) {
				document.getElementById('password_email_field').value = obj.email;
				document.getElementById('password_code_field').value = code;
				if (obj.username) {
					document.getElementById('username_field').value = obj.username;
					document.getElementById('login_page_password').className = 'as-recover-user';
				}
				show_page('password');
				focus_first(['username_field', 'password_initial_field', 'password_confirm_field', 'password_action_button']);
			} else {
				document.getElementById('verify_code_field').value = '';
				show_page('verify');
				dialog.show('Incorrect code', 'The code entered is not correct.');
				document.getElementById('verify_code_field').focus();
			}	
		}, function(http_status) {
			show_page('verify');
			dialog.show('Unable to confirm', 'There was a ' + http_status + ' error while trying to verify the code.');
		});
	});
	
	document.getElementById('password_cancel_button').addEventListener('click', function(event) {
		event.preventDefault();
		show_page('intro');
		return false;
	});
	
	document.getElementById('login_password_form').addEventListener('submit', function(event) {
		event.preventDefault();
		
		var email = document.getElementById('password_email_field').value.trim();
		var code = document.getElementById('password_code_field').value;
		var username = document.getElementById('username_field').value;
		var password = document.getElementById('password_initial_field').value;
		var password_confirm = document.getElementById('password_confirm_field').value;
		var allow_vulnerable = password === known_vulnerable_password;
		
		if (password.length < 8) {
			dialog.show('Password too short', 'Your password must be at least 8 characters long.');
			return;
		}
		if (password !== password_confirm) {
			dialog.show('Passwords do not match', 'Please make sure the two passwords match.');
			return;
		}
		
		show_page('loading');
		request.post('/account/login/password.php', {'email': email, 'username': username, 'password': password, 'code': code, 'allow_vulnerable': allow_vulnerable}, function(obj) {
			window.location = '/account/auth.php?session_id=' + encodeURIComponent(obj.session_id) + '&return=' + encodeURIComponent(document.getElementById('login_return_field').value);
		}, function(http_status, content) {
			show_page('password');
			
			switch (http_status) {
			case 436:
			case 437:
			case 439:
				dialog.show('Unable to create Beacon account.', obj.message);
				break;
			case 438:
				known_vulnerable_password = password;
				dialog.show('Your password is vulnerable.', 'Your password has been leaked in a previous breach and should not be used. To ignore this warning, you may submit the password again, but that is not recommended.');
				break;
			default:
				dialog.show('Unable to create user', 'There was a ' + http_status + ' error while trying to create your account.');
				break;
			}
		});
	});
	
	document.getElementById('suggested-username-link').addEventListener('click', function(ev) {
		ev.preventDefault();
		
		document.getElementById('username_field').value = this.getAttribute('beacon-username');
		
		return false;
	});
	
	document.getElementById('new-suggestion-link').addEventListener('click', function(ev) {
		request.get('/account/login/suggest.php', {}, function(obj) {
			document.getElementById('suggested-username-link').innerText = obj.username;
			document.getElementById('suggested-username-link').setAttribute('beacon-username', obj.username);
		}, function(http_status, content) {});
		
		ev.preventDefault();
		return false;
	});
});