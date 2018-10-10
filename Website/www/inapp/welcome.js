var dialog = {
	show: function(message, explanation) {
		var overlay = document.getElementById('overlay');
		var dialog_frame = document.getElementById('dialog');
		var dialog_message = document.getElementById('dialog_message');
		var dialog_explanation = document.getElementById('dialog_explanation');
		var dialog_action_button = document.getElementById('dialog_action_button');
		if (overlay && dialog && dialog_message && dialog_explanation && dialog_action_button) {
			overlay.className = 'exist';
			dialog_frame.className = 'exist';
			setTimeout(function() {
				overlay.className = 'exist visible';
				dialog_frame.className = 'exist visible';
			}, 1);
			
			dialog_message.innerText = message;
			dialog_explanation.innerText = explanation;
			dialog_action_button.addEventListener('click', function(event) {
				dialog.hide();
			});
		}
	},
	hide: function () {
		var overlay = document.getElementById('overlay');
		var dialog_frame = document.getElementById('dialog');
		if (overlay && dialog_frame) {
			overlay.className = 'exist';
			dialog_frame.className = 'exist';
			setTimeout(function() {
				overlay.className = '';
				dialog_frame.className = '';
			}, 200);
		}
	}
};

var request = {
	start: function(method, uri, success_handler, error_handler, headers) {
		var xhr = new XMLHttpRequest();
		xhr.open(method, uri, true);
		xhr.setRequestHeader('Accept', 'application/json');
		if (headers !== null) {
			for (var key in headers) {
				xhr.setRequestHeader(key, headers[key]);
			}
		}
		xhr.onreadystatechange = function() {
			if (xhr.readyState != 4) {
				return;
			}
			
			if (xhr.status != 200) {
				error_handler(xhr.status, xhr.responseText);
				return;
			}
			
			var obj = JSON.parse(xhr.responseText);
			success_handler(obj);
		};
		xhr.send();
	}
};

document.addEventListener('DOMContentLoaded', function(event) {
	var known_vulnerable_password = '';
	var current_page = 'intro';
	var show_page = function(to_page) {
		document.getElementById('page_' + current_page).style.display = 'none';
		document.getElementById('page_' + to_page).style.display = 'block';
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
	
	var cancel_function = function(event) {
		if (login_only) {
			if (current_page == 'login') {
				window.location = 'beacon://dismiss_me';
			} else {
				show_page('login');
				focus_first(['login_email_field', 'login_password_field', 'login_action_button']);
			}
		} else {
			show_page('intro');
		}
	};
	
	if (login_only) {
		show_page('login');
		focus_first(['login_email_field', 'login_password_field', 'login_action_button']);
	}
	
	document.getElementById('welcome_continue_button').addEventListener('click', function(event) {
		show_page('loading');
		
		window.location = 'beacon://set_user_privacy?action=anonymous';
	});
	
	document.getElementById('welcome_login_button').addEventListener('click', function(event) {
		show_page('login');
		focus_first(['login_email_field', 'login_password_field', 'login_action_button']);
	});
	
	document.getElementById('welcome_decline_button').addEventListener('click', function(event) {
		show_page('loading');
		
		window.location = 'beacon://set_user_privacy?action=full';
	});
	
	document.getElementById('login_cancel_button').addEventListener('click', cancel_function);
	
	document.getElementById('login_recover_button').addEventListener('click', function(event) {
		show_page('recover');
		document.getElementById('recover_email_field').value = document.getElementById('login_email_field').value;
		focus_first(['recover_email_field', 'recover_action_button']);
	});
	
	document.getElementById('recover_cancel_button').addEventListener('click', cancel_function);
	
	document.getElementById('verify_cancel_button').addEventListener('click', cancel_function);
	
	document.getElementById('password_cancel_button').addEventListener('click', cancel_function);
	
	document.getElementById('login_form').addEventListener('submit', function(event) {
		event.preventDefault();
		
		var email = document.getElementById('login_email_field').value.trim();
		var password = document.getElementById('login_password_field').value;
		
		if (email === '' || password.length < 8) {
			dialog.show('Incomplete Login', 'Email must not be blank and password have at least 8 characters.');
			return false;
		}
		
		show_page('loading');
		
		request.start('POST', 'https://api.' + window.location.hostname + '/v1/session.php', function(obj) {
			window.location = 'beacon://set_user_token?token=' + encodeURIComponent(obj.session_id) + '&password=' + encodeURIComponent(password);
		}, function(http_status) {
			show_page('login');
			
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
	
	document.getElementById('recover_form').addEventListener('submit', function(event) {
		event.preventDefault();
		show_page('loading');
		
		var email = document.getElementById('recover_email_field').value.trim();
		request.start('GET', '/inapp/email.php?email=' + encodeURIComponent(email), function(obj) {
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
	});
	
	document.getElementById('verify_form').addEventListener('submit', function(event) {
		event.preventDefault();
		show_page('loading');
		
		var code = document.getElementById('verify_code_field').value.trim();
		var email = document.getElementById('verify_email_field').value.trim();
		request.start('GET', '/inapp/verify.php?email=' + encodeURIComponent(email) + '&code=' + encodeURIComponent(code), function(obj) {
			if (obj.verified) {
				document.getElementById('password_email_field').value = obj.email;
				document.getElementById('password_code_field').value = code;
				show_page('password');
				focus_first(['password_initial_field', 'password_confirm_field', 'password_action_button']);
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
	
	document.getElementById('password_form').addEventListener('submit', function(event) {
		event.preventDefault();
		
		var email = document.getElementById('password_email_field').value.trim();
		var code = document.getElementById('password_code_field').value;
		var password = document.getElementById('password_initial_field').value;
		var password_confirm = document.getElementById('password_confirm_field').value;
		
		if (password.length < 8) {
			dialog.show('Password too short', 'Your password must be at least 8 characters long.');
			return;
		}
		if (password !== password_confirm) {
			dialog.show('Passwords do not match', 'Please make sure the two passwords match.');
			return;
		}
		
		show_page('loading');
		var url = '/inapp/password.php?email=' + encodeURIComponent(email) + '&password=' + encodeURIComponent(password) + '&code=' + encodeURIComponent(code);
		if (password == known_vulnerable_password) {
			url += '&allow_vulnerable=true';
		}
		request.start('GET', url, function(obj) {
			window.location = 'beacon://set_user_token?token=' + encodeURIComponent(obj.session_id) + '&password=' + encodeURIComponent(password);
		}, function(http_status, content) {
			show_page('password');
			
			switch (http_status) {
			case 436:
			case 437:
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
});