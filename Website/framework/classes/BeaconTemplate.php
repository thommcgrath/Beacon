<?php

abstract class BeaconTemplate {
	protected static $template_name = 'default';
	protected static $title = '';
	protected static $header_lines = array();
	
	public static function Start() {
		ob_start();
		register_shutdown_function('BeaconTemplate::Finish');
	}
	
	public static function SetTemplate(string $template_name) {
		$template_name = preg_replace('/[^a-zA-Z0-9]+/', '', $template_name);
		$file = $_SERVER['FRAMEWORK_DIR'] . '/templates/' . $template_name . '.php';
		if (!file_exists($file)) {
			trigger_error('No such template ' . $file, E_USER_ERROR);
		}
		self::$template_name = $template_name;
	}
	
	public static function Finish() {
		$buffer = ob_get_contents();
		ob_end_clean();
		
		$file = $_SERVER['FRAMEWORK_DIR'] . '/templates/' . self::$template_name . '.php';
		require($file);
	}
	
	public static function Title() {
		$title = 'Beacon';
		if (self::$title !== '') {
			$title .= ': ' . self::$title;
		}
		return $title;
	}
	
	public static function SetTitle(string $title) {
		self::$title = $title;
	}
	
	public static function AddHeaderLine(string $line) {
		self::$header_lines[] = $line;
	}
	
	public static function ExtraHeaderLines() {
		return self::$header_lines;
	}
	
	public static function ExtraHeaderContent($separator = "\n") {
		return implode($separator, self::$header_lines);
	}
	
	public static function IsHTML() {
		if (php_sapi_name() == "cli") {
			return false;
		}
		
		$headers = headers_list();
		$dict = array();
		foreach ($headers as $header) {
			$header = strtolower($header);
			if (!strstr($header, ':')) {
				continue;
			}
			list($name, $value) = explode(':', $header, 2);
			$dict[trim($name)] = trim($value);
		}
		
		// If there is no content-type header, then the default of text/html is
		// used, so that needs be accounted for.
		
		if (array_key_exists('content-type', $dict)) {
			return ($dict['content-type'] === 'text/html');
		} else {
			return true;
		}
	}
}

?>