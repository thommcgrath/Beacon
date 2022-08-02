<?php

abstract class BeaconTemplate {
	protected static $template_name = 'default';
	protected static $title = '';
	protected static $script_lines = [];
	protected static $header_lines = [];
	protected static $body_class = '';
	protected static $page_description = '';
	protected static $use_photoswipe = false;
	protected static $current_modal = null;
	protected static $modals = [];
	
	protected static function CacheKey(): string {
		return md5($_SERVER['REQUEST_URI']);
	}
	
	public static function Start(): void {
		ob_start();
		register_shutdown_function('BeaconTemplate::Finish');
	}
	
	public static function Cancel(): void {
		ob_end_clean();
		self::$template_name = null;
	}
	
	public static function SetTemplate(string $template_name): void {
		$template_name = preg_replace('/[^a-zA-Z0-9]+/', '', $template_name);
		$file = BeaconCommon::FrameworkPath() . '/templates/' . $template_name . '.php';
		if (!file_exists($file)) {
			trigger_error('No such template ' . $file, E_USER_ERROR);
		}
		self::$template_name = $template_name;
	}
	
	public static function Finish(): void {
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
	
	public static function Title(): string {
		$title = 'Beacon';
		if (self::$title !== '') {
			$title .= ': ' . self::$title;
		} else {
			$title .= ' for Ark: Survival Evolved';
		}
		return $title;
	}
	
	public static function SetTitle(string $title): void {
		self::$title = $title;
	}
	
	public static function AddHeaderLine(string $line): void {
		self::$header_lines[] = $line;
	}
	
	public static function ExtraHeaderLines(): array {
		$script = [];
		if (count(self::$script_lines) > 0) {
			$script = self::$script_lines;
			array_unshift($script, '<script nonce="' . htmlentities($_SERVER['CSP_NONCE']) . '">');
			$script[] = '</script>';
		}
		
		return array_merge(self::$header_lines, $script);
	}
	
	public static function ExtraHeaderContent(string $separator = "\n"): string {
		return implode($separator, self::ExtraHeaderLines());
	}
	
	private static function URLWithModificationTime(string $url): string {
 		if (substr($url, 0, 1) == '/') {
 			$pos = strpos($url, '?');
 			if ($pos !== false) {
 				$url_path = substr($url, 0, $pos);
 				$url_query = substr($url, $pos + 1);
 			} else {
 				$url_path = $url;
 				$url_query = '';
 			}

  			$path = $_SERVER['DOCUMENT_ROOT'] . $url_path;
 			if (substr($url_path, -5) == '.scss') {
 				$url_path = substr($url_path, 0, -5) . '.css';
 			}
 			if (file_exists($path)) {
 				$query = [];
 				parse_str($url_query, $query);
 				$query['mtime'] = filemtime($path);
 				$url = $url_path . '?' . http_build_query($query);
 			}
 		}
 		return $url;
 	}
	
	public static function AddStylesheet(string $url): void {
		self::$header_lines[] = '<link href="' . htmlentities(static::URLWithModificationTime($url)) . '" type="text/css" rel="stylesheet" nonce="' . $_SERVER['CSP_NONCE'] . '">';
	}
	
	public static function AddScript(string $url): void {
		self::$header_lines[] = '<script src="' . htmlentities(static::URLWithModificationTime($url)) . '" nonce="' . $_SERVER['CSP_NONCE'] . '"></script>';
	}
	
	public static function StartScript(): void {
		ob_start();
	}
	
	public static function FinishScript(): void {
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
	
	public static function StartModal(string $id): void {
		self::$current_modal = $id;
		ob_start();
	}
	
	public static function FinishModal(): void {
		$content = trim(ob_get_contents());
		ob_end_clean();
		
		$id = self::$current_modal;
		self::$current_modal = null;
		self::$modals[$id] = $content;
	}
	
	public static function IsHTML(): bool {
		if (php_sapi_name() == "cli") {
			return false;
		}
		
		$headers = headers_list();
		$dict = [];
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
	
	public static function Modals(): array {
		return array_keys(self::$modals);
	}
	
	public static function ModalContent(string $id): string {
		return self::$modals[$id];
	}
	
	public static function BodyClass(): string {
		return static::$body_class;
	}
	
	public static function SetBodyClass(string $class_name): void {
		static::$body_class = $class_name;
	}
	
	public static function PageDescription(): string {
		return static::$page_description;
	}
	
	public static function SetPageDescription(string $page_description): void {
		static::$page_description = $page_description;
	}
	
	public static function PhotoSwipeDOM(): void {
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