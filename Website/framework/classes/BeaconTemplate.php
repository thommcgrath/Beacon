<?php

abstract class BeaconTemplate {
	protected static string $templateName = 'default';
	protected static string $title = '';
	protected static array $scriptLines = [];
	protected static array $headerLines = [];
	protected static string $bodyClass = '';
	protected static string $pageDescription = '';
	protected static bool $usePhotoswipe = false;
	protected static ?string $currentModal = null;
	protected static array $modals = [];
	protected static array $extraVars = [];
	protected static string $canonicalUrl = '';
	protected static bool $isArticle = false;
	protected static string $heroUrl = '';
	protected static array $modules = [];
	
	protected static function CacheKey(): string {
		return md5($_SERVER['REQUEST_URI']);
	}
	
	public static function Start(): void {
		ob_start();
		register_shutdown_function('BeaconTemplate::Finish');
	}
	
	public static function Cancel(): void {
		ob_end_clean();
		self::$templateName = null;
	}
	
	public static function SetTemplate(string $templateName): void {
		$templateName = preg_replace('/[^a-zA-Z0-9]+/', '', $templateName);
		$file = BeaconCommon::FrameworkPath() . '/templates/' . $templateName . '.php';
		if (!file_exists($file)) {
			trigger_error('No such template ' . $file, E_USER_ERROR);
		}
		self::$templateName = $templateName;
	}
	
	public static function Finish(): void {
		if (ob_get_level() === 0 || is_null(self::$templateName)) {
			return;
		}
		
		$buffer = ob_get_contents();
		ob_end_clean();
		
		foreach (static::$headerLines as $line) {
			if (strpos($line, 'photoswipe.min.js') !== false) {
				static::$usePhotoswipe = true;
			}
		}
		
		$file = BeaconCommon::FrameworkPath() . '/templates/' . self::$templateName . '.php';
		require($file);
	}
	
	public static function Title(): string {
		if (self::$title !== '') {
			return self::$title;
		} else {
			return 'Beacon Server Manager';
		}
	}
	
	public static function SetTitle(string $title, bool $usePrefix = true): void {
		if ($usePrefix) {
			$title = 'Beacon: ' . $title;
		}
		self::$title = $title;
	}
	
	public static function AddHeaderLine(string $line): void {
		self::$headerLines[] = $line;
	}
	
	public static function ExtraHeaderLines(): array {
		$title = static::Title();
		$canonicalUrl = static::CanonicalUrl();
		$pageDescription = static::PageDescription();
		$isArticle = static::IsArticle();
		$heroUrl = static::HeroUrl();
		
		$metadata = [
			'<title>' . htmlentities($title) . '</title>',
			'<meta name="title" content="' . htmlentities($title) . '">',
			'<meta property="og:title" content="' . htmlentities($title) . '">',
			'<meta name="twitter:title" content="' . htmlentities($title) . '">',
			'<link rel="canonical" href="' . htmlentities($canonicalUrl) . '">',
			'<meta property="og:url" content="' . htmlentities($canonicalUrl) . '">',
			'<meta name="twitter:url" content="' . htmlentities($canonicalUrl) . '">',
			'<meta property="og:type" content="' . ($isArticle ? 'article' : 'website') . '">',
			'<meta name="twitter:card" content="summary_large_image">',
			'<meta property="og:image" content="' . htmlentities($heroUrl) . '">',
			'<meta name="twitter:image" content="' . htmlentities($heroUrl) . '">',
		];
		
		if (empty($pageDescription) === false) {
			$metadata[] = '<meta name="description" content="' . htmlentities($pageDescription) . '">';
			$metadata[] = '<meta property="og:description" content="' . htmlentities($pageDescription) . '">';
			$metadata[] = '<meta name="twitter:description" content="' . htmlentities($pageDescription) . '">';
		}
		
		$script = [];
		if (count(self::$scriptLines) > 0) {
			$script = self::$scriptLines;
			array_unshift($script, '<script nonce="' . htmlentities($_SERVER['CSP_NONCE']) . '">');
			$script[] = '</script>';
		}
		
		return array_merge($metadata, self::$headerLines, $script, static::$modules);
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
		self::$headerLines[] = '<link href="' . htmlentities(static::URLWithModificationTime($url)) . '" type="text/css" rel="stylesheet" nonce="' . $_SERVER['CSP_NONCE'] . '">';
	}
	
