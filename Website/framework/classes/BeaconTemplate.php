<?php

abstract class BeaconTemplate {
	protected static $template_name = 'default';
	protected static $title = '';
	protected static $script_lines = array();
	protected static $style_lines = array();
	protected static $header_lines = array();
	protected static $body_class = '';
	protected static $page_description = '';
	protected static $use_photoswipe = false;
	
	protected static function CacheKey() {
		return md5($_SERVER['REQUEST_URI']);
	}
	
	public static function Start() {
		ob_start();
		register_shutdown_function('BeaconTemplate::Finish');
	}
	
	public static function Cancel() {
		ob_end_clean();
		self::$template_name = null;
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
		if (ob_get_level() === 0 || is_null(self::$template_name)) {
			return;
		}
		
		$buffer = ob_get_contents();
		ob_end_clean();
		
		foreach (static::$header_lines as $line) {
			if (strpos($line, 'photoswipe.min.js') !== false) {
				static::$use_photoswipe = true;
			}
		}
		
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
		$script = array();
		if (count(self::$script_lines) > 0) {
			$script = self::$script_lines;
			array_unshift($script, '<script nonce="' . htmlentities($_SERVER['CSP_NONCE']) . '">');
			$script[] = '</script>';
		}
		
		$style = array();
		if (count(self::$style_lines) > 0) {
			$style = self::$style_lines;
			$content = implode("\n", $style);
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
					$err = trim(stream_get_contents($pipes[2]));
					fclose($pipes[1]);
					fclose($pipes[2]);
					
					proc_close($process);
					
					if (empty($cached)) {
						$cached = "/*Error:\n\n" . htmlentities($err) . "\n\n*/\n\n$content";
					}
					
					BeaconCache::Set($content_hash, $cached);
				} else {
					$cached = $content;
				}
			}
						
			$style = explode("\n", $cached);
			array_unshift($style, '<style type="text/css" nonce="' . htmlentities($_SERVER['CSP_NONCE']) . '" hash="' . $content_hash . '">');
			$style[] = '</style>';
		}
		
		return array_merge(self::$header_lines, $style, $script);
	}
	
	public static function ExtraHeaderContent($separator = "\n") {
		return implode($separator, self::ExtraHeaderLines());
	}
	
	public static function AddStylesheet(string $url) {
		self::$header_lines[] = '<link href="' . htmlentities($url) . '" type="text/css" rel="stylesheet" nonce="' . $_SERVER['CSP_NONCE'] . '">';
	}
	
	public static function AddScript(string $url) {
		self::$header_lines[] = '<script src="' . htmlentities($url) . '" nonce="' . $_SERVER['CSP_NONCE'] . '"></script>';
	}
	
	public static function StartScript() {
		ob_start();
	}
	
	public static function FinishScript() {
		$content = trim(ob_get_contents());
		ob_end_clean();
		
		$lines = explode("\n", $content);
		foreach ($lines as $line) {
			if (substr($line, 0, 8) == '<script ' || substr($line, 0, 8) == '<script>' || $line == '</script>') {
				continue;
			}
			
			self::$script_lines[] = $line;
		}
	}
	
	public static function StartStyles() {
		ob_start();
	}
	
	public static function FinishStyles() {
		$content = trim(ob_get_contents());
		ob_end_clean();
		
		$lines = explode("\n", $content);
		foreach ($lines as $line) {
			if (substr($line, 0, 7) == '<style ' || substr($line, 0, 7) == '<style>' || substr($line, -8) == '</style>') {
				continue;
			}
			
			self::$style_lines[] = $line;
		}
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
	
	public static function PageDescription() {
		return static::$page_description;
	}
	
	public static function SetPageDescription(string $page_description) {
		static::$page_description = $page_description;
	}
	
	public static function PhotoSwipeDOM() {
		if (!static::$use_photoswipe) {
			return;
		}
		
		?><div class="pswp" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="pswp__bg"></div>
			<div class="pswp__scroll-wrap">
				<div class="pswp__container">
		            <div class="pswp__item"></div>
		            <div class="pswp__item"></div>
		            <div class="pswp__item"></div>
		        </div>
				<div class="pswp__ui pswp__ui--hidden">
					<div class="pswp__top-bar">
						<div class="pswp__counter"></div>
						<button class="pswp__button pswp__button--close" title="Close (Esc)"></button>
						<button class="pswp__button pswp__button--share" title="Share"></button>
						<button class="pswp__button pswp__button--fs" title="Toggle fullscreen"></button>
						<button class="pswp__button pswp__button--zoom" title="Zoom in/out"></button>
						<div class="pswp__preloader">
		                    <div class="pswp__preloader__icn">
		                      <div class="pswp__preloader__cut">
		                        <div class="pswp__preloader__donut"></div>
		                      </div>
		                    </div>
		                </div>
		            </div>
					<div class="pswp__share-modal pswp__share-modal--hidden pswp__single-tap">
		                <div class="pswp__share-tooltip"></div> 
		            </div>
					<button class="pswp__button pswp__button--arrow--left" title="Previous (arrow left)">
		            </button>
					<button class="pswp__button pswp__button--arrow--right" title="Next (arrow right)">
		            </button>
					<div class="pswp__caption">
		                <div class="pswp__caption__center"></div>
		            </div>
				</div>
			</div>
		</div>
<?php
	}
}

?>