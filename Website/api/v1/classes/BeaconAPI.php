<?php

abstract class BeaconAPI {
	private static $user_id = null;
	private static $payload = null;
	private static $body_raw = null;
	
	public static function Body() {
		if (self::$body_raw === null) {
			if (self::Method() == 'GET') {
				self::$body_raw = $_SERVER['QUERY_STRING'];
			} else {
				self::$body_raw = file_get_contents('php://input');
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
	
	public static function ReplySuccess($payload = null) {
		header('Content-Type: application/json');
		http_response_code(200);
		if ($payload !== null) {
			echo json_encode($payload, JSON_PRETTY_PRINT);
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
	
	public static function Authorize(bool $optional = false) {
		$authorized = false;
		$content = '';
		self::$user_id = BeaconCommon::GenerateUUID(); // To return a "new" UUID even if authorization fails.
		
		if (isset($_SERVER['HTTP_AUTHORIZATION'])) {
			$authorization = $_SERVER['HTTP_AUTHORIZATION'];
			if (substr($authorization, 0, 8) === 'Session ') {
				$session_id = substr($authorization, 8);
				$session = BeaconSession::GetBySessionID($session_id);
				if (!is_null($session)) {
					self::$user_id = $session->UserID();
					$authorized = true;
				}
			}
		} else if (isset($_SERVER['PHP_AUTH_USER']) && isset($_SERVER['PHP_AUTH_PW']) && BeaconCommon::IsUUID($_SERVER['PHP_AUTH_USER'])) {
			$user_id = strtolower($_SERVER['PHP_AUTH_USER']);
			$signature = $_SERVER['PHP_AUTH_PW'];
			$database = BeaconCommon::Database();
			$results = $database->Query('SELECT public_key FROM users WHERE user_id = $1;', $user_id);
			if ($results->RecordCount() == 1) {
				$public_key = $results->Field('public_key');
				
				$url = 'https://' . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'];
				
				$content = self::Method() . chr(10) . $url;
				if (self::Method() !== 'GET') {
					$content .= chr(10) . self::Body();
				}
				$verified = openssl_verify($content, hex2bin($signature), $public_key);
				if ($verified === 1) {
					self::$user_id = $user_id;
					$authorized = true;
				}
			}
		}
		
		if ((!$authorized) && (!$optional)) {
			header('WWW-Authenticate: Basic realm="Beacon API"');
			self::ReplyError('Unauthorized', $content, 401);
		}
	}
	
	public static function UserID() {
		return self::$user_id;
	}
	
	public static function ObjectID() {
		if (!isset($_SERVER['PATH_INFO'])) {
			return null;
		}
		
		$request = explode('/', trim($_SERVER['PATH_INFO'],'/'));
		if ((is_array($request) === false) || (count($request) == 0)) {
			return null;
		}
		
		return $request[0];
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
		$domain = BeaconCommon::InProduction() ? 'api.beaconapp.cc' : 'api.workbench.beaconapp.cc';
		return 'https://' . $domain . '/v1' . $path;
	}
}

?>