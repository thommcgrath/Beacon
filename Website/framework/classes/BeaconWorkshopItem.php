<?php

class BeaconWorkshopItem {
	const BASE_URL = 'https://steamcommunity.com/sharedfiles/filedetails/?id=';
	
	protected $mod_id;
	protected $name;
	protected $body;
	
	public static function URLForModID(int $mod_id) {
		return self::BASE_URL . $mod_id;
	}
	
	public static function Load(int $mod_id) {
		$http = curl_init();
		curl_setopt($http, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($http, CURLOPT_URL, self::URLForModID($mod_id));
		$body = curl_exec($http);
		curl_close($http);
		
		libxml_use_internal_errors(true);
		
		$dom = new DOMDocument;
		if (!@$dom->loadHTML($body)) {
			return null;
		}
		
		$description = $dom->getElementById('highlightContent');
		if ($description === null) {
			return null;
		}
		
		$xpath = new DOMXPath($dom);
		$breadcrumbs = $xpath->query("//div[@class='breadcrumbs']");
		$titles = $xpath->query("//div[@class='workshopItemTitle']");
		
		if ($breadcrumbs->length === 0) {
			return null;
		}
		$breadcrumbs = $breadcrumbs->item(0);
		$breadcrumbs_html = $breadcrumbs->ownerDocument->saveHTML($breadcrumbs);
		if (strpos($breadcrumbs_html, 'https://steamcommunity.com/app/346110') === false) {
			return null;
		}
		
		if ($titles->length === 0) {
			return null;
		}
		$title = $titles->item(0);
		$name = html_entity_decode($title->nodeValue);
		
		$description_html = $description->ownerDocument->saveHTML($description);
		
		$item = new self();
		$item->mod_id = $mod_id;
		$item->name = $name;
		$item->body = $description_html;
		return $item;
	}
	
	public function ModID() {
		return $this->mod_id;
	}
	
	public function Name() {
		return $this->name;
	}
	
	public function Body() {
		return $this->body;
	}
	
	public function ContainsString(string $needle) {
		return strpos($this->body, $needle) !== false;
	}
}

?>