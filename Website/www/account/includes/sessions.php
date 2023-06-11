<?php

use BeaconAPI\v4\{Application, Session};

$sessions = Session::Search(['userId' => $user->UserId()], true);

BeaconTemplate::AddStyleSheet(BeaconCommon::AssetURI('flags.css'));

echo '<div class="visual-group">';
echo '<h3>Active Sessions</h3>';
echo '<table class="generic" id="session_table">';
echo '<thead><tr><th>Device</th><th class="address_column low-priority">Address</th><th class="country_column low-priority">Country</th><th class="revoke_column low-priority">Actions</th></tr></thead>';

$apps = [];

$user_addr = BeaconCommon::RemoteAddr();
$current_session = $session;
foreach ($sessions as $session) {
	$appId = $session->ApplicationId();
	if (is_null($appId) === false) {
		if (array_key_exists($appId, $apps) === false) {
			$app = Application::Fetch($appId);
			$apps[$appId] = $app;
		} else {
			$app = $apps[$appId];
		}
	} else {
		$app = null;
	}
	
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
	
	$appName = '';
	if (is_null($app) === false) {
		$appName = $app->Name();
	}
	
	$agentString = $session->RemoteAgent();
	if (empty($agentString)) {
		$agentString = 'Unknown, probably an older version of Beacon';
	} else {
		if (substr($agentString, 0, 7) === 'Beacon/' && (is_null($app) || $app->ApplicationId() === BeaconCommon::BeaconAppId)) {
			$pos = strpos($agentString, '(');
			$beaconVersion = substr($agentString, 7, $pos - 7);
			$components = explode('; ', substr($agentString, $pos + 1, -1));
			$agentString = 'Beacon ' . $beaconVersion;
			foreach ($components as $component) {
				list($key, $value) = explode('=', $component, 2);
				if ($key === 'Platform') {
					$agentString .= ' on ' . substr($value, strpos($value, '/') + 1);
				}
			}
			if (is_null($app) === false) {
				$appName = $agentString;
				$agentString = '';
			}
		} else {
			if (is_null($app)) {
				$agentString = 'Browser: ' . $agentString;
			}
		}
	}
	
	$deviceInfo = '';
	if (is_null($app) === false) {
		$deviceInfo = '<div class="session-app-card"><div class="session-app-icon">' . $app->IconHtml(32) . '</div><div class="session-app-name">' . htmlentities($appName) . '</div></div>';
	}
	if (empty($agentString) === false) {
		$deviceInfo .= '<div class="session-app-agent">' . $agentString . '</div>';
	}
	
	$expires = $session->RefreshTokenExpiration();
	$expiration_html = 'Expires <time datetime="' . date('c', $expires) . '">' . date('F jS, Y', $expires) . ' at ' . date('g:i:s A', $expires) . ' UTC</time>';
	
	if ($current_session->SessionHash() === $session->SessionHash()) {
		$revoke_html = '<span class="self text-lighter">This is your active session</span>';
	} else {
		$revoke_html = '<a href="#" sessionHash="' . htmlentities($session->AccessToken()) . '" class="revokeLink">Revoke</a>';
	}
	
	$actions = [$flag_html, $revoke_html, 'Address: ' . $address_html];
	
	echo '<tr><td>' . $deviceInfo . '<div class="row-details"><span class="detail">' . implode('</span><span class="detail">', $actions) . '</span></div></td><td class="address_column low-priority">' . $address_html . '</td><td class="country_column low-priority">' . $flag_html . '</td><td class="revoke_column low-priority">' . $revoke_html . '</td></tr>';
}

echo '</table>';
echo '</div>';

?>