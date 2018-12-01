<?php
	
require(dirname(__FILE__, 3) . '/framework/loader.php');
define('PATREON_ID', 'fe103da2582ffa3a0ceafa7b66d3f0d5b04c02216f40384a9e6552dd94d51b52');
define('CREATOR_ID', 6473583);
BeaconTemplate::SetTitle('Patreon Support');

$session = BeaconSession::GetFromCookie();

if (isset($_GET['code']) && isset($_GET['state'])) {
	// request is being returned to us
	$code = $_GET['code'];
	$session_id_from_patreon = $_GET['state'];
	if (($session === null) || ($session->SessionID() != $session_id_from_patreon)) {
		echo "Session mismatch";
		exit;
	}
	
	$user_id = $session->UserID();
	$access_token = RequestAccessToken($code, $user_id, false);
	if ($access_token === false) {
		echo "Patreon rejected request for authorization";
		exit;
	}
	
	BeaconCommon::Redirect(BeaconCommon::AbsoluteURL('/accounts/patreon.php'));
	
	exit;
} elseif ((isset($_GET['action'])) && ($_GET['action'] === 'begin')) {
	$return_uri = BeaconCommon::AbsoluteURL('/accounts/patreon.php');
	if ($session === null) {
		BeaconCommon::Redirect($return_uri, true);
	}
	
	BeaconCommon::Redirect('https://www.patreon.com/oauth2/authorize?response_type=code&client_id=' . urlencode(PATREON_ID) . '&redirect_uri=' . urlencode($return_uri) . '&state=' . urlencode($session->SessionID()), true);
} elseif (strtoupper($_SERVER['REQUEST_METHOD']) === 'POST') {
	// webhook
	http_response_code(401);
	
	$event = $_SERVER['HTTP_X_PATREON_EVENT'];
	$expected_signature = strtolower($_SERVER['HTTP_X_PATREON_SIGNATURE']);
	$body = file_get_contents('php://input');
	
	$computed_signature = strtolower(hash_hmac('md5', $body, BeaconCommon::GetGlobal('Patreon_Webhook_Secret')));
	if ($computed_signature !== $expected_signature) {
		exit;
	}
	
	$data = json_decode($body, true);
	if ($data === null) {
		exit;
	}
	
	$pledge_details = $data['data'];
	$declined_since = $pledge_details['attributes']['declined_since'];
	$patreon_id = $pledge_details['relationships']['patron']['data']['id'];
	$creator_id = $pledge_details['relationships']['creator']['data']['id'];
	
	$supporter = ($declined_since !== null) && ($creator_id == 6473583);
	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	$database->Query("UPDATE users SET is_patreon_supporter = $2 WHERE patreon_id = $1;", $patreon_id, $supporter);
	$database->Commit();
	
	http_response_code(200);
	exit;
}

echo "<h1>Beacon + Patreon</h1>\n";
echo "<div class=\"indent\">\n";

$linked = false;
$supporter = false;

if ($session !== null) {
	$database = BeaconCommon::Database();
	$results = $database->Query("SELECT access_token, valid_until, refresh_token FROM patreon_tokens WHERE user_id = $1 ORDER BY valid_until DESC LIMIT 1;", $session->UserID());
	if ($results->RecordCount() === 1) {
		$access_token = $results->Field('access_token');
		$expiration = new DateTime($results->Field('valid_until'));
		$now = new DateTime('now');
		if ($expiration < $now) {
			// token needs to be refreshed
			$access_token = RequestAccessToken($results->Field('refresh_token'), $session->UserID(), true);
		}
		
		UpdateUserProfile($session->UserID(), $access_token);
		$user = $session->User();
		$linked = $user->IsPatreonLinked();
		$supporter = $user->IsPatreonSupporter();
	}
}

if ($linked) {
	if ($supporter) {
		echo "\t<p>Hey thanks for supporting Beacon! Sorry there isn't much to offer now, but that may change in the future.</p>\n";
	} else {
		echo "\t<p>Your Patreon account is linked.</p>\n";
	}
} else {
	echo "\t<p>You can now link your Patreon account with Beacon. At the moment, there's no reason to do so, but in the future there may be Patreon rewards.</p>\n";
	if ($session === null) {
		echo "\t<p>To link your account now, choose &quot;Link Patreon Account&ellipsis;&quot; from Beacon's &quot;Help&quot; menu.</p>\n";
	} else {
		echo "\t<p class=\"text-center\"><a href=\"?action=begin\" class=\"button\">Link Now</a></p>\n";
	}
}

