<?php

$sessions = BeaconSession::GetForUser($user);

BeaconTemplate::AddStyleSheet('/assets/css/flags.css');

echo '<div class="visual-group">';
echo '<h3>Active Sessions</h3>';
echo '<table class="generic" id="session_table">';
echo '<thead><tr><th>Device</th><th class="address_column low-priority">Address</th><th class="country_column low-priority">Country</th><th class="revoke_column low-priority">Actions</th></tr></thead>';

$user_addr = \BeaconCommon::RemoteAddr();
$current_session = $session;
foreach ($sessions as $session) {
	$remote_ip = $session->RemoteAddr();
	if (is_null($remote_ip)) {
		continue;
	}
	
	$self = ($remote_ip === $user_addr);
	
	$address_html = '<span class="remote-address">' . str_replace(':', ':<wbr>', htmlentities($session->RemoteAddr())) . '</span>';
	if ($self) {
		$address_html .= '<span class="self text-lighter"><br>(This is your current network)</span>';
	}
	
	$flag_html = '<span class="flag-icon flag-icon-' . strtolower($session->RemoteCountry()) . '"></span>' . $session->RemoteCountry();
	
	$agent_string = $session->RemoteAgent();
	if (empty($agent_string)) {
		$agent_string = 'Unknown, probably an older version of Beacon';
	} else {
		if (substr($agent_string, 0, 7) === 'Beacon/') {
			$pos = strpos($agent_string, '(');
			$beacon_version = substr($agent_string, 7, $pos - 7);
			$components = explode('; ', substr($agent_string, $pos + 1, -1));
			$agent_string = 'Beacon ' . $beacon_version;
			foreach ($components as $component) {
				list($key, $value) = explode('=', $component, 2);
				if ($key === 'Platform') {
					$agent_string .= ' on ' . substr($value, strpos($value, '/') + 1);
				}
			}
		} else {
			$agent_string = 'Browser: ' . $agent_string;
		}
	}
	
	$expires = $session->Expiration();
	$expiration_html = 'Expires <time datetime="' . $expires->format('c') . '">' . $expires->format('F jS, Y') . ' at ' . $expires->format('g:i:s A') . ' UTC</time>';
	
	if ($current_session->SessionHash() === $session->SessionHash()) {
		$revoke_html = '<span class="self text-lighter">This is your active session</span>';
	} else {
		$revoke_html = '<a href="#" sessionHash="' . $session->SessionHash() . '" class="revokeLink">Revoke</a>';
	}
	
	$actions = [$flag_html, $revoke_html, 'Address: ' . $address_html];
	
	echo '<tr><td>' . $agent_string . '<div class="row-details"><span class="detail">' . implode('</span><span class="detail">', $actions) . '</span></div></td><td class="address_column low-priority">' . $address_html . '</td><td class="country_column low-priority">' . $flag_html . '</td><td class="revoke_column low-priority">' . $revoke_html . '</td></tr>';
}

echo '</table>';
echo '</div>';

?>