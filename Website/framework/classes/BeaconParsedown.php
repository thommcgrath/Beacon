<?php

class BeaconParsedown extends Parsedown {
	protected bool $sanitizeLinks = false;

	public function sanitizeLinks(): bool {
		return $this->sanitizeLinks;
	}

	public function setSanitizeLinks(bool $sanitize): void {
		$this->sanitizeLinks = $sanitize;
	}

	protected function element(array $element) {
		if ($this->sanitizeLinks && isset($element['name']) && strtolower($element['name']) === 'a' && isset($element['attributes']['href'])) {
			$linkHref = $element['attributes']['href'];

			$url = parse_url($linkHref);
			$allowed = false;
			if ($url !== false && isset($url['host']) && isset($url['scheme'])) {
				$whitelist = [
					'^(?:.+\.)?usebeacon\.app$',
					'^(?:.+\.)?curseforge\.com$',
					'^(?:.+\.)?steamcommunity\.com$',
					'^(?:.+\.)?survivetheark\.com$',
					'^ark\.wiki\.gg$',
					'^(?:.+\.)?discord\.gg$',
				];
				foreach ($whitelist as $pattern) {
					if (preg_match("/{$pattern}/i", $url['host']) === 1) {
						$allowed = true;
						break;
					}
				}
			}
			if ($allowed) {
				if ($url['scheme'] !== 'https') {
					$element['attributes']['href'] = str_replace($url['scheme'] . '://', 'https://', $linkHref);
				}
				$element['attributes']['target'] = '_blank';
			} else {
				$element['name'] = 'span';
				$element['attributes'] = [
					'class' => 'removed-link',
				];
				$element['text'] = '[Link removed]';
			}
		}
		return parent::element($element);
	}
}

?>
