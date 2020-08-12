<?php

$sessions = BeaconSession::GetForUser($user);

BeaconTemplate::AddStyleSheet('/assets/css/flags.css');

BeaconTemplate::StartStyles();
?><style>
#session_table {
	max-width: 100%;
	
	.country_column {
		width: 75px;
		
		.flag-icon {
			margin-right: 8px;
		}
	}
	
	.self {
		margin-left: 8px;
		font-weight: normal;
		font-size: 0.8em;
		opacity: 50%;
	}
	
	td.country_column {
		text-align: center;
	}
	
	.details {
		display: block;
	}
	
	.remote-address {
		white-space: normal;
	}
}
</style><?php
BeaconTemplate::FinishStyles();

BeaconTemplate::StartScript(); ?>
<script>
document.addEventListener('DOMContentLoaded', function(event) {
	let revokeAction = function(event) {
		event.preventDefault();
		
		request.post('/account/actions/revoke', {'sessionHash': this.getAttribute('sessionHash')}, function(obj) {
			dialog.show('Session revoked', 'Be aware that any enabled user with a copy of your account\'s private key can start a new session.', function() {
				window.location.reload(true);
			});
		}, function(http_status) {
			switch (http_status) {
			case 401:
				dialog.show('Session not revoked', 'There was an authentication error');
				break;
			default:
				dialog.show('Session not revoked', 'Sorry, there was a ' + http_status + ' error.');
				break;
			}
		}, {'Authorization': <?php echo json_encode('Session ' . $session->SessionID()); ?>});
		
		return false;
	};
	
	let revokeLinks = document.querySelectorAll('a.revokeLink');
	for (var i = 0; i < revokeLinks.length; i++) {
		var link = revokeLinks[i];
		link.addEventListener('click', revokeAction);
	}
});
</script><?php
BeaconTemplate::FinishScript();

echo '<table class="generic" id="session_table">';
echo '<thead><tr><th>Device Address</th><th class="country_column">Country</th></tr></thead>';

$user_addr = \BeaconCommon::RemoteAddr();
$is_ipv6 = strpos($user_addr, ':');
$current_session = $session;
foreach ($sessions as $session) {
	$remote_ip = $session->RemoteAddr();
	if (is_null($remote_ip)) {
		continue;
	}
	
	$self = ($remote_ip === $user_addr);
	
	$main_html = '<span class="remote-address">' . htmlentities($session->RemoteAddr()) . '</span>';
	if ($self) {
		$main_html .= '<span class="self">(' . ($is_ipv6 ? 'This is your current device' : 'This is your current address') . ')</span>';
	}
	
	$expires = $session->Expiration();
	$main_html .= '<div class="details separator-color text-lighter">Expires <time datetime="' . $expires->format('c') . '">' . $expires->format('F jS, Y') . ' at ' . $expires->format('g:i:s A') . ' UTC</time> | ';
	if ($current_session->SessionHash() === $session->SessionHash()) {
		$main_html .= 'This is your active session';
	} else {
		$main_html .= '<a href="#" sessionHash="' . $session->SessionHash() . '" class="revokeLink">Revoke</a>';
	}
	$main_html .= '</div>';
	
	echo '<tr><td>' . $main_html . '</td><td class="country_column"><span class="flag-icon flag-icon-' . strtolower($session->RemoteCountry()) . '"></span>' . $session->RemoteCountry() . '</td></tr>';
}

echo '</table>';

?>