echo "</div>";

function UpdateUserProfile(string $user_id, string $access_token) {
	$database = BeaconCommon::Database();
	
	$curl = curl_init();
	curl_setopt($curl, CURLOPT_URL, 'https://www.patreon.com/api/oauth2/api/current_user');
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($curl, CURLOPT_HTTPHEADER, array('Authorization: Bearer ' . $access_token));
	$raw = curl_exec($curl);
	$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
	curl_close($curl);
	
	if ($status !== 200) {
		$database->BeginTransaction();
		$database->Query("UPDATE users SET patreon_id = NULL, is_patreon_supporter = FALSE WHERE user_id = $1;", $user_id);
		$database->Commit();
		return false;
	}
	
	$userdata = json_decode($raw, true);
	if ($userdata === null) {
		return false;
	}
	$patreon_user_id = $userdata['data']['id'];
	$pledges = $userdata['data']['relationships']['pledges']['data'];
	
	$supporter = false;
	$objects = array();
	if (isset($userdata['included'])) {
		foreach ($userdata['included'] as $object) {
			$id = $object['id'];
			$type = $object['type'];
			if (array_key_exists($type, $objects)) {
				$siblings = $objects[$type];
			} else {
				$siblings = array();
			}
			$siblings[$id] = $object;
			$objects[$type] = $siblings;
		}
		
		foreach ($pledges as $pledge) {
			$id = $pledge['id'];
			
			$pledge_detail = $objects['pledge'][$id];
			$declined_since = $pledge_detail['attributes']['declined_since'];
			if ($declined_since !== null) {
				// invalid
				continue;
			}
			
			$creator = $pledge_detail['relationships']['creator'];
			$creator_id = $creator['data']['id'];
			
			$supporter = $supporter || ($creator_id == CREATOR_ID);
		}
	}
	
	$database->BeginTransaction();
	$database->Query("UPDATE users SET patreon_id = $2, is_patreon_supporter = $3 WHERE user_id = $1;", $user_id, $patreon_user_id, $supporter);
	$database->Commit();
	
	return true;
}

function RequestAccessToken(string $code, string $user_id, bool $is_refresh) {
	$url = 'https://www.patreon.com/api/oauth2/token';
	$redirect_uri = BeaconCommon::AbsoluteURL('/accounts/patreon.php');
	
	$fields = array();
	$fields[] = 'client_id=' . urlencode(PATREON_ID);
	$fields[] = 'client_secret=' . urlencode(BeaconCommon::GetGlobal('Patreon_Secret'));
	if ($is_refresh === true) {
		$fields[] = 'refresh_token=' . urlencode($code);
		$fields[] = 'grant_type=refresh_token';
	} else {
		$fields[] = 'code=' . urlencode($code);
		$fields[] = 'grant_type=authorization_code';
		$fields[] = 'redirect_uri=' . urlencode($redirect_uri);
	}
	
	$formdata = implode('&', $fields);
	
	$curl = curl_init();
	curl_setopt($curl, CURLOPT_URL, $url);
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($curl, CURLOPT_POST, 5);
	curl_setopt($curl, CURLOPT_POSTFIELDS, $formdata);
	$raw = curl_exec($curl);
	$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
	curl_close($curl);
	
	$patreon_auth = json_decode($raw, true);
	if (($patreon_auth === null) || ($status !== 200)) {
		return false;
	}
	
	$access_token = $patreon_auth['access_token'];
	$refresh_token = $patreon_auth['refresh_token'];
	$token_expiration = new DateTime('@' . (time() + $patreon_auth['expires_in']));
	
	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	$database->Query("DELETE FROM patreon_tokens WHERE user_id = $1;", $user_id);
	$database->Query("INSERT INTO patreon_tokens (access_token, refresh_token, valid_until, user_id) VALUES ($1, $2, $3, $4);", $access_token, $refresh_token, $token_expiration->format('Y-m-d H:i:sO'), $user_id);
	$database->Commit();
	
	return $access_token;
}

?>