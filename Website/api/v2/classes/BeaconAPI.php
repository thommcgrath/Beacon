<?php

abstract class BeaconAPI {
	private static $user_id = null;
	private static $payload = null;
	private static $body_raw = null;
	private static $auth_style = null;
	
	const AUTH_STYLE_PUBLIC_KEY = 'public key';
	const AUTH_STYLE_EMAIL_WITH_PASSWORD = 'email+password';
	const AUTH_STYLE_SESSION = 'session';
	
	public static function Body() {
		if (self::$body_raw === null) {
			if (self::Method() == 'GET') {
				self::$body_raw = $_SERVER['QUERY_STRING'];
			} else {
				self::$body_raw = file_get_contents('php://input');
			}
			if (isset($_SERVER['HTTP_CONTENT_ENCODING']) && $_SERVER['HTTP_CONTENT_ENCODING'] == 'gzip') {
				self::$body_raw = gzdecode(self::$body_raw);
			}
		}
		return self::$body_raw;
	}
	
	public static function JSONPayload() {
		if (self::$payload === null) {
			self::$payload = json_decode(self::Body(), true);
		}
		return self::$payload;
	}
	
	public static function ReplySuccess($payload = null, int $code = 200) {
		header('Content-Type: application/json');
		http_response_code($code);
		if ($payload !== null) {
			$response = json_encode($payload, JSON_PRETTY_PRINT);
			if ($response === false) {
				static::ReplyError('Unable to encode JSON response', json_last_error_msg(), 500);
			} else {
				echo $response;
			}
		}
		exit;
	}
	
	public static function ReplyError(string $message, $payload = null, $code = 400) {
		header('Content-Type: application/json');
		http_response_code($code);
		echo json_encode(array('message' => $message, 'details' => $payload), JSON_PRETTY_PRINT);
		exit;
	}
	
	public static function RequireKeys(string ...$keys) {
		$request = self::JSONPayload();
		$missing = array();
		foreach ($keys as $key) {
			if (!isset($request[$key])) {
				$missing[] = $key;
			}
		}
		if (count($missing) > 0) {
			self::ReplyError('Missing required keys.', $missing);
		}
	}
	
	public static function RequireParams(string ...$keys) {
		$missing = array();
		foreach ($keys as $key) {
			if (!isset($_GET[$key])) {
				$missing[] = $key;
			}
		}
		if (count($missing) > 0) {
			self::ReplyError('Missing required parameters.', $missing);
		}
	}
	
	public static function Method() {
		return strtoupper($_SERVER['REQUEST_METHOD']);
	}
	
	public static function ContentType() {
		$pos = strpos($_SERVER['CONTENT_TYPE'], ';');
		if ($pos === false) {
			return strtolower($_SERVER['CONTENT_TYPE']);
		} else {
			return substr(strtolower($_SERVER['CONTENT_TYPE']), 0, $pos);
		}
	}
	
	private static function AuthorizeWithSessionID(string $session_id) {
		$session = BeaconSession::GetBySessionID($session_id);
		if (is_null($session) == false) {
			self::$user_id = $session->UserID();
			self::$auth_style = self::AUTH_STYLE_SESSION;
			
			$database = BeaconCommon::Database();
			$database->BeginTransaction();
			$database->Query('UPDATE sessions SET valid_until = CURRENT_TIMESTAMP + \'30 days\'::INTERVAL, remote_ip = $2 WHERE (remote_ip IS DISTINCT FROM $2 OR valid_until < CURRENT_TIMESTAMP + \'15 days\'::INTERVAL) AND session_id = encode(digest($1, \'sha512\'), \'hex\');', $session_id, $_SERVER['REMOTE_ADDR']);
			$database->Query('DELETE FROM sessions WHERE valid_until < CURRENT_TIMESTAMP;');
			$database->Commit();
			
			return true;
		}
		return false;
	}
	
	private static function AuthorizeWithPassword(string $username, string $password) {
		$user = BeaconUser::GetByEmail($username);
		$upgrade = isset($_SERVER['HTTP_X_BEACON_UPGRADE_ENCRYPTION']) && boolval($_SERVER['HTTP_X_BEACON_UPGRADE_ENCRYPTION']);
		if (is_null($user) == false && $user->TestPassword($password, $upgrade)) {
			self::$user_id = $user->UserID();
			self::$auth_style = self::AUTH_STYLE_EMAIL_WITH_PASSWORD;
			return true;
		}
		return false;
	}
	
