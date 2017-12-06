<?php
	
require($_SERVER['SITE_ROOT'] . '/framework/loader.php');
define('PATREON_ID', 'fe103da2582ffa3a0ceafa7b66d3f0d5b04c02216f40384a9e6552dd94d51b52');
define('CAMPAIGN_ID', '982252');

if (isset($_GET['code']) && isset($_GET['state'])) {
	// request is being returned to us
	$code = $_GET['code'];
	$session_id_from_patreon = $_GET['state'];
	$session = BeaconSession::GetFromCookie();
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
}

$session = BeaconSession::GetFromCookie();
if ($session !== null) {
	$database = BeaconCommon::Database();
	$results = $database->Query("SELECT access_token, valid_until, refresh_token FROM patreon_tokens WHERE user_id = $1 ORDER BY valid_until DESC LIMIT 1;", $session->UserID());
	if ($results->RecordCount() === 1) {
		// refresh profile
		
		$access_token = $results->Field('access_token');
		$expiration = new DateTime($results->Field('valid_until'));
		$now = new DateTime('now');
		if ($expiration < $now) {
			// token needs to be refreshed
			$access_token = RequestAccessToken($results->Field('refresh_token'), $session->UserID(), true);
		}
		
		$saved = UpdateUserProfile($session->UserID(), $access_token);
		if ($saved) {
			echo "linked";
		} else {
			echo "some kind of error";
		}
	} else {
		// starting a patreon link
		$redirect_uri = BeaconCommon::AbsoluteURL('/accounts/patreon.php');
		BeaconCommon::Redirect('https://www.patreon.com/oauth2/authorize?response_type=code&client_id=' . urlencode(PATREON_ID) . '&redirect_uri=' . urlencode($redirect_uri) . '&state=' . urlencode($session->SessionID()), true);
	}
	exit;
}

BeaconCommon::Redirect(BeaconCommon::AbsoluteURL('/'), true);

function UpdateUserProfile(string $user_id, string $access_token) {
	$curl = curl_init();
	curl_setopt($curl, CURLOPT_URL, 'https://www.patreon.com/api/oauth2/api/current_user');
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($curl, CURLOPT_HTTPHEADER, array('Authorization: Bearer ' . $access_token));
	$raw = curl_exec($curl);
	$status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
	curl_close($curl);
	
	if ($status !== 200) {
		return false;
	}
	
	$userdata = json_decode($raw, true);
	if ($userdata === null) {
		echo json_last_error_msg();
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
			
			$supporter = $supporter || ($creator_id == 6473583);
		}
	}
	
	$database = BeaconCommon::Database();
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