	public static function AddScript(string $url): void {
		self::$headerLines[] = '<script src="' . htmlentities(static::URLWithModificationTime($url)) . '" nonce="' . $_SERVER['CSP_NONCE'] . '"></script>';
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
			
			self::$scriptLines[] = $line;
		}
	}
	
	public static function StartModule(): void {
		ob_start();
	}
	
	public static function FinishModule(): void {
		$content = trim(ob_get_contents());
		ob_end_clean();
		
		$lines = explode("\n", $content);
		$linesBound = count($lines) - 1;
		
		if (str_starts_with(strtolower(trim($lines[0])), '<script') === true) {
			unset($lines[0]);
		}
		array_unshift($lines, '<script type="module" nonce="' . htmlentities($_SERVER['CSP_NONCE']) . '">');
		
		if (strtolower(trim($lines[$linesBound])) !== '</script>') {
			array_push($lines);
		}
		
		static::$modules[] = implode("\n", $lines);
	}
	
	// Just an alias
	public static function EndModule(): void {
		static::FinishModule();	
	}
	
	public static function StartModal(string $id): void {
		self::$currentModal = $id;
		ob_start();
	}
	
	public static function FinishModal(): void {
		$content = trim(ob_get_contents());
		ob_end_clean();
		
		$id = self::$currentModal;
		self::$currentModal = null;
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
		return static::$bodyClass;
	}
	
	public static function SetBodyClass(string $class_name): void {
		static::$bodyClass = $class_name;
	}
	
	public static function PageDescription(): string {
		return static::$pageDescription;
	}
	
	public static function SetPageDescription(string $pageDescription): void {
		static::$pageDescription = $pageDescription;
	}
	
	public static function CanonicalUrl(): string {
		if (empty(static::$canonicalUrl)) {
			return BeaconCommon::AbsoluteUrl($_SERVER['REQUEST_URI']);
		} else {
			return static::$canonicalUrl;
		}	
	}
	
	public static function SetCanonicalUrl(string $url, bool $redirectToCorrect = true): void {
		static::$canonicalUrl = $url;
		if ($redirectToCorrect && BeaconCommon::AbsoluteUrl($_SERVER['REQUEST_URI']) !== $url) {
			header('Location: ' . $url, true, 301);
			exit;
		}
	}
	
	public static function SetCanonicalPath(string $path, bool $redirectToCorrect = true): void {
		static::SetCanonicalUrl(BeaconCommon::AbsoluteURL($path), $redirectToCorrect);
	}
	
	public static function IsArticle(): bool {
		return static::$isArticle;
	}
	
	public static function SetIsArticle(bool $value): void {
		static::$isArticle = $value;
	}
	
	public static function HeroUrl(): string {
		if (empty(static::$heroUrl)) {
			static::$heroUrl = BeaconCommon::AbsoluteUrl(BeaconCommon::AssetUri('social-hero.png'));
		}
		return static::$heroUrl;
	}
	
	public static function SetHeroUrl(string $url): void {
		if (str_starts_with($url, 'https://') === false) {
			$url = BeaconCommon::AbsoluteUrl($url);
		}
		static::$heroUrl = $url;
	}
	
	public static function PhotoSwipeDOM(): void {
		if (!static::$usePhotoswipe) {
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
	
	public static function SetVar(string $varName, mixed $value): void {
		static::$extraVars[$varName] = $value;
	}
	
	public static function GetVar(string $varName): mixed {
		if (array_key_exists($varName, static::$extraVars)) {
			return static::$extraVars[$varName];
		} else {
			return null;
		}
	}
}

?>