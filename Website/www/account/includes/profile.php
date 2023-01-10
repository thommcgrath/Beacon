<?php

$database = BeaconCommon::Database();
$results = $database->Query('SELECT generate_username() AS username;');
$suggested_username = $results->Field('username');

?><div class="visual-group">
	<h3>Change Username</h3>
	<form id="change_username_form" action="" method="post">
		<p><input type="text" id="username_field" placeholder="New Username"><br><span class="smaller">How about <a href="#" id="suggested-username-link" class="username-suggestion" beacon-username="<?php echo htmlentities($suggested_username); ?>"><?php echo htmlentities($suggested_username); ?></a>? Or maybe <a href="#" id="new-suggestion-link">another suggestion</a>?</span></p>
		<p class="text-right"><input type="submit" id="username_action_button" value="Save Username" disabled></p>
	</form>
</div>