	private static function AuthorizeWithSignature(BeaconUser $user, string $challenge, string $signature) {
		if (is_null($user)) {
			return false;
		}
		
		if (BeaconCommon::IsHex($signature)) {
			$signature = hex2bin($signature);
		}
		
		if ($user->CheckSignature($challenge, $signature)) {
			self::$user_id = $user->UserID();
			self::$auth_style = self::AUTH_STYLE_PUBLIC_KEY;
			return true;
		}
		return false;
	}
	
	public static function Authorize(bool $optional = false) {
		$authorized = false;
		$content = '';
		self::$user_id = BeaconCommon::GenerateUUID(); // To return a "new" UUID even if authorization fails.
		$http_fail_status = 401;
		
		if (isset($_SERVER['HTTP_AUTHORIZATION'])) {
			$http_fail_status = 403;
			$optional = false; // if authorization included, it is no longer optional
			$authorization = $_SERVER['HTTP_AUTHORIZATION'];
			$pos = strpos($authorization, ' ');
			$auth_type = strtolower(substr($authorization, 0, $pos));
			$auth_value = substr($authorization, $pos + 1);
			
			switch ($auth_type) {
			case 'session':
			case 'bearer':
				$authorized = self::AuthorizeWithSessionID($auth_value);
				break;
			case 'basic':
				$decoded = base64_decode($auth_value);
				list($username, $password) = explode(':', $decoded, 2);
				
				if (BeaconCommon::IsUUID($username)) {
					// public key authorization
					$user = BeaconUser::GetByUserID($username);
					
					if (is_null($user) === false) {
						$url = 'https://' . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'];
						$content = self::Method() . chr(10) . $url;
						if (self::Method() !== 'GET') {
							$content .= chr(10) . self::Body();
						}
						
						$authorized = self::AuthorizeWithSignature($user, $content, $password);
					}
				} elseif (BeaconUser::ValidateEmail($username)) {
					// password authorization
					$authorized = self::AuthorizeWithPassword($username, $password);
				}
				
				break;
			}
		} elseif (self::Method() === 'POST' && self::ContentType() === 'application/json') {
			$payload = self::JSONPayload();
			if ($payload !== false && (empty($payload['username']) === false && empty($payload['password']) === false)) {
				$authorized = self::AuthorizeWithPassword($payload['username'], $payload['password']);
			} elseif ($payload !== false && (empty($payload['user_id']) === false && empty($payload['signature']) === false)) {
				$database = BeaconCommon::Database();
				$results = $database->Query('SELECT challenge FROM user_challenges WHERE user_id = $1;', $payload['user_id']);
				if ($results->RecordCount() == 1) {
					$challenge = $results->Field('challenge');
					$user = BeaconUser::GetByUserID($payload['user_id']);
					if (is_null($user) === false) {
						$authorized = self::AuthorizeWithSignature($user, $challenge, $payload['signature']);
					}
				}
			}
		} elseif (empty($_SERVER['HTTP_X_BEACON_TOKEN']) === false) {
			$authorized = self::AuthorizeWithSessionID($_SERVER['HTTP_X_BEACON_TOKEN']);
		}
		
		if ($authorized) {
			$database = BeaconCommon::Database();
			$database->BeginTransaction();
			$database->Query('DELETE FROM user_challenges WHERE user_id = $1;', self::$user_id);
			$database->Commit();	
		}
		
		if ((!$authorized) && (!$optional)) {
			header('WWW-Authenticate: Basic realm="Beacon API"');
			self::ReplyError('Unauthorized', $content, $http_fail_status);
		}
	}
	
	public static function Authenticated() {
		return is_null(self::$auth_style) == false;
	}
	
	public static function AuthenticationMethod() {
		return self::$auth_style;
	}
	
	public static function UserID() {
		return self::$user_id;
	}
	
	public static function ObjectID(int $place = 0) {
		if (!isset($_SERVER['PATH_INFO'])) {
			return null;
		}
		
		$request = explode('/', trim($_SERVER['PATH_INFO'],'/'));
		if ((is_array($request) === false) || (count($request) == 0)) {
			return null;
		}
		
		if (empty($request[$place])) {
			return null;
		}
		
		return $request[$place];
	}
	
	public static function ObjectCount() {
		$object_id = self::ObjectID();
		$arr = explode(',', $object_id);
		return count($arr);
	}
	
	public static function URL(string $path = '/') {
		if (strlen($path) == 0 || substr($path, 0, 1) != '/') {
			$path = '/' . $path;
		}
		$domain = BeaconCommon::InProduction() ? 'api.usebeacon.app' : 'api.' . BeaconCommon::EnvironmentName() . '.usebeacon.app';
		return 'https://' . $domain . '/v2' . $path;
	}
}

?>