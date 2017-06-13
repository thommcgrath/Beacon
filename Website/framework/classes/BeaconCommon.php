<?php

abstract class BeaconCommon {
	protected static $database = null;
	protected static $globals = array();
	
	public static function GenerateUUID() {
		$data = random_bytes(16);
		$data[6] = chr(ord($data[6]) & 0x0f | 0x40); // set version to 0100
		$data[8] = chr(ord($data[8]) & 0x3f | 0x80); // set bits 6-7 to 10
		return vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex($data), 4));
	}
	
	public static function EnvironmentName() {
		return basename(dirname(__FILE__, 4));
	}
	
	public static function InProduction() {
		return static::EnvironmentName() === 'live';
	}
	
	public static function InDevelopment() {
		return static::EnvironmentName() === 'workbench';
	}
	
	public static function Database() {
		if (self::$database === null) {
			trigger_error('Database has not been setup', E_USER_ERROR);
		}
		return self::$database;
	}
	
	public static function SetupDatabase(string $databasename, string $username, string $password) {
		self::$database = new BeaconPostgreSQLDatabase('127.0.0.1', 5432, $databasename, $username, $password);
	}
	
	public static function GenerateRandomKey(int $length = 12, string $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ') {
		$charactersLength = strlen($characters);
		$randomString = '';
		for ($i = 0; $i < $length; $i++) {
			$randomString .= $characters[rand(0, $charactersLength - 1)];
		}
		return $randomString;
	}
	
	public static function IsUUID($input) {
		if (!is_string($input)) {
			return false;
		}
		
		$input = preg_replace('/\s+/', '', $input);
		
		if ($input === '00000000-0000-0000-0000-000000000000') {
			return true;
		}
		
		return preg_match('/^[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$/i', $input) === 1;
	}
	
	public static function IsAssoc(array $arr) {
	    if (array() === $arr) return false;
	    return array_keys($arr) !== range(0, count($arr) - 1);
	}
	
	public static function Redirect(string $destination) {
		header('Location: ' . $destination);
		http_response_code(301);
		echo '<p>This page has moved to <a href="' . $destination . '">' . htmlentities($destination, ENT_COMPAT, 'UTF-8') . '</a>.</p>';
		exit;
	}
	
	public static function AbsoluteURL(string $path) {
		// Because the host can be spoofed, only trust it in development.
		if (self::InProduction()) {
			$url = 'https://beaconapp.cc' . $path;
		} else {
			$url = 'https://workbench.beaconapp.cc' . $path;
		}
		return $url;
	}
	
	public static function HasAllKeys(array $arr, ...$keys) {
		foreach ($keys as $key) {
			if (!array_key_exists($key, $arr)) {
				return false;
			}
		}
		return true;
	}
	
	public static function SetGlobal(string $key, $value) {
		self::$globals[$key] = $value;
	}
	
	public static function GetGlobal(string $key, $default = null) {
		if (array_key_exists($key, self::$globals)) {
			return self::$globals[$key];
		} else {
			return $default;
		}
	}
	
	public static function PostSlackMessage($message) {
		$url = self::GetGlobal('Slack_WebHook_URL');
		if ($url === null) {
			trigger_error('Config file did not specify Slack_WebHook_URL', E_USER_ERROR);
		}
		$json = json_encode(array('text' => $message));
	
		$ch = curl_init($url);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $json);
		curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'POST');
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json'));
		curl_exec($ch);
		curl_close($ch);
	}
	
	public static function IsMacOS() {
		return stristr($_SERVER['HTTP_USER_AGENT'], 'Macintosh') !== false;
	}
	
	public static function IsWindows() {
		return stristr($_SERVER['HTTP_USER_AGENT'], 'Windows NT') !== false;
	}
	
	public static function IsLinux() {
		return (stristr($_SERVER['HTTP_USER_AGENT'], 'Linux') !== false) && (stristr($_SERVER['HTTP_USER_AGENT'], 'Android') === false);
	}
	
	public static function IsiOS() {
		return stristr($_SERVER['HTTP_USER_AGENT'], 'iPhone') !== false;
	}
	
	public static function IsAndroid() {
		return stristr($_SERVER['HTTP_USER_AGENT'], 'Android') !== false;
	}
	
	public static function IsWindowsPhone() {
		return stristr($_SERVER['HTTP_USER_AGENT'], 'Windows Phone OS') !== false;
	}
}

?>
