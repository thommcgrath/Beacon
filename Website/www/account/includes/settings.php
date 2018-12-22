<?php
BeaconTemplate::StartScript(); ?>
<script>
document.addEventListener('DOMContentLoaded', function(event) {
	var known_vulnerable_password = '';
	document.getElementById('password_action_button').addEventListener('click', function(event) {
		event.preventDefault();
		
		var current_password = document.getElementById('password_current_field').value;
		var password = document.getElementById('password_initial_field').value;
		var password_confirm = document.getElementById('password_confirm_field').value;
		var allow_vulnerable = password === known_vulnerable_password;
		
		if (password.length < 8) {
			dialog.show('Password too short', 'Your password must be at least 8 characters long.');
			return false;
		}
		if (password !== password_confirm) {
			dialog.show('Passwords do not match', 'Please make sure the two passwords match.');
			return false;
		}
		
		request.post('/account/actions/password.php', {'current_password': current_password, 'password': password, 'allow_vulnerable': allow_vulnerable}, function(obj) {
			document.getElementById('change_password_form').reset();
			dialog.show('Your password has been changed.', 'Changing your password does not sign you out of other devices.');
		}, function(http_status, content) {
			switch (http_status) {
			case 436:
			case 437:
			case 439:
				dialog.show('Unable to change password', obj.message);
				break;
			case 438:
				known_vulnerable_password = password;
				dialog.show('Your password is vulnerable.', 'Your password has been leaked in a previous breach and should not be used. To ignore this warning, you may submit the password again, but that is not recommended.');
				break;
			case 500:
				dialog.show('Password not changed.', 'Your password has not been changed because your current password is not correct.');
				break;
			default:
				dialog.show('Unable to change password', 'There was a ' + http_status + ' error while trying to create your account.');
				break;
			}
		});
		
		return false;
	});
	
	document.getElementById('username_action_button').addEventListener('click', function(ev) {
		ev.preventDefault();
		
		var username = document.getElementById('username_field').value.trim();
		if (username === '') {
			dialog.show('Username can not be empty', 'How did you press the button anyway?');
			return false;
		}
		
		request.post('/account/actions/username.php', {'username': username}, function(obj) {
			dialog.show('Username changed', 'Your username has been changed to "' + obj.username + '."', function() {
				window.location.reload(true);
			});
		}, function(http_status, content) {
			switch (http_status) {
			case 401:
				dialog.show('Username not changed', 'There was an authentication error.');
				break;
			default:
				dialog.show('Username not changed', 'Sorry, there was a ' + http_status + ' error.');
				break;
			}
		});
	});
	
	document.getElementById('suggested-username-link').addEventListener('click', function(ev) {
		ev.preventDefault();
		
		var field = document.getElementById('username_field');
		field.value = this.getAttribute('beacon-username');
		document.getElementById('username_action_button').disabled = field.value.trim() == '';
		
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
	
	document.getElementById('username_field').addEventListener('input', function(ev) {
		document.getElementById('username_action_button').disabled = this.value.trim() == '';
	});
});
</script>
<?php
BeaconTemplate::FinishScript();

BeaconTemplate::StartStyles(); ?>
<style>

a.username-suggestion {
	font-style: italic;
}

</style>
<?php
BeaconTemplate::FinishStyles();

$database = BeaconCommon::Database();
$results = $database->Query('SELECT generate_username() AS username;');
$suggested_username = $results->Field('username');

?><div class="small_section">
	<h3>Change Username</h3>
	<form id="change_username_form" action="" method="post">
		<p><input type="text" id="username_field" placeholder="New Username"><br><span class="smaller">How about <a href="#" id="suggested-username-link" class="username-suggestion" beacon-username="<?php echo htmlentities($suggested_username); ?>"><?php echo htmlentities($suggested_username); ?></a>? Or maybe <a href="#" id="new-suggestion-link">another suggestion</a>?</span></p>
		<p class="text-right"><input type="submit" id="username_action_button" value="Save Username" disabled></p>
	</form>
</div>
<div class="small_section">
	<h3>Change Password</h3>
	<form id="change_password_form" action="" method="post">
		<p><input type="password" id="password_current_field" placeholder="Current Password"></p>
		<p><input type="password" id="password_initial_field" placeholder="New Password" minlength="8"></p>
		<p><input type="password" id="password_confirm_field" placeholder="Confirm New Password" minlength="8"></p>
		<p class="text-right"><input type="submit" id="password_action_button" value="Save Password" disabled></p>
	</form>
</div>