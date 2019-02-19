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
	
	public static function StartSession() {
		if (session_status() == PHP_SESSION_NONE) {
			if (self::InProduction()) {
				session_name('beacon');
			} else {
				session_name('beacon_dev');
			}
			session_set_cookie_params(0, '/', '.beaconapp.cc', true, true);
			session_start();
		}
	}
	
	public static function EnvironmentName() {
		return basename(dirname(__FILE__, 4));
	}
	
	public static function InProduction() {
		return static::EnvironmentName() === 'live';
	}
	
	public static function InDevelopment() {
		return static::EnvironmentName() !== 'live';
	}
	
	public static function FrameworkPath() {
		return dirname(__FILE__, 2);
	}
	
	public static function WebRoot() {
		return dirname(__FILE__, 3) . '/www';
	}
	
	public static function AssetURI(string $asset_filename) {
		$filename = pathinfo($asset_filename, PATHINFO_FILENAME);
		$extension = pathinfo($asset_filename, PATHINFO_EXTENSION);
		$public_extension = $extension;
		$folder = $extension;
		switch ($extension) {
		case 'scss':
			$public_extension = 'css';
			$folder = 'css';
			break;
		case 'js':
			$folder = 'scripts';
			break;
		case 'svg':
		case 'png':
		case 'gif':
			$folder = 'images';
			break;
		case 'ttf':
		case 'otf':
		case 'woff2':
			$folder = 'fonts';
			break;
		}
		$asset_path = static::WebRoot() . '/assets/' . $folder . '/' . $asset_filename;
		$uri_path = '/assets/' . $folder . '/' . $filename . '.' . $public_extension;
		return $uri_path . '?mtime=' . filemtime($asset_path);
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
	
	public static function IsUUID(&$input) {
		if (!is_string($input)) {
			return false;
		}
		
		$cleaned = preg_replace('/\s+/', '', $input);
		if ($cleaned === '00000000-0000-0000-0000-000000000000') {
			return true;
		}
		
		if (preg_match('/^([0-9A-F]{8})-?([0-9A-F]{4})-?([0-9A-F]{4})-?([0-9A-F]{4})-?([0-9A-F]{12})$/i', $cleaned, $matches) === 1) {
			$input = strtolower($matches[1] . '-' . $matches[2] . '-' . $matches[3] . '-' . $matches[4] . '-' . $matches[5]);
			return true;
		} else {
			return false;
		}
	}
	
	public static function IsAssoc(array $arr) {
	    if (array() === $arr) return false;
	    return array_keys($arr) !== range(0, count($arr) - 1);
	}
	
	public static function Redirect(string $destination, bool $temp = false) {
		header('Location: ' . $destination);
		if ($temp === true) {
			http_response_code(302);
			echo '<p>Please relocate to <a href="' . $destination . '">' . htmlentities($destination, ENT_COMPAT, 'UTF-8') . '</a>.</p>';
		} else {
			http_response_code(301);
			echo '<p>This page has moved to <a href="' . $destination . '">' . htmlentities($destination, ENT_COMPAT, 'UTF-8') . '</a>.</p>';
		}
		exit;
	}
	
	public static function AbsoluteURL(string $path) {
		// Because the host can be spoofed, only trust it in development.
		if (self::InProduction()) {
			$url = 'https://beaconapp.cc' . $path;
		} else {
			$url = 'https://' . self::EnvironmentName() . '.beaconapp.cc' . $path;
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
		self::PostSlackRaw(json_encode(array('text' => $message)));
	}
	
	public static function PostSlackRaw(string $raw) {
		$url = self::GetGlobal('Slack_WebHook_URL');
		if ($url === null) {
			trigger_error('Config file did not specify Slack_WebHook_URL', E_USER_ERROR);
		}
	
		$ch = curl_init($url);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $raw);
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
	
	public static function ArrayToEnglish(array $items) {
		if (count($items) == 0) {
			return '';
		} elseif (count($items) == 1) {
			return $items[0];
		} elseif (count($items) == 2) {
			return $items[0] . ' and ' . $items[1];
		} else {
			$last = array_pop($items);
			return implode(', ', $items) . ', and ' . $last;
		}
	}
	
	public static function ResolveObjectIdentifier(string $object_id, int $workshop_id = 0) {
		// $object_id could be a UUID or a class string. Only blueprints have class strings,
		// but if supplied with a UUID of a blueprint, we want the blueprint object back.
		// In fact, we always want the most specific class possible for the given input.
		
		$workshop_id = abs($workshop_id);
		
		$cache_key = $object_id;
		if ($workshop_id > 0) {
			$cache_key = $workshop_id . '|' . $cache_key;
		}
		
		$obj = BeaconCache::Get($cache_key);
		if (!is_null($obj)) {
			// Renew the cache
			BeaconCache::Set($cache_key, $obj, 3600);
			return $obj;
		}
		
		$database = static::Database();
		if (static::IsUUID($object_id)) {
			$results = $database->Query('SELECT objects.object_id, objects.tableoid::regclass AS tablename FROM objects INNER JOIN mods ON (objects.mod_id = mods.mod_id) WHERE objects.object_id = $1 AND mods.confirmed = TRUE;', $object_id);
		} elseif ($workshop_id > 0) {
			$results = $database->Query('SELECT blueprints.object_id, blueprints.tableoid::regclass AS tablename FROM blueprints INNER JOIN mods ON (blueprints.mod_id = mods.mod_id) WHERE blueprints.class_string = $1 AND mods.confirmed = TRUE AND ABS(mods.workshop_id) = $2 LIMIT 1;', $object_id, $workshop_id);
		} else {
			$results = $database->Query('SELECT blueprints.object_id, blueprints.tableoid::regclass AS tablename FROM blueprints INNER JOIN mods ON (blueprints.mod_id = mods.mod_id) WHERE blueprints.class_string = $1 AND mods.confirmed = TRUE;', $object_id);
		}
		if ($results->RecordCount() == 0) {
			return null;
		}
		
		$objects = array();
		while (!$results->EOF()) {
			$id = $results->Field('object_id');
			$tablename = $results->Field('tablename');
			switch ($tablename) {
			case 'creatures':
				$obj = BeaconCreature::GetByObjectID($id);
				break;
			case 'diets':
				$obj = BeaconDiet::GetByObjectID($id);
				break;
			case 'engrams':
				$obj = BeaconEngram::GetByObjectID($id);
				break;
			case 'loot_sources':
				$obj = BeaconLootSource::GetByObjectID($id);
				break;
			case 'presets':
				$obj = BeaconPreset::GetByObjectID($id);
				break;
			default:
				$obj = null;
				break;
			}
			if (!is_null($obj)) {
				$objects[] = $obj;
			}
			$results->MoveNext();
		}
		
		if (count($objects) == 0) {
			return null;
		} elseif (count($objects) == 1) {
			BeaconCache::Set($cache_key, $objects[0], 3600);
			return $objects[0];
		} else {
			foreach ($objects as $obj) {
				if ($obj instanceof BeaconBlueprint) {
					BeaconCache::Set($obj->ModWorkshopID() . '|' . $obj->ClassString(), $obj, 3600);
				}
			}
			BeaconCache::Set($cache_key, $objects, 3600);
			return $objects;
		}
	}
	
	public static function CurrentContentType() {
		$headers = headers_list();
		foreach ($headers as $header) {
			if (stripos($header, 'Content-Type') !== false) {
				list($key, $value) = explode(':', $header, 2);
				return trim($value);
			}
		}
		return 'text/html';
	}
	
	public static function CurrentOmniVersion() {
		return 1;
	}
	
	public static function BestResponseContentType($supported_types = null) {
		if (!isset($_SERVER['HTTP_ACCEPT'])) {
			if (is_array($supported_types) && count($supported_types) > 0) {
				return $supported_types[0];
			} else {
				return 'text/html';
			}
		}
		
		$selected_types = [];
		
		$client_types = explode(',', strtolower(str_replace(' ', '', $_SERVER['HTTP_ACCEPT'])));
		foreach ($client_types as $type) {
			$quality = 1;
			if (strpos($type, ';q=')) {
				list($type, $quality) = explode(';q=', $type, 2);
			}
			if ($quality > 0) {
				$selected_types[$type] = $quality;
			}
		}
		arsort($selected_types);
		
		if (is_null($supported_types) || is_array($supported_types) === false) {
			return $selected_types;
		}
		
		$supported_types = array_map('strtolower', (array)$supported_types);
		foreach ($selected_types as $type => $quality) {
			if ($quality && in_array($type, $supported_types)) {
				return $type;
			}
		}
		
		return null;
	}
	
	public static function BuildNumberToVersion(int $build_number) {
		if ($build_number < 10000000) {
			$database = static::Database();
			$results = $database->Query('SELECT build_display FROM updates WHERE build_number = $1;', $build_number);
			if ($results->RecordCount() == 1) {
				return $results->Field('build_display');
			} else {
				return $build_number;
			}
		}
		
		$major_version = floor($build_number / 10000000);
		$build_number = $build_number - ($major_version * 10000000);
		$minor_version = floor($build_number / 100000);
		$build_number = $build_number - ($minor_version * 100000);
		$bug_version = floor($build_number / 1000);
		$build_number = $build_number - ($bug_version * 1000);
		$stage_code = floor($build_number / 100);
		$build_number = $build_number - ($stage_code * 100);
		$non_release_version = $build_number;
		
		if ($stage_code < 3) {
			switch ($stage_code) {
			case 2:
				$prerelease = 'b';
				break;
			case 1:
				$prerelease = 'a';
				break;
			case 0:
				$prerelease = 'pa';
				break;
			default:
				$prerelease = 'u';
				break;
			}
			$prerelease .= $non_release_version;
		} else {
			$prerelease = '';
		}
		
		return $major_version . '.' . $minor_version . '.' . $bug_version . $prerelease;
	}
}

?>
