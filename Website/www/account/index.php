<?php
	
require(dirname(__FILE__, 3) . '/framework/loader.php');

$session = BeaconSession::GetFromCookie();
if (is_null($session)) {
	BeaconTemplate::SetTemplate('login');
	exit;
}

header('Cache-Control: no-cache');

$user = BeaconUser::GetByUserID($session->UserID());
BeaconTemplate::SetTitle('Account: ' . $user->LoginKey());

BeaconTemplate::StartScript(); ?>
<script>
document.addEventListener('DOMContentLoaded', function(event) {
	var known_vulnerable_password = '';
	
	document.getElementById('password_action_button').addEventListener('click', function(event) {
		event.preventDefault();
		
		var current_password = document.getElementById('password_current_field').value;
		var password = document.getElementById('password_initial_field').value;
		var password_confirm = document.getElementById('password_confirm_field').value;
		
		if (password.length < 8) {
			dialog.show('Password too short', 'Your password must be at least 8 characters long.');
			return false;
		}
		if (password !== password_confirm) {
			dialog.show('Passwords do not match', 'Please make sure the two passwords match.');
			return false;
		}
		
		var url = '/account/password.php?current_password=' + encodeURIComponent(current_password) + '&password=' + encodeURIComponent(password);
		if (password == known_vulnerable_password) {
			url += '&allow_vulnerable=true';
		}
		request.start('GET', url, function(obj) {
			document.getElementById('change_password_form').reset();
			dialog.show('Your password has been changed.', 'Changing your password does not sign you out of other devices.');
		}, function(http_status, content) {
			switch (http_status) {
			case 436:
			case 437:
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
	
	var delete_buttons = document.querySelectorAll('[beacon-action="delete"]');
	for (var i = 0; i < delete_buttons.length; i++) {
		var button = delete_buttons[i];
		button.addEventListener('click', function(event) {
			event.preventDefault();
			
			var resource_url = this.getAttribute('beacon-resource-url');
			var resource_name = this.getAttribute('beacon-resource-name');
			
			dialog.show('Are you sure you want to delete the document "' + resource_name + '?"', 'The document will be deleted immediately and cannot be recovered.', function() {
				request.start('DELETE', resource_url, function(obj) {
					dialog.show('Document deleted', '"' + resource_name + '" has been deleted.', function() {
						window.location.reload(true);
					});
				}, function(http_status) {
					switch (http_status) {
					case 401:
						dialog.show('Document not deleted', 'There was an authentication error');
						break;
					default:
						dialog.show('Document not deleted', 'Sorry, there was a ' + http_status + ' error.');
						break;
					}
				}, {'Authorization': <?php echo json_encode('Session ' . $session->SessionID()); ?>});
			});
			
			return false;
		});
	}
});
</script>
<?php
BeaconTemplate::FinishScript();

?><h1><?php echo htmlentities($user->LoginKey()); ?></h1>
<p><a href="/account/auth.php?return=<?php echo urlencode('/'); ?>">Sign Out</a></p><?php

$keys = array(
	'user_id' => $user->UserID()
);
$documents = BeaconDocumentMetadata::Search($keys);
if (count($documents) > 0) {
	echo '<h3>Documents</h3>';
	echo '<table class="generic">';
	echo '<thead><tr><th>Name</th><th>Downloads</th><th>Revision</th><th class="text-center">Published</th><th>Delete</th></tr></thead>';
	foreach ($documents as $document) {
		$status = $document->PublishStatus();
		switch ($status) {
		case BeaconDocument::PUBLISH_STATUS_PRIVATE:
		case BeaconDocument::PUBLISH_STATUS_DENIED:
		case BeaconDocument::PUBLISH_STATUS_APPROVED_PRIVATE:
			$status = 'No';
			break;
		case BeaconDocument::PUBLISH_STATUS_REQUESTED:
			$status = "Pending";
			break;
		case BeaconDocument::PUBLISH_STATUS_APPROVED:
			$status = 'Yes';
			break;
		}
		
		echo '<tr>';
		echo '<td><a href="' . htmlentities($document->ResourceURL()) . '">' . htmlentities($document->Name()) . '</a><br><span class="document_description">' . htmlentities($document->Description()) . '</span></td>';
		echo '<td class="text-right nowrap">' . number_format($document->DownloadCount()) . '</td>';
		echo '<td class="text-right nowrap">' . number_format($document->Revision()) . '</td>';
		echo '<td class="text-center nowrap">' . nl2br(htmlentities($status)) . '</td>';
		echo '<td class="nowrap"><a href="delete/' . htmlentities($document->DocumentID()) . '" beacon-action="delete" beacon-resource-name="' . htmlentities($document->Name()) .'" beacon-resource-url="' . htmlentities($document->ResourceURL()) . '">Delete</a></td>';
		echo '</tr>';
	}
	echo '</table>';
}

?><h3>Change Password</h3>
<div class="small_section">
	<form id="change_password_form" action="" method="post">
		<p><input type="password" id="password_current_field" placeholder="Current Password"></p>
		<p><input type="password" id="password_initial_field" placeholder="New Password" minlength="8"></p>
		<p><input type="password" id="password_confirm_field" placeholder="Confirm New Password" minlength="8"></p>
		<p class="text-right"><input type="submit" id="password_action_button" value="Finish"></p>
	</form>
</div>