<?php

abstract class BeaconTemplate {
	protected static $template_name = 'default';
	protected static $title = '';
	protected static $header_lines = array();
	protected static $body_class = '';
	
	protected static function CacheKey() {
		return md5($_SERVER['REQUEST_URI']);
	}
	
	public static function Start() {
		ob_start();
		register_shutdown_function('BeaconTemplate::Finish');
	}
	
	public static function SetTemplate(string $template_name) {
		$template_name = preg_replace('/[^a-zA-Z0-9]+/', '', $template_name);
		$file = BeaconCommon::FrameworkPath() . '/templates/' . $template_name . '.php';
		if (!file_exists($file)) {
			trigger_error('No such template ' . $file, E_USER_ERROR);
		}
		self::$template_name = $template_name;
	}
	
	public static function Finish() {
		$buffer = ob_get_contents();
		ob_end_clean();
		
		$file = BeaconCommon::FrameworkPath() . '/templates/' . self::$template_name . '.php';
		require($file);
	}
	
	public static function Title() {
		$title = 'Beacon';
		if (self::$title !== '') {
			$title .= ': ' . self::$title;
		} else {
			$title .= ' - A Loot Editor for Ark: Survival Evolved';
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
	
	public static function AddStylesheet(string $url) {
		self::$header_lines[] = '<link href="' . htmlentities($url) . '" type="text/css" rel="stylesheet">';
	}
	
	public static function AddScript(string $url) {
		self::$header_lines[] = '<script src="' . htmlentities($url) . '"></script>';
	}
	
	public static function StartScript() {
		ob_start();
	}
	
	public static function FinishScript() {
		$content = trim(ob_get_contents());
		ob_end_clean();
		
		$lines = explode("\n", $content);
		self::$header_lines[] = '<script nonce="' . $_SERVER['CSP_NONCE'] . '">';
		foreach ($lines as $line) {
			if (substr($line, 0, 8) == '<script ' || substr($line, 0, 8) == '<script>' || $line == '</script>') {
				continue;
			}
			
			self::$header_lines[] = $line;
		}
		self::$header_lines[] = '</script>';
	}
	
	public static function StartStyles() {
		ob_start();
	}
	
	public static function FinishStyles() {
		$content = trim(ob_get_contents());
		ob_end_clean();
		
		$lines = explode("\n", $content);
		$cleaned_lines = array();
		foreach ($lines as $line) {
			if (substr($line, 0, 7) == '<style ' || substr($line, 0, 7) == '<style>' || $line == '</style>') {
				continue;
			}
			
			$cleaned_lines[] = $line;
		}
		
		$content = implode("\n", $cleaned_lines);
		$content_hash = md5($content);
		
		$cached = BeaconCache::Get($content_hash);
		if (is_null($cached)) {
			$cmd = BeaconCommon::FrameworkPath() . '/dart-sass/sass --style=compressed --stdin';
			$spec = array(0 => array('pipe', 'r'), 1 => array('pipe', 'w'), 2 => array('pipe', 'w'));
			$process = proc_open($cmd, $spec, $pipes);
			if (is_resource($process)) {
				fwrite($pipes[0], $content);
				fclose($pipes[0]);
				
				$cached = trim(stream_get_contents($pipes[1]));
				fclose($pipes[1]);
				
				proc_close($process);
				
				BeaconCache::Set($content_hash, $cached);
			} else {
				$cached = $content;
			}
		}
		
		$lines = explode("\n", $cached);
		self::$header_lines[] = '<style type="text/css" nonce="' . $_SERVER['CSP_NONCE'] . '">';
		foreach ($lines as $line) {
			self::$header_lines[] = $line;
		}
		self::$header_lines[] = '</style>';
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
			$parts = explode(';', $dict['content-type']);
			return ($parts[0] === 'text/html');
		} else {
			return true;
		}
	}
	
	public static function BodyClass() {
		return static::$body_class;
	}
	
	public static function SetBodyClass(string $class_name) {
		static::$body_class = $class_name;
	}
}

?>